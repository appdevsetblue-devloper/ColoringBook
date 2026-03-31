//
//  BaseVC.swift
//  NewsRoll
//
//  Created by Setblue on 10/10/17.
//  Copyright © 2017 V2ideas. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {
    
    var btnleft: UIButton!
    var btnright: UIButton!
    var rightBarItem: UIBarButtonItem!
    var lblBadge: UILabel = UILabel()
    
    //MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - SET NAVIGATION BAR
    func setNavigationbar(left_imagename: String,
                                        left_action: Selector?,
                                        right_imagename: String,
                                        right_action: Selector?,
                                        title: String){
        
        self.navigationController!.navigationBar.barTintColor = APP_THEME_COLOR
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 0.7
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.5
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.isTranslucent = false
        
        if !(left_imagename.count == 0 ) {
            
            btnleft = UIButton(frame: CGRect(x:0, y:0, width:35, height:35))
            btnleft.setTitleColor(UIColor.white, for: .normal)
            btnleft.contentMode = .left
            btnleft.setImage(Set_Local_Image(left_imagename), for: .normal)
            btnleft.addTarget(self, action: left_action!, for: .touchDown)
            let backBarButon: UIBarButtonItem = UIBarButtonItem(customView: btnleft)
            self.navigationItem.setLeftBarButtonItems([backBarButon], animated: false)
            
        }else{
            self.navigationItem.leftBarButtonItem = nil
        }
        
        if !(right_imagename.count == 0){
           
            btnright = UIButton(frame: CGRect(x:0, y:0, width:35, height:35))
            btnright.layer.cornerRadius = btnright.frame.width/2
            btnright.setImage(Set_Local_Image(right_imagename), for: .normal)
            btnright.addTarget(self, action: right_action!, for: .touchDown)
            rightBarItem = UIBarButtonItem(customView: btnright)
            self.navigationItem.setRightBarButton(rightBarItem, animated: false)

        } else {
            self.navigationItem.rightBarButtonItem = nil
        }
        
        if title.count > 0 {
            
            let lblValues: UILabel = UILabel()
            lblValues.text = title
            lblValues.clipsToBounds = false
            lblValues.backgroundColor = COLOR_CLEAR
            lblValues.textColor = UIColor.white
            lblValues.sizeToFit()
            lblValues.tag = 1212
            self.navigationItem.titleView = lblValues
        }
    }
    
    //MARK: - SET NAVIGATION BAR
    func setHomeNavigationbar(left_imagename: String,
                              left_action: Selector?,
                              right_imagename: String,
                              right_action: Selector?,
                              title: String){
        
        self.navigationController!.navigationBar.barTintColor = APP_THEME_COLOR
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        self.navigationController?.navigationBar.isTranslucent = false
        
        if !(left_imagename.count == 0 ) {
            
            btnleft = UIButton(frame: CGRect(x:0, y:0, width:35, height:35))
            btnleft.setTitleColor(UIColor.white, for: .normal)
            btnleft.contentMode = .left
            btnleft.setImage(Set_Local_Image(left_imagename), for: .normal)
            btnleft.addTarget(self, action: left_action!, for: .touchDown)
            let backBarButon: UIBarButtonItem = UIBarButtonItem(customView: btnleft)
            self.navigationItem.setLeftBarButtonItems([backBarButon], animated: false)
            
        } else {
            self.navigationItem.leftBarButtonItem = nil
        }
        
        if !(right_imagename.count == 0){
            btnright = UIButton(frame: CGRect(x:0, y:0, width:35, height:35))
            btnright.layer.cornerRadius = btnright.frame.width/2
            btnright.setImage(Set_Local_Image(right_imagename), for: .normal)
            btnright.addTarget(self, action: right_action!, for: .touchDown)
            rightBarItem = UIBarButtonItem(customView: btnright)
            self.navigationItem.setRightBarButton(rightBarItem, animated: false)
        } else {
            self.navigationItem.rightBarButtonItem = nil
        }
        
        if title.count > 0 {
            
            let lblValues: UILabel = UILabel()
            lblValues.text = title
            lblValues.clipsToBounds = false
            lblValues.backgroundColor = COLOR_CLEAR
            lblValues.textColor = UIColor.white
            lblValues.sizeToFit()
            lblValues.tag = 1212
            self.navigationItem.titleView = lblValues
        }
    }
    
    @objc func shareTapped() {
        
        let strMessage : String = "Checkout this amazing NewsRoll app with all your favourite news sources at one place. \nhttps://goo.gl/8tiJAt"
        let tempView : UIView = UIView.init(frame: CGRect(x:SCREENWIDTH()/2,y:SCREENHEIGHT(),width:1 ,height:1))
        tempView.backgroundColor = COLOR_CLEAR
        let vc = UIActivityViewController(activityItems: [strMessage], applicationActivities: [])
       
        if isiPad(){
             vc.popoverPresentationController?.sourceView = self.view
            vc.popoverPresentationController?.permittedArrowDirections = [.up]
        }
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func dismissController()  {
        self.dismiss(animated:true , completion: nil)
    }
    
    //MARK: - POP TO VIEW
    
    @objc func doNOthing(){
    }
}
