import Foundation
import UIKit
import CoreData
import StoreKit

class Themes: UIViewController, SKPaymentTransactionObserver, SKProductsRequestDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    
    let productIdentifiers = Set(["com.joeyt.contact.iap.theme.colorful", "com.joeyt.contact.iap.theme.rainbow", "com.joeyt.contact.iap.theme.style", "com.joeyt.contact.iap.theme.wave", "com.joeyt.contact.iap.theme.girly", "com.joeyt.contact.iap.theme.manly", "com.joeyt.contact.iap.theme.tidal", "com.joeyt.contact.iap.theme.slide", "com.joeyt.contact.iap.theme.makeup"])
    var products = Array<SKProduct>()
    
    var down = CGFloat(-30)
    var downAdjust = CGFloat(0)
    
    
    /* MARK: Initialising
    /////////////////////////////////////////// */
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Utils.getNextTableColour(0, reverse: false)
        
        // IAP's
        UserDefaults.standard.set(false, forKey: Constants.IAP.TRANSACTION_IN_PROGRESS)
        SKPaymentQueue.default().add(self)
        requestProductData()
        
        // Theme image and button for the royal theme
        addImageButton(view, scrollView: scrollView, down: downAdjust, image: Constants.IAP.ROYAL_THEME)
        addButton(view, scrollView: scrollView, down: downAdjust, title: Constants.IAP.ROYAL_THEME)
    }
    
    
    /* MARK: Class Methods
    /////////////////////////////////////////// */
    func addImageButton(_ view: UIView, scrollView: UIScrollView, down: CGFloat, image: String) {
        let imageButton = UIButton(type: UIButtonType.custom)
        let center = (view.frame.size.width - view.frame.size.width / 1.3) / 2;
        
        imageButton.frame = CGRect(x: center, y: down, width: view.frame.size.width / 1.3, height: view.frame.size.width / 1.3) // 414
        imageButton.setImage(UIImage(named: image), for: UIControlState())
        imageButton.addTarget(self, action: #selector(themePressed), for: .touchUpInside)
        imageButton.setTitle(image, for: UIControlState())
        
        scrollView.addSubview(imageButton)
        
        
        // Spacing
        downAdjust = imageButton.frame.origin.y + view.frame.size.width / 1.2
    }
    
    func addButton(_ view: UIView, scrollView: UIScrollView, down: CGFloat, title: String) {
        let button = RoundedButton(type: UIButtonType.custom)
        let center = (view.frame.size.width - view.frame.size.width / 2) / 2;
        
        button.frame = CGRect(x: center, y: down, width: view.frame.size.width / 2.2, height: 40) // 414
        button.addTarget(self, action: #selector(themePressed), for: .touchUpInside)
        
        button.setTitle(title, for: UIControlState())
        
        scrollView.addSubview(button)
        
        
        // Spacing
        downAdjust = button.frame.origin.y + 90
        
        
        // Set scroll view height to just below button
        scrollView.contentSize.height = button.frame.origin.y + 90
    }
    
    func drawThemeButtons() {
        for product: SKProduct in products {
            addImageButton(view, scrollView: scrollView, down: downAdjust, image: product.localizedTitle)
            addButton(view, scrollView: scrollView, down: downAdjust, title: product.localizedTitle)
        }
    }
    
    
    
    /* MARK: Button Methods
    /////////////////////////////////////////// */
    @IBAction func themePressed(_ sender: UIButton) {
        
        // if the user is not already making a purchase
        if UserDefaults.standard.bool(forKey: Constants.IAP.TRANSACTION_IN_PROGRESS) == false {
            
            let currentTheme = UserDefaults.standard.string(forKey: Constants.IAP.CURRENT_THEME)
            
            // If the sender is the current theme
            if sender.titleLabel?.text == currentTheme {
                let alert = UIAlertView(title: currentTheme! + " is Currently Set", message: "Please select another theme to set as default.", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
            else {
                let purchasedProducts = UserDefaults.standard.object(forKey: Constants.IAP.PURCHASED_PRODUCTS) as? [String] ?? [String]()
                
                // If the sender is not the royal theme and it has not been purchased before
                if sender.titleLabel?.text != Constants.IAP.ROYAL_THEME && !purchasedProducts.contains((sender.titleLabel?.text)!) {
                    
                    // Find the product the user wants to purchase
                    for product: SKProduct in products {
                        if product.localizedTitle == sender.titleLabel?.text {
                            UserDefaults.standard.set(true, forKey: Constants.IAP.TRANSACTION_IN_PROGRESS)
                            SKPaymentQueue.default().add(SKPayment(product: product))
                        }
                    }
                }
                else {
                    UserDefaults.standard.set(sender.titleLabel?.text, forKey: Constants.IAP.CURRENT_THEME)
                    
                    // Refresh theme
                    view.backgroundColor = Utils.getNextTableColour(0, reverse: false)
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.initTabBar()
                    
                    let alert = UIAlertView(title: "Theme Set", message: (sender.titleLabel?.text)! + " has been set.", delegate: nil, cancelButtonTitle: "OK")
                    alert.show()
                }
            }
        }
    }
    
    @IBAction func restoreButtonPressed(_ sender: UIButton) {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    
    
    /* MARK: IAP's
    /////////////////////////////////////////// */
    func requestProductData() {
        if SKPaymentQueue.canMakePayments() {
            let request = SKProductsRequest(productIdentifiers: productIdentifiers)
            request.delegate = self
            request.start()
        }
        else {
            let alert = UIAlertController(title: "In-App Purchases Not Enabled", message: "Please enable In App Purchase in Settings", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Settings", style: UIAlertActionStyle.default, handler: { alertAction in
                alert.dismiss(animated: true, completion: nil)
                let url: URL? = URL(string: UIApplicationOpenSettingsURLString)
                if url != nil {
                    UIApplication.shared.openURL(url!)
                }
            }))
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { alertAction in
                alert.dismiss(animated: true, completion: nil)
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        var products = response.products
        
        if (products.count != 0) {
            for i in 0 ..< products.count {
                self.products.append(products[i])
            }
            
            drawThemeButtons()
        } else {
            print("No products found")
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
                case SKPaymentTransactionState.purchased:
                    print("Transaction Approved")
                    print("Product Identifier: \(transaction.payment.productIdentifier)")
                    deliverProduct(transaction)
                    SKPaymentQueue.default().finishTransaction(transaction)
                    UserDefaults.standard.set(false, forKey: Constants.IAP.TRANSACTION_IN_PROGRESS)
                    
                case SKPaymentTransactionState.failed:
                    print("Transaction Failed")
                    SKPaymentQueue.default().finishTransaction(transaction)
                    UserDefaults.standard.set(false, forKey: Constants.IAP.TRANSACTION_IN_PROGRESS)
                
                default:
                    break
            }
        }
    }
    
    func deliverProduct(_ transaction:SKPaymentTransaction) {
        checkAndApplyPurchasedTheme(transaction.payment.productIdentifier)
        
        let alert = UIAlertView(title: "Thank You", message: "Your new theme has been succesfully purchased and set. Enjoy :)", delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) { // Restore past transactions
        for transaction:SKPaymentTransaction in queue.transactions {
            checkAndApplyPurchasedTheme(transaction.payment.productIdentifier)
        }
        
        let alert = UIAlertView(title: "Thank You", message: "Restored purchase(s) successfully.", delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }
    
    func checkAndApplyPurchasedTheme(_ productIdentifier: String) {
        // Unlock Feature
        if productIdentifier == "com.joeyt.contact.iap.theme.colorful" {
            UserDefaults.standard.set(Constants.IAP.COLORFUL_THEME, forKey: Constants.IAP.CURRENT_THEME)
            updatePurchasedThemesArray(Constants.IAP.COLORFUL_THEME)
        }
        else if productIdentifier == "com.joeyt.contact.iap.theme.girly" {
            UserDefaults.standard.set(Constants.IAP.GIRLY_THEME, forKey: Constants.IAP.CURRENT_THEME)
            updatePurchasedThemesArray(Constants.IAP.GIRLY_THEME)
        }
        else if productIdentifier == "com.joeyt.contact.iap.theme.makeup" {
            UserDefaults.standard.set(Constants.IAP.MAKEUP_THEME, forKey: Constants.IAP.CURRENT_THEME)
            updatePurchasedThemesArray(Constants.IAP.MAKEUP_THEME)
        }
        else if productIdentifier == "com.joeyt.contact.iap.theme.manly" {
            UserDefaults.standard.set(Constants.IAP.MANLY_THEME, forKey: Constants.IAP.CURRENT_THEME)
            updatePurchasedThemesArray(Constants.IAP.MANLY_THEME)
        }
        else if productIdentifier == "com.joeyt.contact.iap.theme.rainbow" {
            UserDefaults.standard.set(Constants.IAP.RAINBOW_THEME, forKey: Constants.IAP.CURRENT_THEME)
            updatePurchasedThemesArray(Constants.IAP.RAINBOW_THEME)
        }
        else if productIdentifier == "com.joeyt.contact.iap.theme.slide" {
            UserDefaults.standard.set(Constants.IAP.SLIDE_THEME, forKey: Constants.IAP.CURRENT_THEME)
            updatePurchasedThemesArray(Constants.IAP.SLIDE_THEME)
        }
        else if productIdentifier == "com.joeyt.contact.iap.theme.style" {
            UserDefaults.standard.set(Constants.IAP.STYLE_THEME, forKey: Constants.IAP.CURRENT_THEME)
            updatePurchasedThemesArray(Constants.IAP.STYLE_THEME)
        }
        else if productIdentifier == "com.joeyt.contact.iap.theme.tidal" {
            UserDefaults.standard.set(Constants.IAP.TIDAL_THEME, forKey: Constants.IAP.CURRENT_THEME)
            updatePurchasedThemesArray(Constants.IAP.TIDAL_THEME)
        }
        else if productIdentifier == "com.joeyt.contact.iap.theme.wave" {
            UserDefaults.standard.set(Constants.IAP.WAVE_THEME, forKey: Constants.IAP.CURRENT_THEME)
            updatePurchasedThemesArray(Constants.IAP.WAVE_THEME)
        }
        
        // Refresh theme
        view.backgroundColor = Utils.getNextTableColour(0, reverse: false)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.initTabBar()
    }
    
    func updatePurchasedThemesArray(_ theme: String) {
        let defaults = UserDefaults.standard
        var purchasedProducts = defaults.object(forKey: Constants.IAP.PURCHASED_PRODUCTS) as? [String] ?? [String]()
        purchasedProducts.append(theme)
        defaults.set(purchasedProducts, forKey: Constants.IAP.PURCHASED_PRODUCTS)
    }
}