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
    }
    
    func setupSegmentedControl() {
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "Sign In", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Sign In", at: 1, animated: false)
        segmentedControl.addTarget(self, action: #selector(selectionDidChanged(sender:)), for: UIControlEvents.valueChanged )
        
        segmentedControl.selectedSegmentIndex = 0
    }
    
    @objc func selectionDidChanged(sender: UISegmentedControl) {
        print("SC changed")
    }

}

