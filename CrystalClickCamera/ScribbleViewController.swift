//
//  ScribbleViewController.swift
//  CrystalClickCamera
//
//  Created by Kyle Brooks Robinson on 6/13/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

// Master version

import UIKit

class ScribbleViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var myImage: UIImage?
    
    @IBOutlet weak var colorCollection: ColorCollectionView!
    
    @IBOutlet weak var scribblePad: ScribbleView!
    
    @IBAction func backButtonPress(sender: AnyObject) {

        navigationController?.popToRootViewControllerAnimated(true)
        
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
        
        
        scribblePad.currentColor = UIColor.blackColor()
        publicSliderSetting = 2

        colorCollection.dataSource = self
        colorCollection.delegate = self
        
        
    }

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if let touch = touches.first as? UITouch {
            
            let location = touch.locationInView(scribblePad)
            
            scribblePad.newScribbleWithStartPoint(location)
            
//            println(scribblePad.scribbles)
//            println(scribblePad.scribbles.count)
            
        }
        
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if let touch = touches.first as? UITouch {
            
            let location = touch.locationInView(scribblePad)
            scribblePad.addPointToCurrentScribble(location)
            
//            println(scribblePad.scribbles)
            
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! ColorCell
        
        if let color = cell.backgroundColor {
            
            scribblePad.currentColor = color
            println("The color should've changed.")
            
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("colorCell", forIndexPath: indexPath) as! ColorCell
        
        cell.backgroundColor = scribbleColors[indexPath.row]
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return scribbleColors.count
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func colorButtonPress(sender: AnyObject) {
        
        panelViewBottomConstraint.constant = (panelViewBottomConstraint.constant == 0) ? -200 : 0
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in })
        
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

var scribbleColors: [UIColor] = [

    UIColor(red:0, green:0, blue:0, alpha:1),
    UIColor(red:0.9, green:0.93, blue:0.88, alpha:1),
    UIColor(red:0.91, green:0, blue:0.05, alpha:1),
    UIColor(red:0.78, green:0.11, blue:0.01, alpha:1),
    UIColor(red:0.98, green:0.3, blue:0.31, alpha:1),
    UIColor(red:0.98, green:0.49, blue:0, alpha:1),
    UIColor(red:0.74, green:0.41, blue:0.09, alpha:1),
    UIColor(red:0.95, green:0.61, blue:0.38, alpha:1),
    UIColor(red:0.92, green:0.84, blue:0, alpha:1),
    UIColor(red:0.97, green:0.8, blue:0.1, alpha:1),
    UIColor(red:0.95, green:0.97, blue:0.35, alpha:1),
    UIColor(red:0, green:0.65, blue:0.06, alpha:1),
    UIColor(red:0.27, green:0.74, blue:0.31, alpha:1),
    UIColor(red:0.37, green:0.97, blue:0.67, alpha:1),
    UIColor(red:0.01, green:0.12, blue:0.88, alpha:1),
    UIColor(red:0.53, green:0.7, blue:0.95, alpha:1),
    UIColor(red:0.42, green:0.88, blue:0.93, alpha:1),
    UIColor(red:0.63, green:0.36, blue:0.93, alpha:1),
    UIColor(red:0.91, green:0.06, blue:0.93, alpha:1),
    UIColor(red:0.93, green:0.69, blue:0.92, alpha:1),

]











