//
//  QuickGuidePageViewController.swift
//  cook-book
//
//  Created by hackeru on 11 Av 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit

class QuickGuidePageViewController: UIPageViewController , UIPageViewControllerDelegate , UIPageViewControllerDataSource {
    
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
            }
            
        }
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
