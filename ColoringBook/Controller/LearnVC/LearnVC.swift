//
//  LearnVC.swift
//  ColoringBook
//
//  Created by Apple on 23/12/21.
//  Copyright © 2021 I MAC. All rights reserved.
//

import UIKit
import Network


extension UIView {
    
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
    func getPixelColorAt(point:CGPoint) -> UIColor{
        
        let pixel = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: 4)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        
        context!.translateBy(x: -point.x, y: -point.y)
        layer.render(in: context!)
        let color:UIColor = UIColor(red: CGFloat(pixel[0])/255.0,
                                    green: CGFloat(pixel[1])/255.0,
                                    blue: CGFloat(pixel[2])/255.0,
                                    alpha: CGFloat(pixel[3])/255.0)
        
        pixel.deallocate(capacity: 4)
        return color
    }
}

class LearnVC: UIViewController {
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblLearn: UILabel!

    var pointPrevious: CGPoint!
    var pointNext: CGPoint!

    var digitalSign : String = ""
    
    var strTitleName : String = ""
    
    var strCharacter: String = ""
    var arrLearnList: [AnyObject] = []
    
    @IBOutlet var lblByColoringBook: UILabel!
    
    @IBOutlet var viewActionButton: UIView!
    @IBOutlet var viewScroll: UIView!
    
    @IBOutlet var viewSwipe_Left: UIView!
    @IBOutlet var viewSwipe_Right: UIView!

    @IBOutlet var btnBack: UIButton!
    
    var index: Int = 0

    //MARK: - UIVIEW METHOD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblByColoringBook.isHidden = true

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(btnPrevious(_:)))
        swipeRight.direction = .right
        self.viewSwipe_Left.addGestureRecognizer(swipeRight)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(btnNext(_:)))
        swipeDown.direction = .left
        self.viewSwipe_Right.addGestureRecognizer(swipeDown)
        
        self.showData()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - UITOUCH METHOD

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.pointNext = nil
        self.pointPrevious = nil
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            
            let viewVC = touch.view
            let point: CGPoint = touch.location(in: view)

            let colorA: UIColor = self.view.getPixelColorAt(point: point)

            if viewVC == self.lblLearn && self.lblLearn.textColor == colorA {
                
                if self.pointNext != nil {
                    self.pointPrevious = self.pointNext
                }
                self.pointNext = point
                
                if self.pointPrevious != nil {
                    self.drawLineFromPoint(start: self.pointPrevious, toPoint: self.pointNext, ofColor: .red, inView: self.view)
                }
            } else {
                self.pointNext = nil
                self.pointPrevious = nil
            }
        }
    }
    
    //MARK: - BUTTON METHOD
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnNext(_ sender: UIButton) {
        self.btnRefresh(UIButton())
        if (self.arrLearnList.count - 1) > self.index {
            self.index = self.index + 1
            self.showData()
        } else {
            self.index = 0
            self.showData()
        }
        self.viewScroll.animationImage(direction: .right)
    }
    
    @IBAction func btnPrevious(_ sender: UIButton) {
        self.btnRefresh(UIButton())
        if self.index > 0 {
            self.index = self.index - 1
            self.showData()
        } else {
            self.index = self.arrLearnList.count - 1
            self.showData()
        }
        self.viewScroll.animationImage(direction: .left)
    }
    
    @IBAction func btnDownload(_ sender: Any) {
        
        let image: UIImage = self.getImageFromView()
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @IBAction func btnShare(_ sender: Any) {
        
        let image: UIImage = self.getImageFromView()
        
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)

        activityViewController.popoverPresentationController?.permittedArrowDirections = [.down]
        activityViewController.modalPresentationStyle = .fullScreen
        
        if let popOver = activityViewController.popoverPresentationController {
            popOver.sourceView = sender as! UIView
            popOver.sourceRect = (sender as AnyObject).bounds
        }

        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func btnRefresh(_ sender: Any) {
        for layer: CALayer in self.view.layer.sublayers! {
            if layer.name == "CreatedLayer" {
                layer.removeFromSuperlayer()
            }
        }
    }
    
    //MARK: - HELPER METHOD
    
    func getImageFromView() -> UIImage {
        
        self.lblLearn.isHidden = true
        self.viewActionButton.isHidden = true
        self.btnBack.isHidden = true
        self.lblByColoringBook.isHidden = false

        let image: UIImage = self.view.asImage()
        
        self.lblLearn.isHidden = false
        self.viewActionButton.isHidden = false
        self.btnBack.isHidden = false
        self.lblByColoringBook.isHidden = true
        
        return image
    }
    
    func showData() {
        let dict: [String: AnyObject] = Service.getDictFromArray(arr: self.arrLearnList, index: self.index)
        
        self.strCharacter = Service.getStringFromDict(dict: dict, key: "media_info")
        self.strCharacter = self.strCharacter.uppercased()
        self.lblLearn.text = self.strCharacter
        self.lblTitle.text = "Draw " + self.strCharacter
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            showAlertWithTitleWithMessage(message: "Please give permission to access Photos ")
        } else {
            showAlertWithTitleWithMessage(message: "Image successfully saved")
        }
    }
    
    func drawLineFromPoint(start : CGPoint, toPoint end:CGPoint, ofColor lineColor: UIColor, inView view:UIView) {
        
        //design the path
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        
        //design path in layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.name = "CreatedLayer"
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = 30.0
//        shapeLayer.fillColor = lineColor.cgColor
//        shapeLayer.backgroundColor = lineColor.cgColor
        
        self.view.layer.addSublayer(shapeLayer)
    }
    
}
