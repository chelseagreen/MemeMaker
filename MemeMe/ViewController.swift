//
//  ViewController.swift
//  MemeMe
//
//  Created by Chelsea Green on 12/15/15.
//  Copyright © 2015 Chelsea Green. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imageViewPicker: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var navBar: UIToolbar!
    var activeTextField = UITextField()
    
    override func viewDidLoad() {
        
        topTextField.hidden = true
        bottomTextField.hidden = true
        
        // Set text field styling
        let memeTextAttributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSStrokeColorAttributeName: UIColor.blackColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : NSNumber(double: -3.0)
        ]
        
        // For text field delegate methods
        topTextField.delegate = self
        bottomTextField.delegate = self
        
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = .Center
        
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.textAlignment = .Center
        
        shareButton.enabled = false
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // Camera button only enabled if camera exists on device
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        subscribeToKeyboardNotifications()

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeFromKeyboardNotifications()
       
    }
    
    @IBAction func PickAnImageFromAlbum(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera (sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // UI Image Picker Controller Delegate Methods
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        let pickedImage : UIImage = image
        
        imageViewPicker.contentMode = .ScaleAspectFit
        //imageViewPicker.frame = CGRectMake(0, 0, 100, 200);
    
        imageViewPicker.image = pickedImage
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        topTextField.hidden = false
        bottomTextField.hidden = false
        shareButton.enabled = true 
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
            self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // UI Text Field Delegate Methods
    func textFieldDidBeginEditing(textField: UITextField) {
        activeTextField = textField
        textField.text = ""
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        activeTextField.resignFirstResponder()
        return true
    }
    
    //Keyboard Notifications
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:"    , name: UIKeyboardWillShowNotification, object: nil)
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:"    , name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
    }
    
    //Slide up view for bottom text field based on keyboard height
    func keyboardWillShow(notification: NSNotification) {
        if activeTextField == bottomTextField {
        view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if activeTextField == bottomTextField {
        view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    //Save and share meme
    @IBAction func shareMeme(sender: UIBarButtonItem) {
        //  generate a memed image
        let memedImage = generateMemedImage()
        
        // define an instance of the ActivityViewController
        // pass the ActivityViewController a memedImage as an activity item
        let activity = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        activity.completionWithItemsHandler = {
            (activity, success, items, error) in
                // Save meme and dismiss
                self.saveMeme(memedImage)
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        
        // present the ActivityViewController
        presentViewController(activity, animated: true, completion: nil)
    }
        
    @IBAction func cancelMeme(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func generateMemedImage() -> UIImage {
        toolBar.hidden = true
        navBar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        toolBar.hidden = false
        navBar.hidden = false
        
        return memedImage
    }
    
    func saveMeme(memedImage: UIImage) {
        // New meme
        let meme = Meme(top: topTextField.text!, bottom: bottomTextField.text!, image: imageViewPicker.image!, memedImage: memedImage)
    }
    
}
