import UIKit
import CoreData


class AddCatchUp: FormViewController {
    
    struct FormPlaceholders {
        static let REASON_WHEN_NIL = "Time to CatchUp!"
    }

    struct FormTitles {
        static let FORM_TITLE = "Add Catch Up"
        static let REASON_TITLE = "Reason"
        static let WHEN_TITLE = "When"
        static let TYPE_TITLE = "Type"
    }
    
    struct FormTypes {
        static let DATE = "date"
        static let REASON = "reason"
        static let TYPE = "type"
    }
    
    struct TypeOptions {
        static let PHONE_CALL = "Phone Call"
        static let TEXT = "Text Message"
        static let FACEBOOK = "Facebook"
        static let TWITTER = "Twitter"
        static let SKYPE = "Skype Call"
        static let LINKEDIN = "LinkedIn"
        static let EMAIL = "Email"
        static let OTHER = "Other"
    }
    
    var type: FormRowDescriptor!
    var date: FormRowDescriptor!
    var reason: FormRowDescriptor!
    var selectedPerson = String()
	
	
    
	/* MARK: Init
	/////////////////////////////////////////// */
    override func viewDidLoad() {
        // set view bg color
        let defaults = UserDefaults.standard
        selectedPerson = defaults.string(forKey: Constants.LocalData.SELECTED_PERSON)!
        let catchUps = Utils.fetchCoreDataObject(Constants.CoreData.CATCHUP, predicate: selectedPerson)
        self.view.backgroundColor = Utils.getMainColor()
        
        // disable scroll
        tableView.alwaysBounceVertical = false;
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadForm()
    }
	
	
	
	/* MARK: Core Functionality
	/////////////////////////////////////////// */
    fileprivate func loadForm() {
        let form = FormDescriptor(title: FormTitles.FORM_TITLE)
        let section = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
        
        // Type
        type = FormRowDescriptor(tag: FormTypes.TYPE, rowType: .picker, title: FormTitles.TYPE_TITLE)
        type.configuration[FormRowDescriptor.Configuration.Options] = [TypeOptions.PHONE_CALL, TypeOptions.TEXT, TypeOptions.FACEBOOK, TypeOptions.TWITTER, TypeOptions.SKYPE, TypeOptions.LINKEDIN, TypeOptions.EMAIL, TypeOptions.OTHER]
        type.configuration[FormRowDescriptor.Configuration.TitleFormatterClosure] = { value in
            switch( value ) {
				//TODO
//				case TypeOptions.PHONE_CALL:
//					return TypeOptions.PHONE_CALL
//				case TypeOptions.TEXT:
//					return TypeOptions.TEXT
//				case TypeOptions.FACEBOOK:
//					return TypeOptions.FACEBOOK
//				case TypeOptions.TWITTER:
//					return TypeOptions.TWITTER
//				case TypeOptions.SKYPE:
//					return TypeOptions.SKYPE
//				case TypeOptions.LINKEDIN:
//					return TypeOptions.LINKEDIN
//				case TypeOptions.EMAIL:
//					return TypeOptions.EMAIL
//				case TypeOptions.OTHER:
//					return TypeOptions.OTHER
				default:
					return nil
                }
            } as TitleFormatterClosure
        type.value = TypeOptions.PHONE_CALL as NSObject?
        type.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["backgroundColor" : UIColor.clear]
        section.addRow(type)
		
        // Date and time
        date = FormRowDescriptor(tag: FormTypes.DATE, rowType: .dateAndTime, title: FormTitles.WHEN_TITLE)
        date.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["backgroundColor" : UIColor.clear]
        section.addRow(date)
        
        // Reason
        reason = FormRowDescriptor(tag: FormTypes.REASON, rowType: .text, title: FormTitles.REASON_TITLE)
        reason.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : FormPlaceholders.REASON_WHEN_NIL, "textField.textAlignment" : NSTextAlignment.right.rawValue, "backgroundColor" : UIColor.clear]
        section.addRow(reason)
        
        form.sections = [section]
        self.form = form
    }
    
	
	
	/* MARK: Actions
	/////////////////////////////////////////// */
    @IBAction func add(_ sender: AnyObject) {
        let typeValue = type.value
        var whenValue = date.value as! Date?
        var reasonValue = reason.value
        let uuid = UUID().uuidString

        // Make sure no nil values
        let today = Date()
        let tomorrow = (Calendar.current as NSCalendar).date(
            byAdding: .day,
            value: 1,
            to: today,
            options: NSCalendar.Options(rawValue: 0))
        if whenValue == nil { whenValue = tomorrow }
        if reasonValue == nil { reasonValue = FormPlaceholders.REASON_WHEN_NIL as NSObject? }
		
        let catchUp = Utils.createObject(Constants.CoreData.CATCHUP)
        catchUp.setValue(selectedPerson, forKey: Constants.CoreData.NAME)
        catchUp.setValue(typeValue, forKey: Constants.CoreData.TYPE)
        catchUp.setValue(whenValue, forKey: Constants.CoreData.WHEN)
        catchUp.setValue(reasonValue, forKey: Constants.CoreData.REASON)
        catchUp.setValue(uuid, forKey: Constants.CoreData.UUID);
        Utils.saveObject()
        
        // Create local notification
        let notification = UILocalNotification()
        notification.alertBody = "\(selectedPerson): \(reasonValue as! NSString)" // text that will be displayed in the notification
        notification.alertAction = "Open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
        notification.fireDate = whenValue // NOTE: dates in the past, chosen by the user, will not create a notification
        notification.soundName = UILocalNotificationDefaultSoundName // play default sound
        notification.userInfo = ["UUID": uuid]
        notification.category = Constants.LocalNotifications.ACTION_CATEGORY_IDENTIFIER
        UIApplication.shared.scheduleLocalNotification(notification)
		
        CatchUps.setBadgeNumbers()
		
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
