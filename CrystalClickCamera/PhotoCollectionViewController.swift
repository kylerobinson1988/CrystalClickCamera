//
//  FilterViewController.swift
//  CrystalClickCamera
//
//  Created by Kyle Brooks Robinson on 6/13/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

import UIKit

var photoCollection: [UIImage] = []

class PhotoCollectionViewController: UIViewController {

    @IBAction func backButton(sender: AnyObject) {
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        println("Back button pressed.")
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

