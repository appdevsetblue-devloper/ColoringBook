//
//  HomeVC.swift
//  ColoringBook
//
//  Created by I MAC on 15/01/18.
//  Copyright © 2018 I MAC. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var viewMenu: UIView!
    @IBOutlet weak var viewMenuheight: NSLayoutConstraint!
    
    @IBOutlet weak var viewBannerAd: UIView!
    @IBOutlet weak var bannerHeight: NSLayoutConstraint!
    
    var isAdLoaded = false
    var adTimer: Timer!
    var isAdActive : Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @IBAction func btnMenuTapped(_ sender: Any) {
      
        if isIphoneX(){
            viewMenuheight.constant = 170
        }else if isiPad(){
         viewMenuheight.constant = 300
        }else{
            viewMenuheight.constant = 150
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func btnStartTapped(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: VC_CATEGORY) as! CategoryVC
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated:true, completion:nil)
    }
    @IBAction func btnCloseMenuTapped(_ sender: Any) {
        
        viewMenuheight.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
 
    @IBAction func btnShareTapped(_ sender: Any) {
      
        let shareText = "I would really like to recommend this Colouring Book app to you. Do try it out \n https://goo.gl/qTyu4K"
        let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: [])
        vc.popoverPresentationController?.sourceView = view
        vc.popoverPresentationController?.permittedArrowDirections = [.down]
        APP_DELEGATE.window!.rootViewController?.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnRateTapped(_ sender: Any) {
        
        let openAppStoreForRating = String(format:"itms-apps://itunes.apple.com/us/app/id%@?action=write-review&mt=8", APP_STOREID)
        if UIApplication.shared.canOpenURL(URL(string: openAppStoreForRating)!) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: openAppStoreForRating)!, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
            }
        } else {
            showAlertWithTitleWithMessage(message: "Please select our app from the AppStore and write a review for us. Thanks!!")
        }
    }
    
    @IBAction func btnMoreAppTapped(_ sender: Any) {
       
        let openAppStore  = "itms-apps://itunes.apple.com/us/developer/amit-tulsiyani/id791504794"
        if UIApplication.shared.canOpenURL(URL(string: openAppStore)!) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: openAppStore)!, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
            }
        } else {
            showAlertWithTitleWithMessage(message: "Please select our app from the AppStore and select More Apps by developer!!")
        }
    }
    
}
