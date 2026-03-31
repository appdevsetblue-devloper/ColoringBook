//
//  PaintingTestVC.swift
//  ColoringBook
//
//  Created by I MAC on 19/01/18.
//  Copyright © 2018 I MAC. All rights reserved.
//

import UIKit
import Photos

extension UIView {
    
    func animationImage(direction: UISwipeGestureRecognizerDirection) {
        
        let leftToRight: CATransition = CATransition()
        leftToRight.type = kCATransitionPush

        if direction == .right {
            leftToRight.subtype = kCATransitionFromRight
        } else {
            leftToRight.subtype = kCATransitionFromLeft
        }
        
        leftToRight.duration = 0.5
        leftToRight.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        leftToRight.fillMode = kCAFillModeRemoved
        self.layer.add(leftToRight, forKey: "leftToRightTransition")

    }
    
}

class PaintingTestVC: BaseVC, DTColorPickerDelegate {
    
    @IBOutlet weak var viewBannerAd: UIView!
    @IBOutlet weak var heightBanner: NSLayoutConstraint!
    @IBOutlet weak var imageScrollView: UIScrollView!
    
    @IBOutlet var imgFillImage: FloodFillImageView!
    
    @IBOutlet weak var ViewScroll: UIView!
    @IBOutlet weak var lblColor: UILabel!
    @IBOutlet weak var viewNavHeight: NSLayoutConstraint!
    @IBOutlet weak var colorPicker: DTColorPicker!
    @IBOutlet weak var lblTitleName: UILabel!
    
    var selectedColor : UIColor!
    var digitalSign : String = ""
    
    var editImage : UIImage = UIImage()
    var strTitleName : String = ""
    
    var arrPaintingImage: [AnyObject] = []
    var index: Int = 0
    
    var isAdLoaded = false
    var adTimer: Timer!
    var isAdActive : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(btnPreviousTapped(_:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(btnNextTapped(_:)))
        
        swipeDown.direction = .left
        self.view.addGestureRecognizer(swipeDown)
        
        self.showData()
    }
    
    func showData() {
        
        self.lblTitleName.text = self.strTitleName
        digitalSign = ""
        selectedColor = UIColor.white
        lblColor.backgroundColor = selectedColor
        colorPicker.delegate = self
        
        self.imgFillImage.newcolor = self.selectedColor
        self.imgFillImage.tolorance = 100
        
        let dict: [String: AnyObject] = Service.getDictFromArray(arr: self.arrPaintingImage, index: self.index)
        
        let strMediaURL: String = Service.getStringFromDict(dict: dict, key: RESPONSE.media_file)
        
        if let url: URL = URL(string: strMediaURL) {
            self.imgFillImage.sd_setImage(with: url) { image, error, cache, url in
                self.editImage = image!
                self.imgFillImage.image = self.editImage
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    @IBAction func btnSaveTapped(_ sender: Any) {
        
        if digitalSign == ""{
            
            let txtTemp : UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 15))
            txtTemp.text = "By : Colouring Book"
            txtTemp.textColor = .black
            txtTemp.font = UIFont(name: "Dosis-Book", size: 10)
            txtTemp.numberOfLines = 0
            txtTemp.sizeToFit()
            txtTemp.frame = CGRect(x: self.imgFillImage.frame.width - txtTemp.frame.width - 5 , y: self.imgFillImage.frame.height - txtTemp.frame.height - 5 , width: txtTemp.frame.width, height: txtTemp.frame.height)
            self.imgFillImage.addSubview(txtTemp)
            digitalSign = "available"
            
            let imgDoe : UIImage = createImage()
            self.imgFillImage.image = imgDoe
            
            UIImageWriteToSavedPhotosAlbum(self.imgFillImage.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }else{
            let imgDoe : UIImage = createImage()
            self.imgFillImage.image = imgDoe
            
            UIImageWriteToSavedPhotosAlbum(self.imgFillImage.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    //MARK: - Add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            showAlertWithTitleWithMessage(message: "Please give permission to access Photos ")
            let settingsUrl = URL(string: UIApplicationOpenSettingsURLString)
            UIApplication.shared.openURL(settingsUrl!)
            print(error)
        } else {
            showAlertWithTitleWithMessage(message: "Your altered image has been saved to your photos")
        }
    }
    
    //MARK:- Image Share on social Media
    @IBAction func btnShareTapped(_ sender: Any) {
        
        if digitalSign == ""{
            let txtTemp : UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 15))
            txtTemp.text = "By : Colouring Book"
            txtTemp.textColor = .black
            txtTemp.font = UIFont(name: "Dosis-Book", size: 10)
            txtTemp.numberOfLines = 0
            txtTemp.sizeToFit()
            txtTemp.frame = CGRect(x: self.imgFillImage.frame.width - txtTemp.frame.width - 5 , y: self.imgFillImage.frame.height - txtTemp.frame.height - 5 , width: txtTemp.frame.width, height: txtTemp.frame.height)
            self.imgFillImage.addSubview(txtTemp)
            digitalSign = "available"
        }
        
        let imgDoe : UIImage = createImage()
        self.imgFillImage.image = imgDoe
        
        let fileManager = FileManager.default
        let documentsDirectoryURL = try! FileManager().url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
       // let fname = self.arrPaintingImage[index]
        var theFileName = "a" + ".png"
        if theFileName == ""{
            theFileName = "ColouringBook.png"
        }
        let fileURL = documentsDirectoryURL.appendingPathComponent(theFileName)
        let pdfDoc = UIImagePNGRepresentation(self.imgFillImage.image!)
        
        do {
            try pdfDoc?.write(to: fileURL)
        } catch {
            print(error)
        }
        if fileManager.fileExists(atPath: fileURL.path){
            let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
            
            activityViewController.popoverPresentationController?.permittedArrowDirections = [.down]
            // activityViewController.popoverPresentationController?.sourceView = viewShare
            activityViewController.modalPresentationStyle = .fullScreen
            
            self.present(activityViewController, animated: true, completion: nil)
            if let popOver = activityViewController.popoverPresentationController {
                popOver.sourceView = sender as! UIView
                popOver.sourceRect = (sender as AnyObject).bounds
            }
            APP_DELEGATE.removeLoader()
        }
        else {
            showAlertWithTitleWithMessage(message: "Something went wrong while getting Image, Please try gain!")
            APP_DELEGATE.removeLoader()
        }
    }
    @IBAction func btnCancelEditingTapped(_ sender: Any) {
        self.imgFillImage.image = self.editImage
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.dismissController()
    }
    
    @IBAction func btnNextTapped(_ sender: Any) {
        if (self.arrPaintingImage.count - 1) > self.index {
            self.index = self.index + 1
            self.showData()
            self.ViewScroll.animationImage(direction: .right)
        }
    }
    
    @IBAction func btnPreviousTapped(_ sender: Any) {
        if self.index > 0 {
            self.index = self.index - 1
            self.showData()
            self.ViewScroll.animationImage(direction: .left)

        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createImage() -> UIImage{
        UIGraphicsBeginImageContextWithOptions(self.imgFillImage.bounds.size, false, 0)
        let context : CGContext  = UIGraphicsGetCurrentContext()!
        self.imgFillImage.layer.render(in: context)
        let imgs: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return imgs
    }
    override func viewDidLayoutSubviews() {
        
        if hasTopNotch{
            //            viewNavHeight.constant = 100.0
        }
        updateMinZoomScaleForSize(ViewScroll.bounds.size)
    }
    func DTColorColorPickerTouched(sender: DTColorPicker, color: UIColor, point: CGPoint, state: UIGestureRecognizerState) {
        
        selectedColor = color
        lblColor.backgroundColor = selectedColor
        self.imgFillImage.newcolor = self.selectedColor
    }
    //MARK: Zoomming
    fileprivate func updateMinZoomScaleForSize(_ size: CGSize) {
        
        let widthScale = size.width / self.imgFillImage.bounds.width
        let heightScale = size.height / self.imgFillImage.bounds.height
        let minScale = min(widthScale, heightScale)
        
        imageScrollView.minimumZoomScale = minScale
        imageScrollView.maximumZoomScale = 4
        imageScrollView.zoomScale = minScale
    }
}

//MARK: UIScrollView Delegate
extension PaintingTestVC:UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imgFillImage
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
        ViewScroll.layoutIfNeeded()
        
        if scrollView.zoomScale == scrollView.minimumZoomScale {
            scrollView.isScrollEnabled = false
        }else{
            scrollView.isScrollEnabled = true
        }
    }
}
