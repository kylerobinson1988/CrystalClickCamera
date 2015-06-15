//
//  WelcomeViewController.swift
//  CrystalClickCamera
//
//  Created by Kyle Brooks Robinson on 6/13/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

import UIKit

var theChosenPhoto: UIImage?

class WelcomeViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    let imagePick = UIImagePickerController()
    
    @IBAction func choosePictureButton(sender: AnyObject) {
        
        imagePick.allowsEditing = false
        imagePick.sourceType = .PhotoLibrary
        presentViewController(imagePick, animated: true, completion: nil)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePick.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        var chosenPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let scribbleVC = storyboard?.instantiateViewControllerWithIdentifier("scribbleViewVC") as! ScribbleViewController
        
        self.navigationController?.pushViewController(scribbleVC, animated: true)
        
        scribbleVC.myImage = chosenPhoto
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
