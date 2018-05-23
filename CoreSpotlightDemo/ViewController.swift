//
//  ViewController.swift
//  CoreSpotlightDemo
//
//  Created by Candy on 2018/5/21.
//  Copyright © 2018年 com.CandyHu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myDescTextView: UITextView!
    
    var contentInfo: (String, String, String)? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if contentInfo != nil {
            self.navigationItem.title = contentInfo!.0
            myDescTextView.text = contentInfo!.1
            myImageView.image = UIImage(named: contentInfo!.2)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

