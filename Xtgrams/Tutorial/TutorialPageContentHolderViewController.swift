//
//  TutorialPageContentHolderViewController.swift
//  SmartKey
//
//  Created by Kevinho Morales on 6/9/19.
//  Copyright © 2019 Kevinho Morales. All rights reserved.
//

import UIKit

class TutorialPageContentHolderViewController: UIViewController {

    @IBOutlet weak var myImageView: UIImageView!
    
    var imageFileName: String!
    var pageIndex:Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        myImageView.image = UIImage(named:imageFileName)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
