//
//  ViewController.swift
//  final
//
//  Created by Yiqiong on 9/1/20.
//  Copyright © 2020 Yiqiong. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    
   
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
   
    var postData = [String]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        // set firebase reference
        ref = Database.database().reference()
        
        // retrive the posts and listen for changes
        databaseHandle = ref?.child("Posts").observe(.childAdded, with: { (snapshot) in
            
            //code to execute when a child is added under "posts"
            //take the value from the snapshot and add to postData array
            let post = snapshot.value as? String
            if let actualPost = post{
                // Append data to postDataArray
                self.postData.append(actualPost)
                // reload data in tableview
                
                self.tableView.reloadData()
            }
            
            
        })

    }

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Data", for: indexPath)
        cell.textLabel?.text=postData[indexPath.row]
        return cell
        
       }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)  //better way to do delete. I simply delete it.
            tableView.endUpdates()
        }
        
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
}
