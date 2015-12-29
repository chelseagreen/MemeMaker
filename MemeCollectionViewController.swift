//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Chelsea Green on 12/26/15.
//  Copyright © 2015 Chelsea Green. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space: CGFloat = 3.0
        let dimension = (self.view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)

        self.clearsSelectionOnViewWillAppear = false
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Refresh the local memes reference
        memes = MemeManager.sharedInstance.memes
        
        // Refresh collection
        collectionView?.reloadData()
    }
    
    // UICollectionViewDataSource

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
        
        let meme = memes[indexPath.item]
        
        cell.memeImageView.image = meme.memedImage
        
        return cell
        
    }
    
    // UICollectionView Delegate 
    
    override func collectionView(tableView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let meme = memes[indexPath.item]
        
        let destinationController =
        storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        destinationController.meme = meme
        destinationController.memeIndex = indexPath.item
        
        self.navigationController?.pushViewController(destinationController, animated: true)
    }
    
}
