//
//  ViewController.swift
//  cook-book
//
//  Created by hackeru on 3 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit

class MyRecipiesViewController: UIViewController {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    lazy var signInViewController: SignInViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    lazy var CurrentUserRecipiesViewController: CurrentUserRecipiesViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "CurrentUserRecipiesViewController") as! CurrentUserRecipiesViewController
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
   

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupView() {
        setupSegmentedControl()
        updateView()
    }
    
    func setupSegmentedControl() {
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "Sign In", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Recipies", at: 1, animated: false)
        segmentedControl.addTarget(self, action: #selector(selectionDidChanged(sender:)), for: UIControlEvents.valueChanged )
        
        segmentedControl.selectedSegmentIndex = 0
    }
    
    @objc func selectionDidChanged(sender: UISegmentedControl) {
        updateView()
    }
    
    func updateView() {
        print("SC changed")
        signInViewController.view.isHidden = !(segmentedControl.selectedSegmentIndex == 0)
        CurrentUserRecipiesViewController.view.isHidden = (segmentedControl.selectedSegmentIndex == 0)
    }
    
    func addViewControllerAsChildViewController(childViewController: UIViewController) {
        addChildViewController(childViewController)
        
        // uncomment the follwoing if you want the childViewController to populate the entire view of the parent viewController
        /*
        self.view.addSubview(childViewController.view)
        childViewController.view.frame = self.view.bounds
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        */
        
        containerView.addSubview(childViewController.view)
        childViewController.view.frame = containerView.bounds
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        childViewController.didMove(toParentViewController: self)
    }

}

