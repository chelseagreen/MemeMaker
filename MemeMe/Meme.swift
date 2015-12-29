//
//  Meme.swift
//  MemeMe
//
//  Created by Chelsea Green on 12/24/15.
//  Copyright © 2015 Chelsea Green. All rights reserved.
//

import Foundation
import UIKit

// Struct represents a meme with a image and text fields 
struct Meme {
    
    // Meme elements
    var top: String
    var bottom: String
    var image: UIImage
    
    // The actual meme image.
    var memedImage: UIImage
    
}

// Class used to create a shared meme array
class MemeManager: NSObject {
    
    class var sharedInstance: MemeManager {
        struct Static {
            static var instance: MemeManager?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = MemeManager()
        }
        
        return Static.instance!
    }
    
    // Shared model representing the list of sent memes
    var memes = [Meme]()
    
    func deleteMemeAtIndex(index: Int) {
        memes.removeAtIndex(index)
    }
    
    func appendMeme(meme: Meme) {
        memes.append(meme)
    }
}