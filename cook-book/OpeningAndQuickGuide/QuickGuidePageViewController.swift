//
//  QuickGuidePageViewController.swift
//  cook-book
//
//  Created by hackeru on 11 Av 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit

class QuickGuidePageViewController: UIPageViewController , UIPageViewControllerDelegate , UIPageViewControllerDataSource {
    
    var tapToSkip = UITapGestureRecognizer()
    var tapToSkipAndNeverShowAgain = UITapGestureRecognizer()
    
    lazy var pages: [UIViewController] = {
        return [instenceOfVC(named: "cookQG"), instenceOfVC(named: "shopQG"), instenceOfVC(named: "customizeQG") ]
    }()
    
    func instenceOfVC(named id: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: id)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentPageIndex = pages.index(of: viewController) else {
            return nil
        }
        
        guard currentPageIndex > 0 else {
            return nil
        }
        
        return pages[currentPageIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentPageIndex = pages.index(of: viewController) else {
            return nil
        }
        
        guard currentPageIndex < (pages.count - 1) else {
            return nil
        }
        
        return pages[currentPageIndex + 1]
    }
    
    // The number of items reflected in the page indicator.
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    // The selected item reflected in the page indicator.
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = pages.first , let firstViewControllerIndex = pages.index(of: firstViewController) else {
            return 0
        }
        
        return firstViewControllerIndex
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.delegate = self
        self.dataSource = self
        
        
        setViewControllers([pages.first!], direction: .forward, animated: true, completion: nil)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for v in view.subviews {
            if v is UIScrollView {
                v.frame = UIScreen.main.bounds
            } else if v is UIPageControl {
                v.backgroundColor = UIColor.clear
                
                // setup "skip" label
                let rect = CGRect(x: view.bounds.minX + 5, y: view.bounds.maxY - v.bounds.height - 60, width: 60, height: 60)
                let skipLabel = UILabel(frame: rect)
                skipLabel.text = "Skip"
                skipLabel.backgroundColor = UIColor.clear
                skipLabel.isUserInteractionEnabled = true // very important
                
                // setup TapGestuere
                tapToSkip.addTarget(self, action: #selector(GoToApp))
                skipLabel.addGestureRecognizer(tapToSkip)
                // add the view
                view.addSubview(skipLabel)
                
                // setup "never Show agin label"
                let rect2 = CGRect(x: view.bounds.maxX - 165, y: view.bounds.maxY - v.bounds.height - 60, width: 160, height: 60)
                let skipLabel2 = UILabel(frame: rect2)
                skipLabel2.text = "Never Show Again"
                skipLabel2.textAlignment = NSTextAlignment.right
                skipLabel2.backgroundColor = UIColor.clear
                skipLabel2.isUserInteractionEnabled = true // very important
                
                // setup taping gestuere
                tapToSkipAndNeverShowAgain.addTarget(self, action: #selector(GoToAppAndNeverShowAgain))
                skipLabel2.addGestureRecognizer(tapToSkipAndNeverShowAgain)
                // add the view
                view.addSubview(skipLabel2)
                
                
                
            }
            
        }
    }

    
    
    @objc func GoToApp() {
        print("skip was clicked")
        performSegue(withIdentifier: "goToTheApp", sender: self)
    }
    
    @objc func GoToAppAndNeverShowAgain() {
        //TODO: app delegate defults to never show again
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        appDelegate.defults.set(true, forKey: "shouldSkipQuickGuid")
        GoToApp()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
