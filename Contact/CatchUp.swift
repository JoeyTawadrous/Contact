import Foundation
import CoreData
import UIKit


class CatchUp: UIViewController {
    
    @IBOutlet var titleButton: UIBarButtonItem?
    @IBOutlet var reasonLabel: UILabel?
    @IBOutlet var personImageView: UIImageView?
    @IBOutlet var dateLabel: UILabel?
    @IBOutlet var timeLabel: UILabel?
    @IBOutlet var typeLabel: UILabel?
    @IBOutlet var catchUpImageView: UIImageView?
    @IBOutlet var markDoneButton: UIButton?
    
	
	
	/* MARK: Init
	/////////////////////////////////////////// */
    override func viewWillAppear(_ animated: Bool) {
		let defaults = UserDefaults.standard
		var people = Utils.fetchCoreDataObject(Constants.CoreData.PERSON, predicate: "")
		people = people.reversed()
		
		let selectedPerson = defaults.string(forKey: Constants.LocalData.SELECTED_PERSON)!
		let selectedPersonIndex = defaults.integer(forKey: Constants.LocalData.SELECTED_PERSON_INDEX)
		let selectedCatchUpIndex = defaults.integer(forKey: Constants.LocalData.SELECTED_CATCHUP_INDEX)
		var catchUps = Utils.fetchCoreDataObject(Constants.CoreData.CATCHUP, predicate: selectedPerson)
		catchUps = catchUps.reversed()
		
		// Styling
		Utils.insertGradientIntoView(viewController: self)
		
        // Reason label
        reasonLabel?.text = "\"" + (catchUps[selectedCatchUpIndex].value(forKey: Constants.CoreData.REASON) as! String?)! + "\""
		
        // Person thumbnail
        let thumbnailFile = people[selectedPersonIndex].value(forKey: Constants.CoreData.THUMBNAIL) as! String?
		personImageView!.image = UIImage(named: thumbnailFile!)
		personImageView!.image! = Utils.imageResize(personImageView!.image!, sizeChange: CGSize(width: 45, height: 45)).withRenderingMode(UIImageRenderingMode.alwaysTemplate)
		personImageView!.tintColor = UIColor.white
		
        // Date label
        let when = catchUps[selectedCatchUpIndex].value(forKey: Constants.CoreData.WHEN) as! Date?
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.LocalData.DATE_FORMAT
        let formattedWhen = dateFormatter.string(from: when!)
        let whenArray = formattedWhen.characters.split{$0 == ","}.map(String.init)
        dateLabel?.text = Utils.getDayOfWeek(formattedWhen)! + ", " + whenArray[1]
		
        // Time label
        timeLabel?.text = whenArray[0]
		
        // Type label
        let type = catchUps[selectedCatchUpIndex].value(forKey: Constants.CoreData.TYPE) as! String?
        typeLabel?.text = type!.uppercased()
		
        // Type thumbnail
		catchUpImageView!.image = UIImage(named: type!)
		catchUpImageView!.image! = Utils.imageResize(catchUpImageView!.image!, sizeChange: CGSize(width: 40, height: 40)).withRenderingMode(UIImageRenderingMode.alwaysTemplate)
		catchUpImageView!.tintColor = UIColor.white
		
        // Title bar button
		titleButton?.title = Utils.getDayOfWeek(formattedWhen)! + ", " + whenArray[1] + " @ " + whenArray[0]
        
        // Complete button
		markDoneButton!.layer.cornerRadius = 3
		markDoneButton!.setTitleColor(Utils.getMainColor(), for: UIControlState())
    }
	
	
	
	/* MARK: Button Actions
	/////////////////////////////////////////// */
    @IBAction func markDoneButtonTapped(_ sender : UIButton!) {
        sender.isEnabled = false
		
        let defaults = UserDefaults.standard
        let selectedPerson = defaults.string(forKey: Constants.LocalData.SELECTED_PERSON)!
        let selectedCatchUpIndex = defaults.integer(forKey: Constants.LocalData.SELECTED_CATCHUP_INDEX)
        var catchUps = Utils.fetchCoreDataObject(Constants.CoreData.CATCHUP, predicate: selectedPerson)
        let catchUp = catchUps[selectedCatchUpIndex] as! NSManagedObject
        CatchUps.deleteCatchUp(catchUp)

        navigationController?.popViewController(animated: true)
    }
}
