import UIKit
import CoreData
import SCLAlertView


class People: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    struct ClassConstants {
        static let ADD_PERSON_TITLE = "Add a New Person"
        static let ADD_PERSON_MESSAGE = "to keep in contact with!";
        static let ADD_PERSON_NAME = "Enter persons name";
    }
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet var addButton: UIBarButtonItem!
	@IBOutlet var achievementsButton: UIBarButtonItem!
	@IBOutlet var menuButton: UIBarButtonItem!
    
    var people = [AnyObject]()
	
	
    
	/* MARK: Init
	/////////////////////////////////////////// */
    override func viewWillAppear(_ animated: Bool) {
		people = Utils.fetchCoreDataObject(Constants.CoreData.PERSON, predicate: "")
		people = people.reversed() // newest first
		tableView.reloadData()
		
		// Demo data
//		if people.count == 0 {
//			people = Utils.createDemoData()
//		}
		
		// Styling
		Utils.insertGradientIntoView(viewController: self)
		Utils.createFontAwesomeBarButton(button: addButton, icon: .plus, style: .solid)
		Utils.createFontAwesomeBarButton(button: achievementsButton, icon: .gem, style: .solid)
		Utils.createFontAwesomeBarButton(button: menuButton, icon: .bars, style: .solid)
		tableView.separatorStyle = UITableViewCellSeparatorStyle.none
	}
	
	override var prefersStatusBarHidden: Bool {
		return true
	}
	
	
	
	/* MARK: Button Actions
	/////////////////////////////////////////// */
	@IBAction func addPerson(_ sender: AnyObject) {
		let appearance = SCLAlertView.SCLAppearance(
			kCircleHeight: 100.0,
			kCircleIconHeight: 60.0,
			kTitleTop: 62.0,
			showCloseButton: false
		)
		
		let alertView = SCLAlertView(appearance: appearance)
		let alertViewIcon = UIImage(named: "trophy")
		let textField = alertView.addTextField(ClassConstants.ADD_PERSON_NAME)
		
		alertView.addButton(Constants.Strings.ALERT_DIALOG_SUBMIT) {
			if !textField.text!.isEmpty {
				self.people.insert(Utils.createPerson(name: textField.text!), at: 0)
				self.tableView.reloadData()
				
				
				// Achievements
				var totalPeopleMet = Utils.double(key: Constants.Defaults.APP_DATA_TOTAL_PEOPLE_MET)
				totalPeopleMet = totalPeopleMet + 1
				Utils.set(key: Constants.Defaults.APP_DATA_TOTAL_PEOPLE_MET, value: totalPeopleMet)
				
				var totalPoints = Utils.double(key: Constants.Defaults.APP_DATA_TOTAL_POINTS)
				totalPoints = totalPoints + 3
				Utils.set(key: Constants.Defaults.APP_DATA_TOTAL_POINTS, value: totalPoints)
				
				// Has the user reached an achievement?
				ProgressManager.checkAndSetAchievementReached(view: self, type: Constants.Achievements.POINTS_TYPE)
				ProgressManager.checkAndSetAchievementReached(view: self, type: Constants.Achievements.PEOPLE_TYPE)
				
				let points = Utils.int(key: Constants.Defaults.APP_DATA_TOTAL_POINTS)
				if(ProgressManager.shouldLevelUp(points: (points - 3))) {
					Dialogs.showLevelUpDialog(view: self, level: ProgressManager.getLevel(points: (points - 3)))
				}
			}
		}
		alertView.addButton(Constants.Strings.ALERT_DIALOG_CLOSE) {}
		
		alertView.showCustom(ClassConstants.ADD_PERSON_TITLE, subTitle: ClassConstants.ADD_PERSON_MESSAGE, color: Utils.getMainColor(), icon: alertViewIcon!, animationStyle: .leftToRight)
	}
	
	@IBAction func achievementsButtonPressed(_ sender: AnyObject) {
		Utils.presentView(self, viewName: Constants.Views.ACHIEVEMENTS)
	}
	
	@IBAction func menuButtonPressed(_ sender: AnyObject) {
		Utils.presentView(self, viewName: Constants.Views.SETTINGS_NAV_CONTROLLER)
	}
	
	
	
	/* MARK: Table Functionality
	/////////////////////////////////////////// */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell: PeopleTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "cell") as? PeopleTableViewCell
		if cell == nil {
			cell = PeopleTableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cell")
		}
		let person = people[indexPath.row]
		
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
			let person = people[indexPath.row]
			let selectedPerson = person.value(forKey: Constants.CoreData.NAME) as! String?
			
			for catchup in catchups {
				if (selectedPerson == catchup.name) {
					CatchUps.deleteCatchUp(catchup as! NSManagedObject)
				}
			}
			
			// Delete person
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
        self.show(catchUpsView as UIViewController, sender: catchUpsView)
    }
	
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74.0
    }
	
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if people.count == 0 {
			let emptyView = UIView(frame: CGRect(x:0, y:0, width:self.view.bounds.size.width, height:self.view.bounds.size.height))
			
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
		}
		else {
			return people.count
		}
    }
}


class PeopleTableViewCell : UITableViewCell {
    @IBOutlet var personLabel: UILabel?
    @IBOutlet var catchUpCountLabel: UILabel?
    @IBOutlet var thumbnailImageView: UIImageView?
}
