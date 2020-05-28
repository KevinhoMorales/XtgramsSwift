//
//  XtgramsWeb.swift
//  Xtgrams
//
//  Created by Kevinho Morales on 9/25/19.
//  Copyright © 2019 Kevinho Morales. All rights reserved.
//

import UIKit
import WebKit

class XtgramsWeb: UIViewController, UIWebViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var xtgramsWeb: UIWebView!
    @IBOutlet weak var loadSpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadSpinner.assignColor(.white)
        
        xtgramsWeb.delegate = self
        
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "XG1x"))

        self.xtgramsWeb.isOpaque = false;
        self.xtgramsWeb.backgroundColor = UIColor.clear
        
        let myURL = URL(string:"http://xtgrams.com")
        let myRequest = URLRequest(url: myURL!)
        xtgramsWeb.loadRequest(myRequest)
        print("Webpage Loaded Successfully")
        
        // ACTIVAR SWIPE BACK DESLIZAR CON FUNCION
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        // ACTIVAR SWIPE BACK DESLIZAR CON FUNCION
        
        let backButton = UIBarButtonItem(image: UIImage(named: "Back1x"), style: .plain, target: self, action: #selector(backFunction))
        self.navigationItem.leftBarButtonItem  = backButton
        
        let editImage    = UIImage(named: "exclamation1x")!
        //let searchImage  = UIImage(named: "Profile1x")!
        let complaintImage  = UIImage(named: "Options1x")!
        
        let editButton   = UIBarButtonItem(image: editImage,  style: .plain, target: self, action: #selector(alertFunction))
        //let searchButton = UIBarButtonItem(image: searchImage,  style: .plain, target: self, action: #selector(logoutFunction))
        let complaintButton = UIBarButtonItem(image: complaintImage,  style: .plain, target: self, action: #selector(settingsFunction))
        
        navigationItem.rightBarButtonItems = [editButton, complaintButton]
    }
    
    @objc func backFunction() {
        
        print("Back!")
        self.navigationController!.popViewController(animated: true)
        
    }
    
    @objc func alertFunction() {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SettingsID") as? Settings
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @objc func settingsFunction() {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SettingsID") as? Settings
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    // ACTIVAR SWIPE BACK DESLIZAR CON FUNCION
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    // ACTIVAR SWIPE BACK DESLIZAR CON FUNCION

    // ActivityStartLoading
    func startActivity(){
        IndicatorView.shared.showOverlay(self.view, dots_color: UIColor.white, bg_color: UIColor.clear, dots_count: 3)
        DispatchQueue.main.asyncAfter(deadline: .now()+1){
        IndicatorView.shared.hideOverlayView()
        }
    }
    // ActivityStartLoading
    
    public func webViewDidStartLoad(_ webView: UIWebView) {
        print("webViewDidStartLoad")
        loadSpinner.isHidden = false
        loadSpinner.startAnimating()
    }
    
    
    public func webViewDidFinishLoad(_ webView: UIWebView){
        print("webViewDidFinishLoad")
        loadSpinner.stopAnimating()
        loadSpinner.isHidden = true
    }
    
    
    public func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("didFailLoadWithError")
        loadSpinner.stopAnimating()
        loadSpinner.isHidden = true
        
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool{
        print("ABCd")
        return true
    }

}

extension UIActivityIndicatorView {
    func assignColor(_ color: UIColor) {
        style = .whiteLarge
        self.color = color
    }
}
