//
//  MainViewController.swift
//  StackOverflowAnswer
//
//  Created by Nutchaphon Rewik on 7/13/15.
//  Copyright (c) 2015 Nutchaphon Rewik. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    var numberOfItem = 0{
        didSet{
            totalLabel?.text = "\(numberOfItem)"
        }
    }
    
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        
        //get notify when tableView.contentSize is updated.
        tableView.addObserver(self, forKeyPath: "contentSize", options: .New, context: nil)
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        
        //Whenever tableView notify that contentSize is updated. We animate tableView's Height.
        if object === tableView && keyPath == "contentSize"{
            tableViewHeightConstraint.constant = tableView.contentSize.height
            UIView.animateWithDuration(0.3){
                self.view.layoutIfNeeded()
            }
        }else{
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
    
    deinit{
        tableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    @IBAction func insertButtonPressed() {
        
        let indexPath = NSIndexPath(forRow: numberOfItem, inSection: 0)
        numberOfItem = numberOfItem + 1
        
        tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths( [indexPath] , withRowAnimation: .Automatic)
        tableView.endUpdates()
        
        //always scroll to bottom when insert new item
        if tableView.contentSize.height > tableView.frame.height{
            tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
        }
    }
    
    @IBAction func deleteButtonPressed() {
        
        if numberOfItem > 0{

            numberOfItem = numberOfItem - 1
            let indexPath = NSIndexPath(forRow: numberOfItem, inSection: 0)
            tableView.beginUpdates()
            tableView.deleteRowsAtIndexPaths( [indexPath] , withRowAnimation: .Automatic)
            tableView.endUpdates()
        }
    }
    
}

extension MainViewController: UITableViewDataSource{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = "Item: \(indexPath.row)"
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItem
    }
}