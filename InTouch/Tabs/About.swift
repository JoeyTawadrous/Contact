import Foundation
import UIKit
import MessageUI

class About: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet var reviewButton: UIButton!
    @IBOutlet var shareButton: UIButton!
    @IBOutlet var sendFeedbackButton: UIButton!

    
    /* MARK: Initialising
    /////////////////////////////////////////// */
    override func viewDidAppear(_ animated: Bool) {
        reviewButton.layer.cornerRadius = 5
        shareButton.layer.cornerRadius = 5
        sendFeedbackButton.layer.cornerRadius = 5
    }
    
    
    /* MARK: Button Methods
    /////////////////////////////////////////// */
    @IBAction func reviewButtonPressed(_ sender: UIButton) {
        PushReview.reviewApp()
    }
    
    @IBAction func shareButtonPressed(_ sender: UIButton) {
        let firstActivityItem = "Hello! I though you might like this cool app that I found. It's really helpful!"
        let secondActivityItem : URL = URL(string: "https://itunes.apple.com/ie/app/contact-never-loose-touch/id1101260252")!
        // If you want to put an image
        let image : UIImage = UIImage(named: "icon")!
        
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem, image], applicationActivities: nil)
        
        // This lines is for the popover you need to show in iPad
        activityViewController.popoverPresentationController?.sourceView = (sender )
        
        // This line remove the arrow of the popover to show in iPad
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        
        // Anything you want to exclude
        activityViewController.excludedActivityTypes = [
            UIActivityType.postToWeibo,
            UIActivityType.print,
            UIActivityType.assignToContact,
            UIActivityType.saveToCameraRoll,
            UIActivityType.addToReadingList,
            UIActivityType.postToFlickr,
            UIActivityType.postToVimeo,
            UIActivityType.postToTencentWeibo
        ]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func sendFeedbackButtonPressed(_ sender: UIButton) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
            sendMailErrorAlert.show()
        }

    }

    
    /* MARK: Mail Methods
    /////////////////////////////////////////// */
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["joeytawadrous@gmail.com"])
        mailComposerVC.setSubject("Feedback email for Contact!")
        mailComposerVC.setMessageBody("Feedback is great for everyone!", isHTML: false)
        
        return mailComposerVC
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController!, didFinishWith result: MFMailComposeResult, error: Error!) {
        controller.dismiss(animated: true, completion: nil)
        
    }
}
