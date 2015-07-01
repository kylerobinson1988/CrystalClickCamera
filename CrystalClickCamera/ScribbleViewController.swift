//
//  ScribbleViewController.swift
//  CrystalClickCamera
//
//  Created by Kyle Brooks Robinson on 6/13/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

import UIKit

class ScribbleViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    // This is the image loaded in from the camera or photo library.
    var myImage: UIImage?
    
    // This is the drawing view upon which we draw Scribbles and place Item.
    @IBOutlet weak var scribblePad: ScribbleView!
    
    // The picture item you're currently using.
    var currentItem: UIImageView?
    
    // The collection of picture items you've placed.
    var pictureItems: [UIImageView] = []
    
    // The collection of graphic items we can add to the picture.
    var imageAssetsArray: [UIImage] = []
    
    // Connected to the segment control.
    var trueScribbleFalsePicture: Bool = true
    
    //Where touches begin when you place items.
    var startTouchLocation: CGPoint!
    
    // Outlet for collection of colors/items.
    @IBOutlet weak var colorCollection: ColorCollectionView!
    
    @IBOutlet weak var selectorSwitch: UISegmentedControl!
    
    @IBAction func selectorPress(sender: UISegmentedControl) {
    
        switch sender.selectedSegmentIndex {
            
            case 0:
            
            trueScribbleFalsePicture = true;
            scribblePad.setNeedsDisplay()
            
            case 1:
            
            trueScribbleFalsePicture = false;
            scribblePad.setNeedsDisplay()
            
            default:
            
            break;
            
        }
        
    }
    
    @IBAction func backButtonPress(sender: AnyObject) {

        navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    @IBAction func saveButtonPress(sender: AnyObject) {
        
        // Set scribbleview as UIImage, then save that image.
        
        let rect = scribblePad.bounds
        
        UIGraphicsBeginImageContext(self.scribblePad.bounds.size)
        let context = UIGraphicsGetCurrentContext()
        scribblePad.layer.renderInContext(context)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(newImage, nil, nil, nil)
        
    }
    
    @IBAction func undoButtonPress(sender: AnyObject) {
        
        if trueScribbleFalsePicture == true {
            
            if scribblePad.scribbles.count > 0 {
                
                var removedLine = scribblePad.scribbles.removeLast()
                scribblePad.setNeedsDisplay()
                
            }
            
        } else {
            
            if pictureItems.count > 0 {
                
                var removedItem = pictureItems.removeLast()
                scribblePad.setNeedsDisplay()
                
            }
            
        }
        
    }
    
    @IBAction func clearPress(sender: AnyObject) {
        
        if trueScribbleFalsePicture == true {
            
            scribblePad.scribbles = []
            scribblePad.setNeedsDisplay()
            
        } else {
            
            pictureItems = []
            scribblePad.setNeedsDisplay()
            
        }
        
    }
    
    @IBOutlet weak var panelViewBottomConstraint: NSLayoutConstraint!
    
    @IBAction func lineThickness(sender: UISlider) {
        
        var sliderSetting = sender.value
        publicSliderSetting = Double(sliderSetting)
        
    }
    
    func resizeImage(image: UIImage, withSize size: CGSize) -> UIImage {
        
        var scaleImageRect = CGRectMake(0, 0, size.width, size.height)
        
        if (size.height / size.width) != (image.size.height / image.size.width) {
            
            if image.size.height > image.size.width { //Portrait
                
                var ratio = size.width / image.size.width
                var newHeight = ratio * image.size.height
                var newY = (size.height - newHeight) / 2
                
                scaleImageRect = CGRectMake(0, newY, size.width, newHeight)
                
            } else { //Landscape
                
                var ratio = size.height / image.size.height
                var newWidth = ratio * image.size.width
                var newX = (size.width - newWidth) / 2
                
                scaleImageRect = CGRectMake(newX, 0, newWidth, size.height)
                
            }
            
            UIGraphicsBeginImageContext(size)
            image.drawInRect(CGRectMake(scaleImageRect.size.width - size.width, size.height - (scaleImageRect.size.height * 1.25), scaleImageRect.width / 2, scaleImageRect.height / 2))
            
//            image.drawInRect(CGRectMake(<#x: CGFloat#>, <#y: CGFloat#>, <#width: CGFloat#>, <#height: CGFloat#>))

            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            scribblePad.backgroundColor = UIColor(patternImage: newImage)
            
            
            
        }
        
        return image
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if myImage != nil {
            
            scribblePad.backgroundColor = UIColor.blackColor()
            resizeImage(myImage!, withSize: CGSizeMake(UIScreen.mainScreen().bounds.width * 2, UIScreen.mainScreen().bounds.height * 2))

        }
        
        panelViewBottomConstraint.constant = -200
        
        scribblePad.currentColor = UIColor.blackColor()
        publicSliderSetting = 2

        colorCollection.dataSource = self
        colorCollection.delegate = self
        
        
    }

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if trueScribbleFalsePicture == true {
            
            if let touch = touches.first as? UITouch {
                
                let location = touch.locationInView(scribblePad)
                
                scribblePad.newScribbleWithStartPoint(location)
                
                //            println(scribblePad.scribbles)
                //            println(scribblePad.scribbles.count)
                
            }
            
        } else {
            
            if touches.count > 1 { return } // Don't move image if more than one touch.
            
            if let touch = touches.first as? UITouch {
                
                startTouchLocation = touch.locationInView(view)
                
            }
            
        }
        
        
        
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if trueScribbleFalsePicture == true {
            
            if let touch = touches.first as? UITouch {
                
                let location = touch.locationInView(scribblePad)
                scribblePad.addPointToCurrentScribble(location)
                
                //            println(scribblePad.scribbles)
                
            }
            
        } else {
            
            if touches.count > 1 { return } // Don't move image if more than one touch.
            
            if let touch = touches.first as? UITouch {
                
                let location = touch.locationInView(view)
                
                let distance = CGPointMake(location.x - startTouchLocation.x, location.y - startTouchLocation.y)
                
                if let currentItem = currentItem {
                    
                    currentItem.center = CGPointMake(currentItem.center.x + distance.x, currentItem.center.y + distance.y)
                    
                }
                
                startTouchLocation = location
                
            }
            
        }
        
        
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! ColorCell
        
        if trueScribbleFalsePicture == true {
            
            if let color = cell.itemView.backgroundColor {
                
                scribblePad.currentColor = color
                println("The color should've changed.")
                
            } else {
                
                if let selectedCell = cell.itemView {
                    
                    // This following line might need to be changed back.
                    currentItem = UIImageView(frame: CGRectMake(0, 0, 200, 200))
                    currentItem?.contentMode = .ScaleAspectFit
                    currentItem!.image = UIImage(named: "\(indexPath.row)")
                    currentItem!.center = view.center
                    
                    scribblePad.addSubview(currentItem!)
                    pictureItems.append(currentItem!)
                    
                    //Check this line.
//                    currentItem = currentItem!
                    
                }
                
            }
            
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("colorCell", forIndexPath: indexPath) as! ColorCell
        
        if trueScribbleFalsePicture {
            
            cell.itemView.backgroundColor = scribbleColors[indexPath.row]
            
            return cell
            
        } else {
            
            cell.itemView.image = imageAssetsArray[indexPath.row]
            
            return cell
            
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if trueScribbleFalsePicture == true {
            
            return scribbleColors.count
            
        } else {
            
            return imageAssetsArray.count
            
        }
        
    }
    
    func resizeItem(gr: UIPinchGestureRecognizer) {
        
        if let currentItem = currentItem {
            
            let width = currentItem.frame.width
            let height = currentItem.frame.height
            
            currentItem.frame.size.height = height + gr.velocity
            currentItem.frame.size.width = width + gr.velocity
            
        }
        
        
    }
    
    func addNewItem() {
        
        var newItemView = UIImageView(frame: CGRectMake(0, 0, 200, 200))
        
        newItemView.image = UIImage(named: "Item")
        newItemView.center = view.center
        
        scribblePad.addSubview(newItemView)
        pictureItems.append(newItemView)
        
        currentItem = newItemView
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Button that shows or hides the color/itme control panel.
    @IBAction func colorButtonPress(sender: AnyObject) {
        
        panelViewBottomConstraint.constant = (panelViewBottomConstraint.constant == 0) ? -200 : 0
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in })
        
    }
    
    func fetchImagefromS3(image: UIImage) {
        
        s3Manager.requestSerializer.bucket = bucket
        s3Manager.requestSerializer.region = AFAmazonS3USStandardRegion
        //                s3Manager.requestSerializer.setValue("public-read", forHTTPHeaderField: "x-amz-acl")
        
//        let username = RailsRequest.session().username
        
        
//        let imageName = 
        
//        let imageData = UIImagePNGRepresentation(image)
        
        let amazonS3Manager = AmazonS3RequestManager(bucket: myAmazonS3Bucket,
            region: .USStandard,
            accessKey: accessKey,
            secret: secret)
        
        if let documentPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first as? String {
            
            println(imageName)
            
            let filePath = documentPath.stringByAppendingPathComponent(imageName + ".png")
            
            println(filePath)
            
            imageData.writeToFile(filePath, atomically: false)
            
            let fileURL = NSURL(fileURLWithPath: filePath)
            
            s3Manager.putObjectWithFile(filePath, destinationPath: imageName + ".png", parameters: nil, progress: { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) -> Void in
                
                let percentageWritten = (CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite) * 100.0)
                
                println("Uploaded \(percentageWritten)%")
                
                }, success: { (responseObject) -> Void in
                    
                    let info = responseObject as! AFAmazonS3ResponseObject
                    
                    self.newURL = info.URL.absoluteString
                    
                    RailsRequest.session().postImage(self.newURL, answer: self.captionTextField.text, completion: { () -> Void in
                        
                        
                    })
                    
                    println("\(responseObject)")
                    
                }, failure: { (error) -> Void in
                    
                    println("\(error)")
                    
            })
            
        }

}

    
// The colors I've pre-set for use in the app.
let scribbleColors: [UIColor] = [

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








