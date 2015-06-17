//
//  ScribbleViewController.swift
//  CrystalClickCamera
//
//  Created by Kyle Brooks Robinson on 6/13/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

import UIKit

class ScribbleViewController: UIViewController {

    var myImage: UIImage?
    
    @IBOutlet weak var colorCollection: UICollectionView!
    
    
    @IBOutlet weak var scribblePad: ScribbleView!
    
    @IBAction func backButtonPress(sender: AnyObject) {

        
        dismissViewControllerAnimated(true, completion: nil)

        
    }
    
    @IBAction func saveButtonPress(sender: AnyObject) {
        
        
        
        
    }
    
    
    @IBAction func undoButtonPress(sender: AnyObject) {
        
        if scribblePad.scribbles.count > 0 {
            
            var removedLine = scribblePad.scribbles.removeLast()
            scribblePad.setNeedsDisplay()
            
        }
        
    }
    
    @IBAction func clearPress(sender: AnyObject) {
        
        scribblePad.scribbles = []
        scribblePad.setNeedsDisplay()
        
    }
    
    
    @IBOutlet weak var panelViewBottomConstraint: NSLayoutConstraint!
    
    
    var fillColors: [UIColor] = [
        UIColor.blackColor(),
        UIColor.grayColor(),
        UIColor.redColor(),
        UIColor.orangeColor(),
        UIColor.yellowColor(),
        UIColor.greenColor(),
        UIColor.blueColor(),
        UIColor.cyanColor(),
        UIColor.purpleColor()
    ]
    
    @IBAction func lineThickness(sender: UISlider) {
        
        var sliderSetting = sender.value
        publicSliderSetting = Double(sliderSetting)
        
    }
    
    
    @IBOutlet weak var photoImage: UIImageView!
    
    // See class reference to UIImageWriteToSavedPhotosAlbum.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        panelViewBottomConstraint.constant = -200

        
        photoImage.contentMode = .ScaleAspectFit
        photoImage.image = myImage
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func colorButtonPress(sender: AnyObject) {
        
        panelViewBottomConstraint.constant = (panelViewBottomConstraint.constant == 0) ? -200 : 0
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in })
        
    }

    @IBAction func colorSelectPress(sender: UIButton) {
        
        if let color = sender.backgroundColor {
            
            scribblePad.currentColor = color
            
        }
        
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
