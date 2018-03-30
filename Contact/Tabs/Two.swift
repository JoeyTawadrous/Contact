import UIKit
import StoreKit


class Two: UIViewController {
    
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var buyButton: UIButton!
    
    var product: SKProduct?
    var productID = "<YOUR PRODUCT ID GOES HERE>"
    
}
