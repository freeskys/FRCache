//
//  ViewController.swift
//  FRCache-Example
//
//  Created by Harditya on 6/19/17.
//  Copyright © 2017 PT DOT Indonesia. All rights reserved.
//

import UIKit
import SVProgressHUD

class ViewController: UIViewController {

    var objects = [String]()
    let key = "Welcome"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadData() {
        FRCache.loadCache(withKey: key,
                          success: { (theObjects: [String]) in
            self.objects = theObjects
            
            tableView.reloadData()
        }) {
            SVProgressHUD.show()
            
            // Wait for 5 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
                self.createData()
                
                self.tableView.reloadData()
                SVProgressHUD.dismiss()
            })
        }
    }
    
    func createData() {
        var temporaryObjects = [String]()
        
        // Create new objects
        let text1 = "Welcome 1"
        let text2 = "Welcome 2"
        let text3 = "Welcome 3"
        let text4 = "Welcome 4"
        let text5 = "Welcome 5"
        
        // Append data into arrays
        temporaryObjects.append(text1)
        temporaryObjects.append(text2)
        temporaryObjects.append(text3)
        temporaryObjects.append(text4)
        temporaryObjects.append(text5)
        
        temporaryObjects.cacheArray(withKey: key)
        self.objects = temporaryObjects
    }

}

