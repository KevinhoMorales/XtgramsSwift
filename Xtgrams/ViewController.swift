//
//  ViewController.swift
//  Xtgrams
//
//  Created by Kevinho Morales on 9/28/19.
//  Copyright © 2019 Kevinho Morales. All rights reserved.
//

import UIKit
import WebKit

final class ViewController: UIViewController, UIGestureRecognizerDelegate {

    // MARK: - Outlets
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    
    // MARK: - Private
    private let searchBar = UISearchBar()
    private var webView: WKWebView!
    private let refreshControl = UIRefreshControl()
    private let baseUrl = "http://www.xtgrams.com"
    private let searchPath = "/search?q="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation buttons
//        backButton.isEnabled = false
//        forwardButton.isEnabled = false
        
//        // Search bar
//        self.navigationItem.titleView = searchBar
//        searchBar.delegate = self
        
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "XG1x"))
        
        // Web view
        let webViewPrefs = WKPreferences()
        webViewPrefs.javaScriptEnabled = true
        webViewPrefs.javaScriptCanOpenWindowsAutomatically = true
        let webViewConf = WKWebViewConfiguration()
        webViewConf.preferences = webViewPrefs
        webView = WKWebView(frame: view.frame, configuration: webViewConf)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.scrollView.keyboardDismissMode = .onDrag
        view.addSubview(webView)
        webView.navigationDelegate = self
        
        // Refresh control
        refreshControl.addTarget(self, action: #selector(reload), for: .valueChanged)
        webView.scrollView.addSubview(refreshControl)
        view.bringSubviewToFront(refreshControl)
        
        // Load url
        load(url: baseUrl)
        
        let backButton = UIBarButtonItem(image: UIImage(named: "Back1x"), style: .plain, target: self, action: #selector(backFunction))
        self.navigationItem.leftBarButtonItem  = backButton
        
        let editImage    = UIImage(named: "exclamation1x")!
        //let searchImage  = UIImage(named: "Profile1x")!
        let complaintImage  = UIImage(named: "Options1x")!
        
        let editButton   = UIBarButtonItem(image: editImage,  style: .plain, target: self, action: #selector(alertFunction))
        //let searchButton = UIBarButtonItem(image: searchImage,  style: .plain, target: self, action: #selector(logoutFunction))
        let complaintButton = UIBarButtonItem(image: complaintImage,  style: .plain, target: self, action: #selector(settingsFunction))
        
        navigationItem.rightBarButtonItems = [complaintButton , editButton]
        // Do any additional setup after loading the view.
        
        // ACTIVAR SWIPE BACK DESLIZAR CON FUNCION
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        // ACTIVAR SWIPE BACK DESLIZAR CON FUNCION
        
    }
    
    @objc func alertFunction() {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReportID") as? Report
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @objc func backFunction() {
        
        print("Back!")
        self.navigationController!.popViewController(animated: true)
        
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
    
    @IBAction func backButtonAction(_ sender: Any) {
        webView.goBack()
    }
    
    @IBAction func forwardButtonAction(_ sender: Any) {
        webView.goForward()
    }
    
    // MARK: - Private methods
    
    private func load(url: String) {
        
        var urlToLoad: URL!
        if let url = URL(string: url), UIApplication.shared.canOpenURL(url) {
            urlToLoad = url
        } else {
            urlToLoad = URL(string: "\(baseUrl)\(searchPath)\(url)")!
        }
        webView.load(URLRequest(url: urlToLoad))
    }
    
    @objc private func reload() {
        webView.reload()
    }
    
}

// MARK: - UISearchBarDelegate

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.endEditing(true)
        load(url: searchBar.text ?? "")
    }
    
}

// MARK: - WKNavigationDelegate

extension ViewController: WKNavigationDelegate {
    
    // Finish
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        refreshControl.endRefreshing()
//        backButton.isEnabled = webView.canGoBack
//        forwardButton.isEnabled = webView.canGoForward
        view.bringSubviewToFront(refreshControl)
    }
    
    // Start
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        refreshControl.beginRefreshing()
        searchBar.text = webView.url?.absoluteString
    }
    
    // Error
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
        refreshControl.beginRefreshing()
        view.bringSubviewToFront(refreshControl)
    }
    
}
