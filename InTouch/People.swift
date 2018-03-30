import UIKit
import CoreData

class People: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    struct ClassConstants {
        static let ADD_PERSON_TITLE = "Add a New Person"
        static let ADD_PERSON_MESSAGE = "to keep in contact with!";
        static let ADD_PERSON_NAME = "Enter persons name";
    }
    
    var people = [AnyObject]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    /* MARK: Initialising          */
    /*******************************/
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        people = Utils.fetchCoreDataObject(Constants.CoreData.PERSON, predicate: "")
        people = people.reversed() // newest first
        
        view.backgroundColor = Utils.getMainColor()
        tableView.backgroundColor = Utils.getNextTableColour(people.count, reverse: false)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.reloadData()
    }
    
    
    /* MARK: Class Methods         */
    /*******************************/
    func savePerson(_ name: String, thumbnail: String) {
        let person = Utils.createObject(Constants.CoreData.PERSON)
        
        person.setValue(name, forKey: Constants.CoreData.NAME)
        person.setValue(thumbnail, forKey: Constants.CoreData.THUMBNAIL)
        Utils.saveObject()
        
        people.insert(person, at: 0)
        
        tableView.backgroundColor = Utils.getNextTableColour(people.count, reverse: false)
    }
    
    
    /* MARK: Class Outlets         */
    /*******************************/
    @IBAction func addPerson(_ sender: AnyObject) {
        let alert = SCLAlertView()
        let textField = alert.addTextField(ClassConstants.ADD_PERSON_NAME)
        alert.addButton(Constants.Common.SUBMIT) {
            if !textField.text!.isEmpty {
                self.savePerson(textField.text!, thumbnail: Utils.getRandomImageString())
                self.tableView.reloadData()
            }
        }
        alert.showEdit(ClassConstants.ADD_PERSON_TITLE, subTitle:ClassConstants.ADD_PERSON_MESSAGE)
    }
    
    
    /* MARK: Table View            */
    /*******************************/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: PeopleTableViewCell! = tableView.dequeueReusableCell(withIdentifier: Constants.Common.CELL) as? PeopleTableViewCell
        if cell == nil {
            cell = PeopleTableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: Constants.Common.CELL)
        }
        let person = people[indexPath.row]
        
        
        let name = person.value(forKey: Constants.CoreData.NAME) as! String?
        cell.personLabel!.text = name
        
        
        let catchUps = Utils.fetchCoreDataObject(Constants.CoreData.CATCHUP, predicate: name!)
        let catchUpsCount: Int = catchUps.count
        cell.catchUpCountLabel!.text = String(catchUpsCount)
        
        
        let thumbnail = person.value(forKey: Constants.CoreData.THUMBNAIL) as! String?
        cell.thumbnailImageView!.image = UIImage(named: thumbnail!)
        cell.thumbnailImageView!.image = cell.thumbnailImageView!.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        cell.thumbnailImageView!.tintColor = UIColor.white
        
        cell.outerCircleImageView!.image = UIImage(named: "circle2.png")
        cell.outerCircleImageView!.image = cell.outerCircleImageView!.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        cell.outerCircleImageView!.tintColor = UIColor.white
    
        cell.backgroundColor = Utils.getNextTableColour(indexPath.row, reverse: false)
        cell.updateConstraints()
        
        
        // upon cell selection, bg color does not change to gray
        let customColorView = UIView()
        customColorView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = customColorView
        

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.delete) {
            
            // Delete catchUps associated with this person
            let catchUps = Utils.fetchCoreDataObject(Constants.CoreData.CATCHUP, predicate: "")
            let person = people[indexPath.row]
            let selectedPerson = person.value(forKey: Constants.CoreData.NAME) as! String?
            
            for catchUp in catchUps {
                if (selectedPerson == catchUp.name) {
                    CatchUps.deleteCatchUp(catchUp as! NSManagedObject)
                }
            }
            
            
            // Now delete person
            let personToDelete = people[indexPath.row]
            
            let managedObjectContect = Utils.fetchManagedObjectContext()
            managedObjectContect.delete(personToDelete as! NSManagedObject)
            
            do {
                try managedObjectContect.save()
            } catch {
                print(error)
            }
            
            people = Utils.fetchCoreDataObject(Constants.CoreData.PERSON, predicate: "")
            people = people.reversed() // newest first
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.backgroundColor = Utils.getNextTableColour(people.count, reverse: false)
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
        let storyBoard : UIStoryboard = UIStoryboard(name: Constants.Common.MAIN_STORYBOARD, bundle:nil)
        let catchUpsView = storyBoard.instantiateViewController(withIdentifier: Constants.Classes.CATCH_UPS) as! CatchUps
        self.show(catchUpsView as UIViewController, sender: catchUpsView)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
}


class PeopleTableViewCell : UITableViewCell {
    @IBOutlet var personLabel: UILabel?
    @IBOutlet var catchUpCountLabel: UILabel?
    @IBOutlet var thumbnailImageView: UIImageView?
    @IBOutlet var outerCircleImageView: UIImageView?
}

