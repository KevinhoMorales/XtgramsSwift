//
//  TutorialSmartKey.swift
//  SmartKey
//
//  Created by Kevinho Morales on 6/9/19.
//  Copyright © 2019 Kevinho Morales. All rights reserved.
//

import UIKit

@available(iOS 10.0, *)
class TutorialSmartKey: UIViewController, UIPageViewControllerDataSource, UIGestureRecognizerDelegate {
    
    var pageImages:NSArray!
    var pageViewController:UIPageViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "TUTORIAL"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        //setupNavBar()
        let backButton = UIBarButtonItem(image: UIImage(named: "Back1x"), style: .plain, target: self, action: #selector(backFunction))
        self.navigationItem.leftBarButtonItem  = backButton
        
        pageImages = NSArray(objects:"Tutorial1","Tutorial2","Tutorial3","Tutorial4")
        
        
        self.pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "MyPageViewController") as! UIPageViewController
        
        self.pageViewController.dataSource = self
        
        let initialContenViewController = self.pageTutorialAtIndex(0) as TutorialPageContentHolderViewController
        
        self.pageViewController.setViewControllers([initialContenViewController], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRect(x: 0, y: 1, width: self.view.frame.size.width, height: self.view.frame.size.height-45)
        
        self.addChild(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParent: self)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.lightGray
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.white
        
        // ACTIVAR SWIPE BACK DESLIZAR CON FUNCION
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        // ACTIVAR SWIPE BACK DESLIZAR CON FUNCION
        
    }
    
    @objc func backFunction() {
        
        print("Back!")
        self.navigationController!.popViewController(animated: true)
        
    }
    
    // ACTIVAR SWIPE BACK DESLIZAR CON FUNCION
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    // ACTIVAR SWIPE BACK DESLIZAR CON FUNCION
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func pageTutorialAtIndex(_ index: Int) ->TutorialPageContentHolderViewController
    {
        
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "TutorialPageContentHolderViewController") as! TutorialPageContentHolderViewController
        
        pageContentViewController.imageFileName = pageImages[index] as! String
        pageContentViewController.pageIndex = index
        
        
        return pageContentViewController
        
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        let viewController = viewController as! TutorialPageContentHolderViewController
        var index = viewController.pageIndex as Int
        
        if(index == 0 || index == NSNotFound)
        {
            return nil
        }
        
        index -= 1
        
        return self.pageTutorialAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        let viewController = viewController as! TutorialPageContentHolderViewController
        var index = viewController.pageIndex as Int
        
        if((index == NSNotFound))
        {
            return nil
        }
        
        index += 1
        
        if(index == pageImages.count)
        {
            return nil
        }
        
        return self.pageTutorialAtIndex(index)
    }
    
    
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int
    {
        return pageImages.count
    }
    
    
    
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int
    {
        return 0
    }
    
    
    @available(iOS 13.0, *)
    @IBAction func skipButton(_ sender: UIButton) {
        
        
        //Remember user's choice, so we can skip tutorial when user starts the app again
        let defaults = UserDefaults.standard
        defaults.setValue(true, forKey: "skipTutorialPages")
        defaults.synchronize()
        
        
        let nextView: NavigationStart = self.storyboard?.instantiateViewController(withIdentifier: "NavigationID") as! NavigationStart
        self.navigationController?.pushViewController(nextView, animated: true)
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window!.rootViewController = nextView

    }
    
    
//    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "settingsID") as? Settings
//    self.navigationController?.pushViewController(vc!, animated: true)
    
}
