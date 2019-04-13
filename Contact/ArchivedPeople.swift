//
//  ArchivedPeople.swift
//  Contact
//
//  Created by Stefan Stevanovic on 4/11/19.
//  Copyright © 2019 Joey Tawadrous. All rights reserved.
//

import UIKit
import CoreData
import SCLAlertView


class ArchivedPeople: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var archivedPeople = [AnyObject]()
    
    /* MARK: Init
     /////////////////////////////////////////// */
    override func viewWillAppear(_ animated: Bool) {
        archivedPeople = Utils.fetchCoreDataObject(Constants.CoreData.PERSON, predicate: "")
        archivedPeople = archivedPeople.filter { (person) -> Bool in
            return person.value(forKey: Constants.CoreData.ARCHIVED) as! Bool? ?? false
            
        }
        archivedPeople = archivedPeople.reversed() // newest first
        tableView.reloadData()
        
        // Styling
        Utils.insertGradientIntoView(viewController: self)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    /* MARK: Table Functionality
     /////////////////////////////////////////// */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: PeopleTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "cell") as? PeopleTableViewCell
        if cell == nil {
            cell = PeopleTableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cell")
        }
        let person = archivedPeople[indexPath.row]
        
        // Style
        cell!.selectionStyle = .none
        
        let name = person.value(forKey: Constants.CoreData.NAME) as! String?
        cell.personLabel!.text = name
        
        let catchups = Utils.fetchCoreDataObject(Constants.CoreData.CATCHUP, predicate: name!)
        cell.catchUpCountLabel!.text = String(catchups.count)
        
        let thumbnail = person.value(forKey: Constants.CoreData.THUMBNAIL) as! String?
        cell.thumbnailImageView!.image = UIImage(named: thumbnail!)
        cell.thumbnailImageView!.image = cell.thumbnailImageView!.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        cell.thumbnailImageView!.tintColor = UIColor.white
        
        cell.updateConstraints()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.delete) {
            
            // Delete catchups associated with this goal
            let catchups = Utils.fetchCoreDataObject(Constants.CoreData.CATCHUP, predicate: "")
            let person = archivedPeople[indexPath.row]
            let selectedPerson = person.value(forKey: Constants.CoreData.NAME) as! String?
            
            for catchup in catchups {
                if (selectedPerson == catchup.name) {
                    CatchUps.deleteCatchUp(catchup as! NSManagedObject)
                }
            }
            
            // Delete person
            let personToDelete = archivedPeople[indexPath.row]
            
            let managedObjectContect = Utils.fetchManagedObjectContext()
            managedObjectContect.delete(personToDelete as! NSManagedObject)
            
            do {
                try managedObjectContect.save()
            } catch {
                print(error)
            }
            
            archivedPeople = Utils.fetchCoreDataObject(Constants.CoreData.PERSON, predicate: "")
            archivedPeople = archivedPeople.reversed() // newest first
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Get selected person's name
        let cell = tableView.cellForRow(at: indexPath) as! PeopleTableViewCell
        let selectedPerson = cell.personLabel!.text
        
        // Set person's name in NSUserDefaults (so we can attach catch ups to it later)
        let defaults = UserDefaults.standard
        defaults.set(selectedPerson, forKey: Constants.LocalData.SELECTED_PERSON)
        defaults.set(indexPath.row, forKey: Constants.LocalData.SELECTED_PERSON_INDEX)
        
        // Show CatchUps view
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let catchUpsView = storyBoard.instantiateViewController(withIdentifier: Constants.Views.CATCH_UPS) as! CatchUps
        catchUpsView.cameFromArchived = true
        self.show(catchUpsView as UIViewController, sender: catchUpsView)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let emptyView = UIView(frame: CGRect(x:0, y:0, width:self.view.bounds.size.width, height:self.view.bounds.size.height))
        
        if archivedPeople.count == 0 {
            
            let emptyImageView = UIImageView(frame: CGRect(x:0, y:0, width:150, height:150))
            emptyImageView.center = CGPoint(x:self.view.frame.width / 2, y: self.view.bounds.size.height * 0.30)
            let emptyImage = Utils.imageResize(UIImage(named: "Other")!, sizeChange: CGSize(width: 150, height: 150)).withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            emptyImageView.image = emptyImage
            emptyImageView.tintColor = UIColor.white
            emptyView.addSubview(emptyImageView)
            
            let emptyLabel = UILabel(frame: CGRect(x:0, y:0, width:self.view.bounds.size.width - 100, height:self.view.bounds.size.height))
            emptyLabel.center = CGPoint(x:self.view.frame.width / 2, y: self.view.bounds.size.height * 0.53)
            emptyLabel.text = "Are you out of contact with you parents? How long has it been since you spoke to your best friend? Create a reminder to contact them now!"
            emptyLabel.font = UIFont.GothamProRegular(size: 15.0)
            emptyLabel.textAlignment = NSTextAlignment.center
            emptyLabel.textColor = UIColor.white
            emptyLabel.numberOfLines = 5
            emptyView.addSubview(emptyLabel)
            
            self.tableView.backgroundView = emptyView
            return 0
            
        }else{
            
            self.tableView.backgroundView = emptyView
            return archivedPeople.count
        }
    }
}
