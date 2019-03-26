import Foundation


class Constants {
	
	struct Achievements {
		static let COLORS = ["1abc9c", "2ecc71", "3498db", "9b59b6", "f1c40f", "e67e22", "e74c3c", "34495e"]
		
		// Points
		static let POINTS_TYPE = "pointsType"
		static let ACHIEVEMENT1 = ["10p", COLORS[0], "virus", "Blast-off", "You've earned 10 points! Congrats!"]
		static let ACHIEVEMENT2 = ["25p", COLORS[1], "virus-autoupdate", "Quarter", "You've earned 25 points! Congrats!"]
		static let ACHIEVEMENT3 = ["50p", COLORS[2], "satellite", "Halves", "You've earned 50 points! Congrats!"]
		static let ACHIEVEMENT4 = ["100p", COLORS[3], "satellite-dish", "Century", "You've earned 100 points! Congrats!"]
		static let ACHIEVEMENT5 = ["250p", COLORS[4], "atom", "Two-fifty", "You've earned 250 points! Congrats!"]
		
		// People to Meet
		static let PEOPLE_TYPE = "peopleType"
		static let ACHIEVEMENT6 = ["3pp", COLORS[5], "cloud", "Playtime", "You've added 3 people to catchup with! Congrats!"]
		static let ACHIEVEMENT7 = ["7pp", COLORS[6], "calculator", "In Tune", "You've added 7 people to catchup with! Congrats!"]
		static let ACHIEVEMENT8 = ["15pp", COLORS[7], "certificate", "Practitioner", "You've added 15 people to catchup with! Congrats!"]
		static let ACHIEVEMENT9 = ["30pp", COLORS[0], "best_product", "Monk", "You've added 30 people to catchup with! Congrats!"]
		static let ACHIEVEMENT10 = ["50pp", COLORS[1], "leaf", "Buddhist", "You've added 50 people to catchup with! Congrats!"]
		static let ACHIEVEMENT11 = ["100pp", COLORS[2], "diamond-1", "Zen Master", "You've added 100 people to catchup with! Congrats!"]
		
		// CatchUps Completed
		static let CATCHUPS_TYPE = "catchupsType"
		static let ACHIEVEMENT12 = ["30c", COLORS[3], "basketball", "Student", "You've completed 30 catchups! Congrats!"]
		static let ACHIEVEMENT13 = ["60c", COLORS[4], "apps", "Focused", "You've completed 60 catchups! Congrats!"]
		static let ACHIEVEMENT14 = ["90c", COLORS[5], "fountain-pen-tip", "Sublime", "You've completed 90 catchups! Congrats!"]
		static let ACHIEVEMENT15 = ["150c", COLORS[6], "fountain-pen", "Resolute", "You've completed 150 catchups! Congrats!"]
		static let ACHIEVEMENT16 = ["300c", COLORS[7], "brightness", "Zen", "You've completed 300 catchups! Congrats!"]
		static let ACHIEVEMENT17 = ["500c", COLORS[0], "balance", "At Peace", "You've completed 500 catchups! Congrats!"]
		
		static let ACHIEVEMENTS_POINTS = [ACHIEVEMENT1, ACHIEVEMENT2, ACHIEVEMENT3, ACHIEVEMENT4, ACHIEVEMENT5]
		static let ACHIEVEMENTS_PEOPLE = [ACHIEVEMENT6, ACHIEVEMENT7, ACHIEVEMENT8, ACHIEVEMENT9, ACHIEVEMENT10, ACHIEVEMENT11]
		static let ACHIEVEMENTS_CATCHUPS = [ACHIEVEMENT12, ACHIEVEMENT13, ACHIEVEMENT14, ACHIEVEMENT15, ACHIEVEMENT16, ACHIEVEMENT17]
		static let ACHIEVEMENTS_ALL = [ACHIEVEMENT1, ACHIEVEMENT2, ACHIEVEMENT3, ACHIEVEMENT4, ACHIEVEMENT5, ACHIEVEMENT6, ACHIEVEMENT7, ACHIEVEMENT8, ACHIEVEMENT9, ACHIEVEMENT10, ACHIEVEMENT11, ACHIEVEMENT12, ACHIEVEMENT13, ACHIEVEMENT14, ACHIEVEMENT15, ACHIEVEMENT16, ACHIEVEMENT17]
	}
	
	
	struct Colors {
		static let BLUE = "69CDFC"
		static let GREEN = "2ecc71"
		static let ORANGE = "f39c12"
		static let PURPLE = "B0B1F1"
		static let PRIMARY_TEXT_GRAY = "5D5D5C"
	}
	
	
	struct Core {
		static let APP_ID = "1101260252"
		static let APP_NAME = "Contact"
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
    struct AppGroup {
        static let NAME = "group.com.joeyt.contact"
    }
	
	struct Defaults {
		// Achievements
		static let APP_DATA = "appData"
		static let APP_DATA_ACHIEVEMENTS = "achievements"
		static let APP_DATA_TOTAL_POINTS = "totalPoints"
		static let APP_DATA_TOTAL_PEOPLE_MET = "totalPeopleMet" // + 3p each
		static let APP_DATA_TOTAL_CATCHUPS_COMPLETED = "totalCacthupsCompleted" // + 1p each
		
		static let CURRENT_THEME = "CurrentTheme"
		static let PURCHASED_THEMES = "PurchasedThemes"
		static let USER_HAS_MONTHLY_SUBSCRIPTION = "userHasMonthlySubscription"
		static let USER_HAS_YEARLY_SUBSCRIPTION = "userHasYearlySubscription"
		static let USER_HAS_UNLOCKED_APP = "userHasUnlockedApp"
	}
	
	
	struct Design {
		static let LOGO = "Logo"
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
        static let GREEN_THEME = "New Beginnings"
		static let GRASSY_THEME = "grassy"
		static let SUNRISE_THEME = "sunrise"
		static let NIGHTLIGHT_THEME = "nightlight"
		static let SALVATION_THEME = "salvation"
		static let RIPE_THEME = "ripe"
		static let MALIBU_THEME = "malibu"
		static let LIFE_THEME = "life"
		static let FIRE_THEME = "fire"
		
		static let Colors: [String : [String]] = [
            GREEN_THEME: ["9ef42e","4cd9bb"],
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
		static let ALERT_DIALOG_CLOSE = "Close"
		static let ALERT_DIALOG_INFO = "Info"
		static let ALERT_DIALOG_SUBMIT = "Submit"
		
		
		// Dialog: Achievements
		static let ACHIEVEMENTS_INFO_DIALOG_TITLE = "How to Earn Points"
		static let ACHIEVEMENTS_INFO_DIALOG_SUBTITLE = "\nEvery person created will earn you three points. \n\nEvery catchup completed will earn you 2 points. \n\nEvery person created/catchup completed/point gained brings you closer to earning achievement bagdes and levelling up :) \n"

		
		// Dialog: Achievements
		static let ACHIEVEMENT_DIALOG_CLOSE_BUTTON = "Let's continue :)"
		static let ACHIEVEMENT_DIALOG_SHARE_BUTTON = "Share my achievement!"
		static let ACHIEVEMENT_DIALOG_TITLE = "Congratulations!"
		static let ACHIEVEMENT_COMPLETE_DIALOG_SUBTITLES = ["Congratulations! You are one step closer to your goal! :)", "Another one bites the dust! :)", "Well done to you", "Fantastic work. Onwards & upwards!", "Hard work beats talent where talent does not work hard.", "Slow and steady progress will overcome all obstacles."]
		
		
		// Levels
		static let LEVEL = "Level "
		static let LEVEL_THRESHOLDS = [0, 5, 15, 30, 50, 75, 125, 200, 300, 450, 600, 800]
		static let LEVEL_UP = "\n Level Up! You're amazing ;) \n Welcome to level "
		static let POINTS_CIRCULAR_VIEW_DESCRIPTION_LABEL = "Total Points: "
		
		
		// Links
		static let LINK_APP_REVIEW = "itms-apps://itunes.apple.com/app/apple-store/id" + Core.APP_ID + "?action=write-review"
		static let LINK_FACEBOOK = "https://www.facebook.com/getlearnable"
		static let LINK_INSTAGRAM = "https://www.instagram.com/learnableapp"
		static let LINK_IOS_STORE = "https://itunes.apple.com/gb/app/contact-remember-your-friends/id1101260252?mt=8"
		static let LINK_PRIVACY_AND_TERMS = "https://www.getLearnable.com/privacy.php"
		static let LINK_LEARNABLE_IOS_STORE = "https://itunes.apple.com/gb/app/learnable-learn-to-code-from-scratch-level-up/id1254862243?mt=8"
		static let LINK_TWITTER = "https://twitter.com/getlearnable"
		static let LINK_TWITTER_JOEY = "https://twitter.com/joeytawadrous"
		static let LINK_WEB = "http://www.getlearnable.com"
		
		
		// Purchases: Strings
		static let PURCHASE_ERROR_CONTACT_US = " Please contact us."
		static let PURCHASE_ERROR_NOT_AVAILABLE = "The product is not available in the current storefront." + PURCHASE_ERROR_CONTACT_US
		static let PURCHASE_ERROR_IDENTIFIER_INVALID = "The purchase identifier was invalid." + PURCHASE_ERROR_CONTACT_US
		static let PURCHASE_ERROR_CANCELLED = "Your payment was cancelled." + PURCHASE_ERROR_CONTACT_US
		static let PURCHASE_ERROR_NOT_ALLOWED = "You are not allowed to make payments." + PURCHASE_ERROR_CONTACT_US
		static let PURCHASE_ERROR_LOGIN = "You must login to your App Store account before your payment can be completed."
		static let PURCHASE_RESTORE_ERROR = "Restore error." + PURCHASE_ERROR_CONTACT_US
		static let PURCHASE_RESTORE_NOTHING = "You have no purchases to restore!"
		static let PURCHASE_RESTORE_SUCCESS = "You have successfully restored your previous purchases."
		static let PURCHASE_SUCCESS = "Your new theme has been succesfully set. Enjoy :)"
		
		
		// Purchases: Upgrade Strings
		static let UPGRADE_SCREEN_TITLE = "Contact Premium"
		static let UPGRADE_SCREEN_ONE_TITLE = "Unlock Everything"
		static let UPGRADE_SCREEN_ONE_TEXT = "Gain access to all features, themes & unlockable content."
		static let UPGRADE_SCREEN_TWO_TITLE = "Earn Achievements"
		static let UPGRADE_SCREEN_TWO_TEXT = "Catch Up with friends and unlock badges as you level up."
		static let UPGRADE_SCREEN_THREE_TITLE = "Access Themes"
		static let UPGRADE_SCREEN_THREE_TEXT = "Gain access to our Sunrise, Salvation, Nightlight themes & more."
		static let UPGRADE_SCREEN_FOUR_TITLE = "Unlimited Catch Ups"
		static let UPGRADE_SCREEN_FOUR_TEXT = "Create unlimited people & catch ups to keep in contact with those who matter to you."
		static let UPGRADE_SCREENS_MONTHLY_SUBSCRIBE_BUTTON_TITLE = "$1.99 \nmonth"
		static let UPGRADE_SCREENS_YEARLY_SUBSCRIBE_BUTTON_TITLE = "$4.99 \nyear"
		static let UPGRADE_SCREENS_UNLOCK_BUTTON_TITLE = "$6.99 \nonce"
		static let UPGRADE_SCREENS_INFO = "You'll be charged $1.99/$4.99 month at confirmation of purchase. Your subscription will renew after 1 month unless turned off 24-hours before the end of the subscription period. You can manage this in your App Store settings. For details, see " + Constants.Strings.LINK_PRIVACY_AND_TERMS
		

		// Send Feedback
		static let EMAIL = "joeytawadrous@gmail.com"
		static let SEND_FEEDBACK_SUBJECT = "Contact Feedback!"
		static let SEND_FEEDBACK_BODY = "I want to make Contact better. Here are my ideas... \n\n What I like about Contact: \n 1. \n 2. \n 3. \n\n What I don't like about Contact: \n 1. \n 2. \n 3. \n\n"
		
		
		// Share
		static let SHARE = "Check out " + Constants.Core.APP_NAME + " on the App Store, where you can easily create reminders to contact your loved ones! #Contact #iOS \n\nDownload for free now: " + Constants.Strings.LINK_IOS_STORE
	}
	
	
	struct Views {
		static let ACHIEVEMENTS = "Achievements"
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
