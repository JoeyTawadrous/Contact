import Foundation


class Constants {
	
	struct Colors {
		static let BLUE = "69CDFC"
		static let GREEN = "2ecc71"
		static let PURPLE = "B0B1F1"
		static let PRIMARY_TEXT_GRAY = "5D5D5C"
	}
	
	
	struct Core {
		static let APP_ID = "1101260252"
		static let APPNAME = "Contact"
	}
	
	
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
	
	
	struct Design {
		static let LOGO = "AppIcon"
	}
	
	
	struct Defaults {
		static let CURRENT_THEME = "CurrentTheme"
		static let PURCHASED_THEMES = "PurchasedThemes"
		static let USER_HAS_MONTHLY_SUBSCRIPTION = "userHasMonthlySubscription"
		static let USER_HAS_YEARLY_SUBSCRIPTION = "userHasYearlySubscription"
		static let USER_HAS_UNLOCKED_APP = "userHasUnlockedApp"
	}
	
	
    struct LocalData {
        static let SELECTED_PERSON = "selectedPerson"
		static let SELECTED_PERSON_INDEX = "selectedPersonIndex"
        static let SELECTED_CATCHUP_INDEX = "selectedCatchupIndex"
        static let DATE_FORMAT = "h:mm a, d MMM, yyyy" // e.g. 4:30 PM, 28 March
    }
	
	
	struct LocalNotifications {
		static let ACTION_CATEGORY_IDENTIFIER = "ActionCategory"
		static let DONE_ACTION_IDENTIFIER = "DoneAction"
		static let DONE_ACTION_TITLE = "Complete"
		static let REMIND_ACTION_IDENTIFIER = "RemindAction"
		static let REMIND_ACTION_TITLE = "Remind in 30 minutes"
	}
	
	
	struct Purchases {
		// Upgrade
		static let SHARED_SECRET = "ea29ddfb50ff4cb78541da647f34a007"
		static let SUBSCRIPTION_MONTHLY_KEY = "com.joeyt.contact.subscription.monthly"
		static let SUBSCRIPTION_YEARLY_KEY = "com.joeyt.contact.subscription.yearly"
		static let UNLOCK_KEY = "com.joeyt.contact.unlock"
		
		// Themes
		static let THEME_ID_PREFIX = "com.joeyt.contact.iap.theme."
		static let GRASSY_THEME = "grassy"
		static let SUNRISE_THEME = "sunrise"
		static let NIGHTLIGHT_THEME = "nightlight"
		static let SALVATION_THEME = "salvation"
		static let RIPE_THEME = "ripe"
		static let MALIBU_THEME = "malibu"
		static let LIFE_THEME = "life"
		static let FIRE_THEME = "fire"
		
		static let Colors: [String : [String]] = [
			GRASSY_THEME: ["009efd", "2af598"],
			SUNRISE_THEME: ["f6d365", "fda085"],
			NIGHTLIGHT_THEME: ["a18cd1", "fbc2eb"],
			SALVATION_THEME: ["f43b47", "453a94"],
			RIPE_THEME: ["f093fb", "f5576c"],
			MALIBU_THEME: ["4facfe", "00f2fe"],
			LIFE_THEME: ["43e97b", "38f9d7"],
			FIRE_THEME: ["fa709a", "fee140"]
		]
	}
	
	
	struct Strings {
		// Dialog: Alert
		static let ALERT_SUBMIT = "Submit"
		static let ALERT_CLOSE = "Close"
		
		
		// Links
		static let LINK_APP_REVIEW = "itms-apps://itunes.apple.com/app/apple-store/id" + Core.APP_ID + "?action=write-review"
		static let LINK_FACEBOOK = "https://www.facebook.com/getlearnable"
		static let LINK_INSTAGRAM = "https://www.instagram.com/learnableapp"
		static let LINK_IOS_STORE = "https://itunes.apple.com/gb/app/contact-remember-your-friends/id1101260252?mt=8"
		static let LINK_LEARNABLE_IOS_STORE = "https://itunes.apple.com/gb/app/learnable-learn-to-code-from-scratch-level-up/id1254862243?mt=8"
		static let LINK_TWITTER = "https://twitter.com/getlearnable"
		static let LINK_WEB = "http://www.getlearnable.com"
		
		
		// Purchases: Strings
		static let PURCHASE_ERROR_CONTACT_US = " Please contact us."
		static let PURCHASE_ERROR_NOT_AVAILABLE = "The product is not available in the current storefront." + PURCHASE_ERROR_CONTACT_US
		static let PURCHASE_ERROR_IDENTIFIER_INVALID = "The purchase identifier was invalid." + PURCHASE_ERROR_CONTACT_US
		static let PURCHASE_ERROR_CANCELLED = "Your payment was cancelled." + PURCHASE_ERROR_CONTACT_US
		static let PURCHASE_ERROR_NOT_ALLOWED = "You are not allowed to make payments." + PURCHASE_ERROR_CONTACT_US
		static let PURCHASE_ERROR_UNKNOWN = "Unknown error." + PURCHASE_ERROR_CONTACT_US
		static let PURCHASE_RESTORE_ERROR = "Restore error." + PURCHASE_ERROR_CONTACT_US
		static let PURCHASE_RESTORE_NOTHING = "You have no purchases to restore!"
		static let PURCHASE_RESTORE_SUCCESS = "You have successfully restored your previous purchases."
		static let PURCHASE_SUCCESS = "Your new theme has been succesfully purchased and set. Enjoy :)"
		
		
		// Purchases: Upgrade Strings
		static let UPGRADE_SCREEN_TITLE = "Contact Premium"
		static let UPGRADE_SCREEN_ONE_TITLE = "Unlock Everything"
		static let UPGRADE_SCREEN_ONE_TEXT = "Gain access to all features, themes & unlockable content."
		static let UPGRADE_SCREEN_TWO_TITLE = "Access Themes"
		static let UPGRADE_SCREEN_TWO_TEXT = "Gain access to our Sunrise, Salvation, Nightlight themes & more."
		static let UPGRADE_SCREEN_THREE_TITLE = "Unlimited Catch Ups"
		static let UPGRADE_SCREEN_THREE_TEXT = "Create unlimited people & catch ups to keep in contact with those who matter to you."
		static let UPGRADE_SCREENS_MONTHLY_SUBSCRIBE_BUTTON_TITLE = "$1.99 \nmonth"
		static let UPGRADE_SCREENS_YEARLY_SUBSCRIBE_BUTTON_TITLE = "$4.99 \nyear"
		static let UPGRADE_SCREENS_UNLOCK_BUTTON_TITLE = "$6.99 \nonce"
		static let UPGRADE_SCREENS_INFO = "You'll be charged $1.99/month at confirmation of purchase. Your subscription will renew after 1 month unless turned off 24-hours before the end of the subscription period. You can manage this in your App Store settings. For details, see " + Constants.Strings.LINK_WEB
		

		// Send Feedback
		static let EMAIL = "joeytawadrous@gmail.com"
		static let SEND_FEEDBACK_SUBJECT = "Contact Feedback!"
		static let SEND_FEEDBACK_BODY = "I want to make Contact better. Here are my ideas... \n\n What I like about Contact: \n 1. \n 2. \n 3. \n\n What I don't like about Contact: \n 1. \n 2. \n 3. \n\n"
		
		
		// Share
		static let SHARE = "Check out " + Constants.Core.APPNAME + " on the App Store, where you can easily create reminders to contact your loved ones! #Contact #iOS \n\nDownload for free now: " + Constants.Strings.LINK_IOS_STORE
	}
	
	
	struct Views {
		static let ADD_CATCH_UP = "AddCatchUp"
		static let CATCH_UP = "CatchUp"
		static let CATCH_UPS = "CatchUps"
		static let PEOPLE = "People"
		static let PEOPLE_NAV_CONTROLLER = "PeopleNavController"
		static let SETTINGS = "Settings"
		static let SETTINGS_NAV_CONTROLLER = "SettingsNavController"
		static let THEMES = "Themes"
		static let THEMES_NAV_CONTROLLER = "ThemesNavController"
		static let UPGRADE = "Upgrade"
	}
}
