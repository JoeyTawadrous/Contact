import UIKit
import CoreData

class CatchUps: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    struct ClassConstants {
        static let REASON = "Reason: "
    }
    
    var catchUps = [AnyObject]()
    var selectedPerson = String()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    /* MARK: Initialising          */
    /*******************************/
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(CatchUps.backgoundNofification(_:)), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil);
        
        refresh();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refresh();
    }
    
    func backgoundNofification(_ noftification:Notification){
        refresh();
    }
    
    func refresh() {
        let defaults = UserDefaults.standard
        selectedPerson = defaults.string(forKey: Constants.LocalData.SELECTED_PERSON)!
        
        catchUps = Utils.fetchCoreDataObject(Constants.CoreData.CATCHUP, predicate: selectedPerson)
        catchUps = catchUps.reversed() // newest first
        
        view.backgroundColor = Utils.getMainColor()
        tableView.backgroundColor = Utils.getNextTableColour(catchUps.count, reverse: false)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.reloadData()

    }
    
    
    /* MARK: Class Methods         */
    /*******************************/
    class func deleteCatchUp(_ catchUp: NSManagedObject) {
        let catchUpUUID = catchUp.value(forKey: Constants.CoreData.UUID) as! String
        
        
        // Remove notification for catchUp object & update app icon badge notification count
        for notification in UIApplication.shared.scheduledLocalNotifications!{
            let notificationUUID = notification.userInfo!["UUID"] as! String
            
            if (notificationUUID == catchUpUUID) {
                UIApplication.shared.cancelLocalNotification(notification)
                break
            }
        }
        CatchUps.setBadgeNumbers()
        
        
        // Remove catchUp object
        let managedObjectContect = Utils.fetchManagedObjectContext()
        managedObjectContect.delete(catchUp)
        
        do {
            try managedObjectContect.save()
        } catch {
            print(error)
        }
    }
    
    class func scheduleReminder(_ catchUp: NSManagedObject) {
        let notification = UILocalNotification() // create a new reminder notification
        notification.alertBody = "Don't forget: \(catchUp.value(forKey: Constants.CoreData.REASON) as! NSString)"
        notification.alertAction = "Open"
        notification.fireDate = Date().addingTimeInterval(30 * 60) // 30 minutes from current time
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["UUID": catchUp.value(forKey: Constants.CoreData.UUID)!]
        notification.category = Constants.LocalNotifications.ACTION_CATEGORY_IDENTIFIER

        UIApplication.shared.scheduleLocalNotification(notification)
    }
    
    class func setBadgeNumbers() {
        let notifications = UIApplication.shared.scheduledLocalNotifications // all scheduled notifications
        let catchUps = Utils.fetchCoreDataObject(Constants.CoreData.CATCHUP, predicate: "")
        
        UIApplication.shared.cancelAllLocalNotifications()
        
        
        // for every notification
        for notification in notifications! {
            
            for catchUp in catchUps {
                
                let catchUpUUID = catchUp.value(forKey: Constants.CoreData.UUID) as! String
                let notificationUUID = notification.userInfo!["UUID"] as! String
                
                
                if (notificationUUID == catchUpUUID) {
                    let overdueCatchUps = catchUps.filter({ (catchUp) -> Bool in
                        let when = catchUp.value(forKey: Constants.CoreData.WHEN) as! Date
                        let dateComparisionResult: ComparisonResult = notification.fireDate!.compare(when)
                        
                        return dateComparisionResult == ComparisonResult.orderedAscending
                    })
                    
                    notification.applicationIconBadgeNumber = overdueCatchUps.count                // set new badge number
                    UIApplication.shared.scheduleLocalNotification(notification)      // reschedule notification
                }
            }
        }
    }
    
    
    /* MARK: Class Outlets         */
    /*******************************/
    @IBAction func addCatchUp(_ sender: AnyObject) {
        let storyBoard : UIStoryboard = UIStoryboard(name: Constants.Common.MAIN_STORYBOARD, bundle:nil)
        let addCatchUpView = storyBoard.instantiateViewController(withIdentifier: Constants.Classes.ADD_CATCH_UP) as! AddCatchUp
        self.show(addCatchUpView as UIViewController, sender: addCatchUpView)
    }

    
    /* MARK: Table View            */
    /*******************************/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: CatchUpsTableViewCell! = tableView.dequeueReusableCell(withIdentifier: Constants.Common.CELL) as? CatchUpsTableViewCell
        if cell == nil {
            cell = CatchUpsTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: Constants.Common.CELL)
        }
        
        
        let catchUp = catchUps[indexPath.row]
        let type = catchUp.value(forKey: Constants.CoreData.TYPE) as! String?
        
        cell.reasonLabel!.text = catchUp.value(forKey: Constants.CoreData.REASON) as! String?
        
        
        if type == AddCatchUp.TypeOptions.PHONE_CALL {
            cell.thumbnailImageView!.image = UIImage(named: "phone.png")
        }
        else if type == AddCatchUp.TypeOptions.TEXT {
            cell.thumbnailImageView!.image = UIImage(named: "text.png")
        }
        else if type == AddCatchUp.TypeOptions.FACEBOOK {
            cell.thumbnailImageView!.image = UIImage(named: "facebook.png")
        }
        else if type == AddCatchUp.TypeOptions.TWITTER {
            cell.thumbnailImageView!.image = UIImage(named: "twitter.png")
        }
        else if type == AddCatchUp.TypeOptions.SKYPE {
            cell.thumbnailImageView!.image = UIImage(named: "skype.png")
        }
        else if type == AddCatchUp.TypeOptions.LINKEDIN {
            cell.thumbnailImageView!.image = UIImage(named: "linkedin.png")
        }
        else if type == AddCatchUp.TypeOptions.EMAIL {
            cell.thumbnailImageView!.image = UIImage(named: "email.png")
        }
        else if type == AddCatchUp.TypeOptions.OTHER {
            cell.thumbnailImageView!.image = UIImage(named: "other.png")
        }
        cell.thumbnailImageView!.image = cell.thumbnailImageView!.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        cell.thumbnailImageView!.tintColor = UIColor.white
        
        
        cell.backgroundColor = Utils.getNextTableColour(indexPath.row, reverse: false)
        cell.updateConstraints()
        
        
        // upon cell selection, bg color does not change to gray
        let customColorView = UIView()
        customColorView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = customColorView
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Mark Done") {action in
            let catchUp = self.catchUps[indexPath.row] as! NSManagedObject
            CatchUps.deleteCatchUp(catchUp)
            
            
            // Refresh table
            self.catchUps = Utils.fetchCoreDataObject(Constants.CoreData.CATCHUP, predicate: self.selectedPerson)
            self.catchUps = self.catchUps.reversed() // newest first
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.backgroundColor = Utils.getNextTableColour(self.catchUps.count, reverse: false)
            tableView.reloadData()
        }
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        // Set catchup in NSUserDefaults (so we can get catchup details it later)
        let defaults = UserDefaults.standard
        defaults.set(NSInteger(indexPath.row), forKey: Constants.LocalData.SELECTED_CATCHUP_INDEX)
        
        
        // Show CatchUp view
        let storyBoard : UIStoryboard = UIStoryboard(name: Constants.Common.MAIN_STORYBOARD, bundle:nil)
        let catchUpView = storyBoard.instantiateViewController(withIdentifier: Constants.Classes.CATCH_UP) as! CatchUp
        self.show(catchUpView as UIViewController, sender: catchUpView)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catchUps.count
    }
}

class CatchUpsTableViewCell : UITableViewCell {
    @IBOutlet var reasonLabel: UILabel?
    @IBOutlet var thumbnailImageView: UIImageView?
}
