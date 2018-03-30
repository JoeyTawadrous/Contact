import Foundation
import CoreData

class CatchUp: UIViewController {
    
    @IBOutlet var titleButton: UIBarButtonItem?
    @IBOutlet var reasonLabel: UILabel?
    @IBOutlet var personThumbnail: UIImageView?
    @IBOutlet var dateLabel: UILabel?
    @IBOutlet var timeLabel: UILabel?
    @IBOutlet var typeLabel: UILabel?
    @IBOutlet var thumbnailImageView: UIImageView?
    @IBOutlet var markDoneButton: UIButton?
    
    
    /* MARK: Initialising          */
    /*******************************/
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard
        var people = Utils.fetchCoreDataObject(Constants.CoreData.PERSON, predicate: "")
        people = people.reversed()
        let selectedPerson = defaults.string(forKey: Constants.LocalData.SELECTED_PERSON)!
        let selectedPersonIndex = defaults.integer(forKey: Constants.LocalData.SELECTED_PERSON_INDEX)
        let selectedCatchUpIndex = defaults.integer(forKey: Constants.LocalData.SELECTED_CATCHUP_INDEX)
        var catchUps = Utils.fetchCoreDataObject(Constants.CoreData.CATCHUP, predicate: selectedPerson)
        catchUps = catchUps.reversed()
        let borderWidth = CGFloat(3.5)
        
        
        // set reason
        self.reasonLabel?.text = catchUps[selectedCatchUpIndex].value(forKey: Constants.CoreData.REASON) as! String?
        self.reasonLabel!.layer.borderWidth = borderWidth
        self.reasonLabel!.layer.borderColor = UIColor.white.cgColor
        
        
        // set person thumbnail
        let thumbnailFile = people[selectedPersonIndex].value(forKey: Constants.CoreData.THUMBNAIL) as! String?
        self.personThumbnail!.image = UIImage(named: thumbnailFile!)
        personThumbnail!.image! = imageResize(personThumbnail!.image!, sizeChange: CGSize(width: 45, height: 45))
        
        self.personThumbnail!.image = self.personThumbnail!.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.personThumbnail!.tintColor = UIColor.white
        self.personThumbnail!.layer.borderWidth = borderWidth;
        self.personThumbnail!.layer.borderColor = UIColor.white.cgColor
        
        
        // set date label
        let when = catchUps[selectedCatchUpIndex].value(forKey: Constants.CoreData.WHEN) as! Date?
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.LocalData.DATE_FORMAT
        let formattedWhen = dateFormatter.string(from: when!)
        let whenArray = formattedWhen.characters.split{$0 == ","}.map(String.init)
        self.dateLabel?.text = getDayOfWeek(formattedWhen)! + ", " + whenArray[1]
        self.dateLabel!.layer.borderWidth = borderWidth;
        self.dateLabel!.layer.borderColor = UIColor.white.cgColor
        
        
        // set time label
        self.timeLabel?.text = whenArray[0]
        self.timeLabel!.layer.borderWidth = borderWidth;
        self.timeLabel!.layer.borderColor = UIColor.white.cgColor
        
        
        // set type
        let type = catchUps[selectedCatchUpIndex].value(forKey: Constants.CoreData.TYPE) as! String?
        self.typeLabel?.text = type!.uppercased()
        self.typeLabel!.layer.borderWidth = borderWidth;
        self.typeLabel!.layer.borderColor = UIColor.white.cgColor
        
        
        // set type thumbnail
        if type == AddCatchUp.TypeOptions.PHONE_CALL {
            self.thumbnailImageView!.image = UIImage(named: "phone.png")
        }
        else if type == AddCatchUp.TypeOptions.TEXT {
            self.thumbnailImageView!.image = UIImage(named: "text.png")
        }
        else if type == AddCatchUp.TypeOptions.FACEBOOK {
            self.thumbnailImageView!.image = UIImage(named: "facebook.png")
        }
        else if type == AddCatchUp.TypeOptions.TWITTER {
            self.thumbnailImageView!.image = UIImage(named: "twitter.png")
        }
        else if type == AddCatchUp.TypeOptions.SKYPE {
            self.thumbnailImageView!.image = UIImage(named: "skype.png")
        }
        else if type == AddCatchUp.TypeOptions.LINKEDIN {
            self.thumbnailImageView!.image = UIImage(named: "linkedin.png")
        }
        else if type == AddCatchUp.TypeOptions.EMAIL {
            self.thumbnailImageView!.image = UIImage(named: "email.png")
        }
        else if type == AddCatchUp.TypeOptions.OTHER {
            self.thumbnailImageView!.image = UIImage(named: "other.png")
        }
        thumbnailImageView!.image! = imageResize(thumbnailImageView!.image!, sizeChange: CGSize(width: 40, height: 40))
        
        self.thumbnailImageView!.image = self.thumbnailImageView!.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.thumbnailImageView!.tintColor = UIColor.white
        self.thumbnailImageView!.layer.borderWidth = borderWidth;
        self.thumbnailImageView!.layer.borderColor = UIColor.white.cgColor
        
        
        // set title button
        self.titleButton?.title = type! + " @ " + whenArray[0]
        
        // style mark done button
        self.markDoneButton!.layer.cornerRadius = 5
        self.markDoneButton!.setTitleColor(Utils.getNextTableColour(selectedCatchUpIndex, reverse: false), for: UIControlState())
        
        
        self.view.backgroundColor = Utils.getNextTableColour(selectedCatchUpIndex, reverse: false)
    }
    
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


func imageResize (_ image:UIImage, sizeChange:CGSize) -> UIImage{
    
    let hasAlpha = true
    let scale: CGFloat = 0.0 // Use scale factor of main screen
    
    UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
    image.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
    
    let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
    return scaledImage!
}


func getDayOfWeek(_ date:String) -> String? {
    let formatter  = DateFormatter()
    formatter.dateFormat = Constants.LocalData.DATE_FORMAT
    if let todayDate = formatter.date(from: date) {
        let myCalendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let myComponents = (myCalendar as NSCalendar).components(.weekday, from: todayDate)
        let weekDay = myComponents.weekday
        switch weekDay {
        case 1:
            return "Saturday"
        case 2:
            return "Sunday"
        case 3:
            return "Monday"
        case 4:
            return "Tuesday"
        case 5:
            return "Wednesday"
        case 6:
            return "Thursday"
        case 7:
            return "Friday"
        default:
            print("Error fetching days")
            return "Day"
        }
    } else {
        return nil
    }
}
