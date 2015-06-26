//
//  CameraViewController.swift
//  CrystalClickCamera
//
//  Created by Kyle Brooks Robinson on 6/13/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    let imagePick = UIImagePickerController()
    
    @IBOutlet weak var mainButtonOutlet: MainButton!
    @IBOutlet weak var flipButtonOutlet: FlipButton!
    
    @IBAction func mainButtonClick(sender: AnyObject) {
        
        takePhoto()
      
    }
    
    @IBAction func flipButtonClick(sender: AnyObject) {
        
        toggleCamera()
        
    }
    
    @IBAction func backButton(sender: AnyObject) {
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }

    
    
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let screenHeight = UIScreen.mainScreen().bounds.size.height

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        imagePick.sourceType = UIImagePickerControllerSourceType.Camera
        imagePick.delegate = self
        imagePick.showsCameraControls = true
        
        // find black bar property and disable it?
        
//        imagePick.view.frame = CGRectMake(0, 0, screenWidth, screenHeight - 180)
        
        self.view.addSubview(imagePick.view)
        
        
    }

    
    func toggleCamera() {
        
        if imagePick.cameraDevice == UIImagePickerControllerCameraDevice.Front {
            
            imagePick.cameraDevice = UIImagePickerControllerCameraDevice.Rear
            
        } else {
            
            imagePick.cameraDevice = UIImagePickerControllerCameraDevice.Front
            
        }
        
    }
    
    func takePhoto() {
        
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
//            
//            
//        
//        imagePick.allowsEditing = false
//        imagePick.sourceType = UIImagePickerControllerSourceType.Camera
//        imagePick.cameraCaptureMode = .Photo
//            
//            println("Camera is working A-OK.")
//        
//        } else {
//            
//            println("No camera available.")
//            
//        }
        
//        imagePickerController(imagePick, didFinishPickingMediaWithInfo: [NSObject : AnyObject].self)
    }
    

    // MARK: Delegates
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        var chosenPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let scribbleVC = storyboard?.instantiateViewControllerWithIdentifier("scribbleViewVC") as! ScribbleViewController
        
        self.navigationController?.pushViewController(scribbleVC, animated: true)
        
        scribbleVC.myImage = chosenPhoto
        
        dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        println("Back button pressed.")
        

    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
