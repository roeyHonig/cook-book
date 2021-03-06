//
//  ImagePickerTutorialViewController.swift
//  cook-book
//
//  Created by hackeru on 24 Av 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit
import Photos
import  PhotosUI

class ImagePickerTutorialViewController: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate{

    @IBOutlet var imageView: UIImageView!
    @IBAction func pickAnImageFromUsrLibary(_ sender: UIButton) {
        // TOOD: Make this work
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
        // proceed with image picker
            present(imagePicker, animated: true) {
                // compleation code
            }
        case .denied:
            // TOOD: alert dialog box
            // TODO: https://stackoverflow.com/questions/44465904/photopicker-discovery-error-error-domain-pluginkit-code-13/46928992
            // there is an explanaition there about how to send the usr for the settings of the device
            return
        case .notDetermined:
            // request access
            PHPhotoLibrary.requestAuthorization({ (status) in
                if status == PHAuthorizationStatus.authorized {
                    // proceed with image picker
                    self.present(self.imagePicker, animated: true) {
                        // compleation code
                    }
                } else {
                    return
                }
            })
        default:
            return
        }
        
        
       
    }
    let imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
    }

func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imagePicked = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = imagePicked
        }
        dismiss(animated: true) {
            //completion closer code
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
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
