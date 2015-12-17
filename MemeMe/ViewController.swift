//
//  ViewController.swift
//  MemeMe
//
//  Created by Chelsea Green on 12/15/15.
//  Copyright © 2015 Chelsea Green. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    //Use this in the two delegate methods to pick cancel
    //self.dismissViewControllerAnimated(true, completion: nil)

    @IBOutlet weak var imageViewPicker: UIImageView!
    
    @IBAction func PickAnImage(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
        
    // UI Image Picker Controller Delegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        let pickedImage : UIImage = image
        imageViewPicker.contentMode = .ScaleAspectFit
        imageViewPicker.image = pickedImage
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
        func imagePickerControllerDidCancel(picker: UIImagePickerController) {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    
}

