//
//  Settings.swift
//  Runmeit
//
//  Created by Kevinho Morales on 7/28/19.
//  Copyright © 2019 Kevinho Morales. All rights reserved.
//

import UIKit
import MessageUI
import StoreKit
import SafariServices

class Settings: UITableViewController, MFMailComposeViewControllerDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet var tableViewParent: UITableView!
    @IBOutlet weak var viewLogo: UIView!
    
    @IBOutlet weak var tableViewCellSupport: UITableViewCell!
    @IBOutlet weak var tableViewCellApps: UITableViewCell!
    
    @IBOutlet weak var tableViewCellTutorial: UITableViewCell!
    
    @IBOutlet weak var tableViewCellRate: UITableViewCell!
    
    @IBOutlet weak var tableViewCellShare: UITableViewCell!
    
    @IBOutlet weak var tableViewCellWebsite: UITableViewCell!
    
    @IBOutlet weak var tableViewCellTerms: UITableViewCell!
    
    @IBAction func tutorialButton(_ sender: UIButton) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TutorialID") as? TutorialSmartKey
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpColors()
        
        self.navigationItem.title = "SETTINGS"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        //setupNavBar()
        let backButton = UIBarButtonItem(image: UIImage(named: "Back1x"), style: .plain, target: self, action: #selector(backFunction))
        self.navigationItem.leftBarButtonItem  = backButton
        
        copyrightOutlet.text = "© 2019 Xtgrams\nAll copyrights reserved\nVersion 1.0"
        // Do any additional setup after loading the view.
        
        // ACTIVAR SWIPE BACK DESLIZAR CON FUNCION
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        // ACTIVAR SWIPE BACK DESLIZAR CON FUNCION
        
    }
    // ACTIVAR SWIPE BACK DESLIZAR CON FUNCION
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    // ACTIVAR SWIPE BACK DESLIZAR CON FUNCION
    
    
    @objc func backFunction() {
        
        print("Back!")
        self.navigationController!.popViewController(animated: true)
        
    }
    
    @IBAction func reportAction(_ sender: UIButton) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReportID") as? Report
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    
    // Cambiar el color del HEADER de la tabla de secciones
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        
        if #available(iOS 12.0, *) {
            let isDarkMode = traitCollection.userInterfaceStyle == .dark
            view.tintColor = isDarkMode ? UIColor.lightGray : UIColor.white
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.textColor = isDarkMode ? UIColor.white : UIColor.black
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    // Cambiar el color del HEADER de la tabla de secciones
    
    @IBAction func rateAppAction(_ sender: UIButton) {
        
        if #available(iOS 10.3, *) {
            
            SKStoreReviewController.requestReview()
            
        } else {
            // Request review from a manual method here
        }
        
    }
    
    @IBOutlet weak var copyrightOutlet: UILabel!
    
    @IBAction func termsAction(_ sender: UIButton) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TermsID") as? Terms_Conditions
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    private func setUpColors() {
        
        
        if #available(iOS 12.0, *) {
            let isDarkMode = traitCollection.userInterfaceStyle == .dark
            tableViewParent.backgroundColor = isDarkMode ? UIColor.lightGray : UIColor.white
            copyrightOutlet.textColor = isDarkMode ? UIColor.white : UIColor.black
            copyrightOutlet.backgroundColor = isDarkMode ? UIColor.lightGray : UIColor.white
            viewLogo.backgroundColor = isDarkMode ? UIColor.lightGray : UIColor.white
            
            tableViewCellSupport.backgroundColor = isDarkMode ? UIColor.lightGray : UIColor.white
            tableViewCellApps.backgroundColor = isDarkMode ? UIColor.lightGray : UIColor.white
            tableViewCellTutorial.backgroundColor = isDarkMode ? UIColor.lightGray : UIColor.white
            tableViewCellTerms.backgroundColor = isDarkMode ? UIColor.lightGray : UIColor.white
            tableViewCellWebsite.backgroundColor = isDarkMode ? UIColor.lightGray : UIColor.white
            tableViewCellShare.backgroundColor = isDarkMode ? UIColor.lightGray : UIColor.white
            tableViewCellRate.backgroundColor = isDarkMode ? UIColor.lightGray : UIColor.white
        
        } else {
            // Fallback on earlier versions
        }
        
        //copyrightOutlet.textColor = UIColor(named: "TextColor")
        //tableViewParent.backgroundColor = UIColor(named: "BackgroundSettings")
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setUpColors()
    }
    
    
    @IBAction func shareAppAction(_ sender: UIButton) {
        
        let activityAC = UIActivityViewController(activityItems: ["Xtgrams by The Gold B\nhttps://itunes.apple.com/ec/app/cleanow/id1448624210?l=en&mt=8"], applicationActivities: nil)
        activityAC.popoverPresentationController?.sourceView = self.view
        
        self.present(activityAC, animated: true, completion: nil)
        
    }
    
    @IBAction func contactAppAction(_ sender: UIButton) {
        
        let svc = SFSafariViewController(url: URL(string: "https://www.thegoldb.com")!)
        self.present(svc, animated: true, completion: nil)
        
    }
    
    @IBAction func appsAction(_ sender: UIButton) {
        
        let svc = SFSafariViewController(url: URL(string: "https://itunes.apple.com/us/developer/kevinho-morales/id1374018117")!)
        self.present(svc, animated: true, completion: nil)
        
    }
    
    @IBAction func supportAction(_ sender: UIButton) {
        
        let mailComposeViewController = configureMailController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            showMailError()
        }
        
    }
    
    func setStatusBarBackgroundColor(color: UIColor) {
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        statusBar.backgroundColor = color
    }
    
    // Feedback
    
    func configureMailController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["soporte@thegoldb.com"])
        mailComposerVC.setSubject("Support")
        mailComposerVC.setMessageBody("Dear developer, ", isHTML: false)
        
        return mailComposerVC
    }
    
    func showMailError() {
        let sendMailErrorAlert = UIAlertController(title: "Could not send email", message: "Your device could not send email", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Ok", style: .default, handler: nil)
        sendMailErrorAlert.addAction(dismiss)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        controller.dismiss(animated: true, completion: {
            if result == .cancelled {
                let attributedString = NSAttributedString(string: "No message has been sent", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.white])
                let alertController2 = UIAlertController(title: "", message: "", preferredStyle: .alert)
                alertController2.setValue(attributedString, forKey: "attributedTitle")
                let cancelAction2 = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController2.addAction(cancelAction2)
                self.present(alertController2, animated: true)
                alertController2.preferredAction = cancelAction2
                alertController2.view.tintColor = UIColor.white // Cambiar color de botones alerta
                alertController2.view.layer.borderColor = UIColor.white.cgColor
                alertController2.view.layer.borderWidth = 3
                alertController2.view.layer.cornerRadius = 10
            } else {
                
                let attributedString = NSAttributedString(string: "Message sent successfully", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.white])
                let alertController2 = UIAlertController(title: "", message: "Thank you for contacting the development team", preferredStyle: .alert)
                alertController2.setValue(attributedString, forKey: "attributedTitle")
                let cancelAction2 = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController2.addAction(cancelAction2)
                self.present(alertController2, animated: true)
                alertController2.preferredAction = cancelAction2
                alertController2.view.tintColor = UIColor.white // Cambiar color de botones alerta
                alertController2.view.layer.borderColor = UIColor.white.cgColor
                alertController2.view.layer.borderWidth = 3
                alertController2.view.layer.cornerRadius = 10
                
            }
        })
        
    }
    
    // Feedback
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    

}
