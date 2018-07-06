//
//  favoriteRecipesViewController.swift
//  cook-book
//
//  Created by hackeru on 16 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//  currentlly just an example for loading url image

import UIKit
import SDWebImage

class favoriteRecipesViewController: UIViewController {
    @IBOutlet var testImage: UIImageView!
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        let url = URL(string: "https://images.media-allrecipes.com/userphotos/720x405/4517193.jpg")
        
        testImage.sd_setImage(with: url, completed: nil)
        
        var main_string = "Hello World"
        let string_to_color = "Hello"
        
        let range = (main_string as NSString).range(of: string_to_color)
        
        let attribute = NSMutableAttributedString.init(string: main_string)
        
        attribute.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: range)
        
        label.attributedText = attribute
        
        //label.attributedText =
        
        /*
         
         let txtfield1 :UITextField!
         
         var main_string = "Hello World"
         let string_to_color = "World"
         
         let range = (main_string as NSString).range(of: string_to_color)
         
         let attribute = NSMutableAttributedString.init(string: main_string)
         attribute.addAttribute(NSForegroundColorAttributeName, value: UIColor.red , range: range)
         
         
         txtfield1 = UITextField.init(frame:CGRect(x:10 , y:20 ,width:100 , height:100))
         txtfield1.attributedText = attribute
         
         */
        
        
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
