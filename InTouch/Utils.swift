import UIKit
import CoreData

class Utils {
    
    /* MARK: Core Data Utils          */
    /**********************************/
    class func createObject(_ type: String) -> NSManagedObject {
        let entity = NSEntityDescription.entity(forEntityName: type, in: fetchManagedObjectContext())
        let object = NSManagedObject(entity: entity!, insertInto:fetchManagedObjectContext())
        return object;
    }
    
    class func saveObject() {
        do {
            try fetchManagedObjectContext().save()
        } catch {
            print("Could not save \(error)")
        }
    }
    
    class func fetchCoreDataObject(_ key: String, predicate: String) -> [AnyObject] {
        var fetchedResults = [AnyObject]()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: key)
        
        if predicate != "" {
            fetchRequest.predicate = NSPredicate(format:"name == %@", predicate)
        }
        
        do {
            fetchedResults = try managedContext.fetch(fetchRequest)
        } catch {
            print(error)
        }
        
        return fetchedResults
    }
    
    class func fetchManagedObjectContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        return managedContext
    }
    
    
    
    /* MARK: Utils                 */
    /*******************************/
    class func getMainColor() -> UIColor {
        return UIColor(hexString: "#2C3E50")
    }
    
    class func getNextTableColour(_ number: Int, reverse: DarwinBoolean) -> UIColor {
        var number = number
        
        var theme1 = [String]() // rainbow
        theme1.append("#e53c52")
        theme1.append("#e9543f")
        theme1.append("#f8c543")
        theme1.append("#90ce55")
        theme1.append("#50c89d")
        
        var theme2 = [String]()
        theme2.append("#311e3e") // slide
        theme2.append("#512645")
        theme2.append("#87314e")
        theme2.append("#df405a")
        theme2.append("#F08A5D")
        
        var theme3 = [String]() // tidal
        theme3.append("#513B56")
        theme3.append("#525174")
        theme3.append("#348AA7")
        theme3.append("#5DD39E")
        theme3.append("#BCE784")
        
        var theme4 = [String]() // makeup
        theme4.append("#6D6875")
        theme4.append("#B5838D")
        theme4.append("#E5989B")
        theme4.append("#FFB4A2")
        theme4.append("#FFCDB2")
        
        var theme5 = [String]() // wave
        theme5.append("#5D4370")
        theme5.append("#605398")
        theme5.append("#4A7EB7")
        theme5.append("#4FA3D2")
        theme5.append("#43CBC7")
        
        var theme6 = [String]() // girly
        theme6.append("#9C89B8")
        theme6.append("#F0A6CA")
        theme6.append("#EFC3E6")
        theme6.append("#B8BEDD")
        theme6.append("#CEE7E6")
        
        var theme7 = [String]() // manly
        theme7.append("#0B2545")
        theme7.append("#3D315B")
        theme7.append("#444B6E")
        theme7.append("#708B75")
        theme7.append("#9AB87A")
        
        var theme8 = [String]() // royal
        theme8.append("#8D3B72")
        theme8.append("#BD4F6C")
        theme8.append("#D7816A")
        theme8.append("#F0CF65")
        theme8.append("#93B5C6")
        
        var theme9 = [String]() // colorful
        theme9.append("#3A86FF")
        theme9.append("#8338EC")
        theme9.append("#FF006E")
        theme9.append("#FB5607")
        theme9.append("#FFBE0B")
        
        var theme10 = [String]() // style
        theme10.append("#e56eb2")
        theme10.append("#9b7be7")
        theme10.append("#4c87e7")
        theme10.append("#42b3e3")
        theme10.append("#50c89d")
        
        
        var colors = theme8 // Royal by default
        let currentTheme = UserDefaults.standard.string(forKey: Constants.IAP.CURRENT_THEME)
        
        if currentTheme == Constants.IAP.COLORFUL_THEME {
            colors = theme9
        }
        else if currentTheme == Constants.IAP.GIRLY_THEME {
            colors = theme6
        }
        else if currentTheme == Constants.IAP.MAKEUP_THEME {
            colors = theme4
        }
        else if currentTheme == Constants.IAP.MANLY_THEME {
            colors = theme7
        }
        else if currentTheme == Constants.IAP.RAINBOW_THEME {
            colors = theme1
        }
        else if currentTheme == Constants.IAP.ROYAL_THEME {
            colors = theme8
        }
        else if currentTheme == Constants.IAP.SLIDE_THEME {
            colors = theme2
        }
        else if currentTheme == Constants.IAP.STYLE_THEME {
            colors = theme10
        }
        else if currentTheme == Constants.IAP.TIDAL_THEME {
            colors = theme3
        }
        else if currentTheme == Constants.IAP.WAVE_THEME {
            colors = theme5
        }
        
        
        if reverse.boolValue {
            colors = colors.reversed()
        }
        
        while number >= colors.count {
            number = number - colors.count
        }
        
        
        var color = UIColor(rgba: MaterialColors.Red.A200.HUE)
        
        if number == 0 {
            color = UIColor(hexString: colors[0])
        }
        else if number == 1 {
            color = UIColor(hexString: colors[1])
        }
        else if number == 2 {
            color = UIColor(hexString: colors[2])
        }
        else if number == 3 {
            color = UIColor(hexString: colors[3])
        }
        else if number == 4 {
            color = UIColor(hexString: colors[4])
        }
        
        
        return color;
    }
    
    class func getRandomImageString() -> String {
        var imageArray:[String] = []
        
        for i in 1...54 {
            let image = String(i) + ".png"
            imageArray.append(image)
        }
        
        let randomImageIndex = Int(arc4random_uniform(UInt32(imageArray.count)))
        return imageArray[randomImageIndex]
    }
}


open class RoundedButton: UIButton {
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 5
        self.backgroundColor = Utils.getMainColor()
    }
}


extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
