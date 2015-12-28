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
    
    // MARK: -
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "editMeme:")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.imageView.image = meme.memedImage
    }
    
}
