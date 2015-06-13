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
        
        self.view.addSubview(imagePick.view)
//        imagePick.view.bounds.width == screenWidth
//        imagePick.view.bounds.height == screenHeight
        
        let buttonSize: Int = 80
        
    }

    
    func toggleCamera() {
        
        if imagePick.cameraDevice == UIImagePickerControllerCameraDevice.Front {
            
            imagePick.cameraDevice = UIImagePickerControllerCameraDevice.Rear
            
        } else {
            
            imagePick.cameraDevice = UIImagePickerControllerCameraDevice.Front
            
        }
        
    }
    
    func takePhoto() {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            
            
        
        imagePick.allowsEditing = false
        imagePick.sourceType = UIImagePickerControllerSourceType.Camera
        imagePick.cameraCaptureMode = .Photo
            
            println("Camera is working A-OK.")
        
        } else {
            
            println("No camera available.")
            
        }
        
    }
    

    // MARK: Delegates
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        var newPhoto = info[UIImagePickerControllerOriginalImage] as? UIImage

        photoCollection.insert(newPhoto!, atIndex: 0)
        
        storyboard?.instantiateViewControllerWithIdentifier("photoCollectionVC") as! PhotoCollectionViewController
        
        
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
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
