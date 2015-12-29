//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Chelsea Green on 12/26/15.
//  Copyright © 2015 Chelsea Green. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    var memes: [Meme]!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = false

        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        // Refresh local memes instance
        memes = MemeManager.sharedInstance.memes
        // Refresh the table list
        tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count 
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell") as! TableViewCell
        
        let meme = memes[indexPath.row]
        
        cell.memeImageView.image = meme.memedImage
        cell.memeLabel.text = buildMemeTextSummary(meme)
        
        return cell
    }
    
    // Creates a string to display as the meme summary in a cell
    func buildMemeTextSummary(meme: Meme) -> String {
        let topCount = meme.top.characters.count
        let bottomCount = meme.bottom.characters.count
        
        let topSubstring = meme.top
        let bottomSubstring = meme.bottom
        
        return "\(topSubstring). \(bottomSubstring)"
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch editingStyle {
        case .Delete:
            removeMemeAtIndexPath(indexPath)
        default:
            return
        }
    }
    
    func removeMemeAtIndexPath(indexPath: NSIndexPath) {
        // remove the deleted item from the model
        MemeManager.sharedInstance.deleteMemeAtIndex(indexPath.row)
        memes = MemeManager.sharedInstance.memes
        // remove the deleted item from the `UITableView`
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    
    // MARK: - Table view delegate 
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let meme = memes[indexPath.row]
        
        let destinationController =
            storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        destinationController.meme = meme
        destinationController.memeIndex = indexPath.row
        
        self.navigationController?.pushViewController(destinationController, animated: true)
    }

    
}
