//
//  Report.swift
//  Xtgrams
//
//  Created by Kevinho Morales on 9/30/19.
//  Copyright © 2019 Kevinho Morales. All rights reserved.
//

import UIKit
import MessageUI

class Report: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var reportImage: UIImageView!
    @IBOutlet weak var labelOutletMsj: UILabel!
    @IBOutlet weak var reportTextField: UITextField!
    @IBOutlet weak var sendReportOutlet: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reportImage.layer.cornerRadius = 10
        reportImage.layer.borderColor = UIColor.white.cgColor
        reportImage.layer.borderWidth = 3
        reportImage.clipsToBounds = true
        
        sendReportOutlet.layer.cornerRadius = 10
        sendReportOutlet.clipsToBounds = true
        sendReportOutlet.backgroundColor = UIColor.white
        sendReportOutlet.setTitleColor(UIColor.black, for: UIControl.State.normal)

        self.navigationItem.title = "REPORT"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        //setupNavBar()
        let backButton = UIBarButtonItem(image: UIImage(named: "Back1x"), style: .plain, target: self, action: #selector(backFunction))
        self.navigationItem.leftBarButtonItem  = backButton
        
        let addButton = UIBarButtonItem(image: UIImage(named: "add1x"), style: .plain, target: self, action: #selector(addFunction))
        self.navigationItem.rightBarButtonItem  = addButton
        // Do any additional setup after loading the view.
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
        
        toolBar.setItems([flexibleSpace, doneButton], animated: true)
        reportTextField.inputAccessoryView = toolBar
    }
    
    @objc func doneClicked() {
        view.endEditing(true)
    }
    
    @objc func backFunction() {
        
        print("Back!")
        self.navigationController!.popViewController(animated: true)
        
    }
    
    
    @objc func addFunction() {
        
        //reportImage.isHidden = true
            
            let attributedString = NSAttributedString(string: "Upload a picture", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.white])
            
            let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
            
            alert.setValue(attributedString, forKey: "attributedTitle")
            
            //alert.addAction(UIAlertAction(title: "Galería", style: .default, handler: { (nil) in
            
            let imagePicker = UIImagePickerController()
            
            alert.addAction(UIAlertAction(title: "Take a picture", style: .default, handler: {  (nil) in
                
                
                
                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.sourceType = UIImagePickerController.SourceType.camera
                    imagePicker.allowsEditing = true
                    self.present(imagePicker, animated: true, completion: nil)
                }
                else
                {
                    let alert  = UIAlertController(title: "Alerta", message: "Usted no tiene una camara", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }}
                
                
            ))
            
            alert.addAction(UIAlertAction(title: "Select a picture", style: .default, handler: { (nil) in
                
                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
                    
                    //let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                    imagePicker.allowsEditing = true
                    self.present(imagePicker, animated: true, completion: nil)
                    
                    
                } else {
                    
                    print("No se a podido tener acceso a la galería")
                    
                }
                
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (nil) in
                //self.imageAdd.isHidden = false
            }))
            
            
            alert.popoverPresentationController?.sourceView = self.view
            alert.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
            
            
            alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            alert.view.tintColor = UIColor.white // Cambiar color de botones alerta
            alert.view.layer.borderColor = UIColor.white.cgColor
            alert.view.layer.borderWidth = 3
            alert.view.layer.cornerRadius = 10
            present(alert, animated: true, completion: nil)
            
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            // The info dictionary may contain multiple representations of the image. You want to use the original.
            guard (info[.originalImage] as? UIImage) != nil else {
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
            }
            
            if  let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
                reportImage.contentMode = .scaleAspectFill
                reportImage.image = pickedImage
                
                reportImage.image = reportImage.image!.fixOrientation()
                
                //let imagePrueba2 = imageSend.image

            }
            
            picker.dismiss(animated: true, completion: nil)
            
        
    }
    
    
    @IBAction func sendReportButton(_ sender: UIButton) {
        
        if reportImage.image == nil {
                print("STOP!")
                let attributedString = NSAttributedString(string: "You need to add an image to send an email", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.white])
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
                
                let mailComposeViewController = configureMailController()
                if MFMailComposeViewController.canSendMail() {
                    
                    self.present(mailComposeViewController, animated: true, completion: nil)
                    
                } else {
                    
                    showMailError()
                }
            }
        }
        
        // Feedback
        
        let labelTopVar = "I wanna report this account"
    
        func configureMailController() -> MFMailComposeViewController {
            
            let mailComposerVC = MFMailComposeViewController()
            let image = reportImage.image // Your Image
            let imageData = UIImage.pngData(image!) ?? nil
            let base64String = imageData?()!.base64EncodedString() ?? "" // Your String Image
            let strHtml = "<html><body><p></p><p><b><img src='data:image/png;base64,\(String(describing: base64String) )'></b></p></body></html>"
            let composeVC = MFMailComposeViewController()
            
            mailComposerVC.mailComposeDelegate = self
            
            mailComposerVC.setToRecipients(["soporte@thegoldb.com"])
            mailComposerVC.setSubject(labelTopVar.uppercased())
            mailComposerVC.setMessageBody("\(reportTextField.text!)\n\n\(strHtml)", isHTML: true)
            
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
    
    

}

extension UIImage {
    func fixOrientation() -> UIImage {
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        let normalizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return normalizedImage;
    }
}
