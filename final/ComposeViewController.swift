//
//  composeview.swift
//  final
//
//  Created by Yiqiong on 9/1/20.
//  Copyright © 2020 Yiqiong. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ComposeViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    var ref:DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }
    
    @IBAction func addPost(_ sender:Any) {
        ref?.child("Posts").childByAutoId().setValue(textView.text)
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelPost(_ sender:Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
