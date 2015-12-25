//
//  Meme.swift
//  MemeMe
//
//  Created by Chelsea Green on 12/24/15.
//  Copyright © 2015 Chelsea Green. All rights reserved.
//

import Foundation
import UIKit


// Class tha represents a meme with a image, top and bottom texts
struct Meme {
    
    // Meme elements
    var top: String
    var bottom: String
    var image: UIImage
    
    // The actual meme image. It was built using the meme elemets
    var memedImage: UIImage
}

