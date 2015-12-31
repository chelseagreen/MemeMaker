//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Chelsea Green on 12/27/15.
//  Copyright © 2015 Chelsea Green. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
        
    // Image view that will contain the memed image
    
    @IBOutlet weak var imageView: UIImageView!
    
    var memeIndex: Int!
    var meme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        imageView.image = meme.memedImage
    }
    
    @IBAction func deleteMeme(sender: UIBarButtonItem) {
        MemeManager.sharedInstance.deleteMemeAtIndex(self.memeIndex)
        navigationController?.popViewControllerAnimated(true)
    }
    
}