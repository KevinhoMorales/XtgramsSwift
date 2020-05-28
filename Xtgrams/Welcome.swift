//
//  Welcome.swift
//  Xtgrams
//
//  Created by Kevinho Morales on 9/25/19.
//  Copyright © 2019 Kevinho Morales. All rights reserved.
//

import UIKit

class Welcome: UIViewController {
    
    @IBOutlet weak var getStartOutlet: UIButton!
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var viewPop: UIView!
    @IBOutlet weak var pressLabel: UILabel!
    
    @IBOutlet weak var termsButtonOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAnimate()
        
        viewPop.layer.cornerRadius = 10
        viewPop.layer.borderColor = UIColor.white.cgColor
        viewPop.layer.borderWidth = 3
        viewPop.clipsToBounds = true
        
        getStartOutlet.layer.cornerRadius = 10
//        getStartOutlet.layer.borderColor = UIColor.black.cgColor
//        getStartOutlet.layer.borderWidth = 3
        getStartOutlet.clipsToBounds = true
        
        getStartOutlet.isEnabled = false
        getStartOutlet.backgroundColor = UIColor.gray
        getStartOutlet.setTitleColor(UIColor.white, for: UIControl.State.normal)
        
        
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func termsButtonOk(_ sender: UIButton) {
        
        if (termsButtonOutlet.isSelected == true) {
            termsButtonOutlet.setBackgroundImage(UIImage(named: "tick1xno"), for: UIControl.State.normal)
            termsButtonOutlet.isSelected = false
            print("NO")
            viewPop.isHidden = false
            pressLabel.isHidden = false
            getStartOutlet.isEnabled = false
            getStartOutlet.backgroundColor = UIColor.lightGray
            getStartOutlet.layer.cornerRadius = 10
            getStartOutlet.clipsToBounds = true
            getStartOutlet.setTitleColor(UIColor.black, for: UIControl.State.normal)
        } else {
            termsButtonOutlet.setBackgroundImage(UIImage(named: "tick1x"), for: UIControl.State.normal)
            termsButtonOutlet.isSelected = true
            viewPop.isHidden = true
            pressLabel.isHidden = true
            print("SI")
            getStartOutlet.isEnabled = true
            getStartOutlet.backgroundColor = UIColor.white
            getStartOutlet.layer.cornerRadius = 10
            getStartOutlet.clipsToBounds = true
            getStartOutlet.setTitleColor(UIColor.black, for: UIControl.State.normal)
        }
        
    }
    
    
    @IBAction func termsButton(_ sender: UIButton) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TermsID") as? Terms_Conditions
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    

    @IBAction func getSartButton(_ sender: UIButton) {
        
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "XtgramsWebID") as? XtgramsWeb
//        self.navigationController?.pushViewController(vc!, animated: true)
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "VCID") as? ViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @IBAction func closeButton(_ sender: UIButton) {
        
        removeAnimate()
        removeAnimatePress()
        
    }
    
    func showAnimate() {
        self.viewPop.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        self.viewPop.alpha = 0.0;
        UIView.animate(withDuration: 0.5, animations: {
            self.viewPop.alpha = 1.0
            self.viewPop.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    
    func removeAnimate() {
        
        getStartOutlet.isEnabled = true
        getStartOutlet.backgroundColor = UIColor.white
        getStartOutlet.layer.cornerRadius = 10
//        getStartOutlet.layer.borderColor = UIColor.white.cgColor
//        getStartOutlet.layer.borderWidth = 3
        getStartOutlet.clipsToBounds = true
        getStartOutlet.setTitleColor(UIColor.black, for: UIControl.State.normal)
        
        
        UIView.animate(withDuration: 0.5, animations: {
            self.viewPop.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.viewPop.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.viewPop.removeFromSuperview()
            }
        });
    }
    
    
    
    func removeAnimatePress() {
    
        UIView.animate(withDuration: 0.5, animations: {
            self.pressLabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.pressLabel.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.pressLabel.removeFromSuperview()
            }
        });
    }
    
}

