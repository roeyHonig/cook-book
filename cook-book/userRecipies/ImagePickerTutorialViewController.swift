//
//  ImagePickerTutorialViewController.swift
//  cook-book
//
//  Created by hackeru on 24 Av 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit

class ImagePickerTutorialViewController: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate{

    @IBOutlet var imageView: UIImageView!
    @IBAction func pickAnImageFromUsrLibary(_ sender: UIButton) {
        // TOOD: Make this work
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true) {
            // compleation code
        }
    }
    let imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imagePicked = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = imagePicked
            print("was here")
        }
        dismiss(animated: true) {
            //completion closer code
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        imagePicker.delegate = self
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
