import Foundation

class Constants {
    
    struct CoreData {
        static let CATCHUP = "CatchUp"
        static let PERSON = "Person"
        static let NAME = "name"
        static let REASON = "reason"
        static let THUMBNAIL = "thumbnail"
        static let TYPE = "type"
        static let WHEN = "when"
        static let UUID = "uuid"
    }
    
    struct LocalData {
        static let SELECTED_PERSON = "selectedPerson"
        static let SELECTED_CATCHUP_INDEX = "selectedCatchupIndex"
        static let SELECTED_PERSON_INDEX = "selectedPersonIndex"
        static let DATE_FORMAT = "h:mm a, d MMM, yyyy" // e.g. 4:30 PM, 28 March
    }
    
    struct LocalNotifications {
        static let ACTION_CATEGORY_IDENTIFIER = "ActionCategory"
    }
    
    struct Common {
        static let CELL = "cell"
        static let MAIN_STORYBOARD = "Main"
        static let SUBMIT = "Submit"
    }
    
    struct Classes {
        static let ADD_CATCH_UP = "AddCatchUp"
        static let CATCH_UP = "CatchUp"
        static let CATCH_UPS = "CatchUps"
    }
    
    struct IAP {
        static let PURCHASED_PRODUCTS = "PurchasedProducts"
        static let TRANSACTION_IN_PROGRESS = "TransactionInProgress"
        static let CURRENT_THEME = "CurrentTheme"
        static let COLORFUL_THEME = "Colorful Theme"
        static let GIRLY_THEME = "Girly Theme"
        static let MAKEUP_THEME = "Makeup Theme"
        static let MANLY_THEME = "Manly Theme"
        static let RAINBOW_THEME = "Rainbow Theme"
        static let ROYAL_THEME = "Royal Theme"
        static let SLIDE_THEME = "Slide Theme"
        static let STYLE_THEME = "Style Theme"
        static let TIDAL_THEME = "Tidal Theme"
        static let WAVE_THEME = "Wave Theme"
    }
}