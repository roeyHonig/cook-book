//
//  QuickGuidePageViewController.swift
//  cook-book
//
//  Created by hackeru on 11 Av 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit

class QuickGuidePageViewController: UIPageViewController , UIPageViewControllerDelegate , UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        <#code#>
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        <#code#>
    }
    
    // The number of items reflected in the page indicator.
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        
    }
    
    // The selected item reflected in the page indicator.
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.delegate = self
        self.dataSource = self
        
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
