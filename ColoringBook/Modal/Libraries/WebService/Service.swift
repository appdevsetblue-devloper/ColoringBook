//
//  Service.swift
//  UKCoin
//
//  Created by COMPUCARE SYSTEMS on 28/05/20.
//  Copyright © 2020 COMPUCARE SYSTEMS. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import Network
import SwiftUI

class Service: NSObject {
    
    static func getStoryBoard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    static func getMessageFromDict(dict: [String: AnyObject], key: String) -> String {
        
        var strValue: String = ""
        
        if ((dict[key] as? [String]) != nil) {
            let arrMessage: [String] = dict[key] as! [String]
            if arrMessage.count > 0 {
                strValue = String(format: "%@", arrMessage.first!)
            }
            
        } else if ((dict[key] as? Int) != nil) {
            strValue = String(format: "%d", dict[key] as! Int)
            
        } else if ((dict[key] as? Double) != nil) {
            strValue = String(format: "%g", dict[key] as! Double)
            
        } else if ((dict[key] as? String) != nil) {
            strValue = dict[key] as! String
        }
        
        return strValue
    }
    
    //MARK:- Get String From Dict and Array With Validation for Nill Method
    
    static func getDictFromArray(arr: [AnyObject], index: Int) -> [String: AnyObject] {
        
        var dict: [String: AnyObject] = [:]
        
        if arr.count > index && index >= 0 {
            if ((arr[index] as? [String: AnyObject]) != nil) {
                dict = arr[index] as? [String: AnyObject] ?? [:]
            }
        }
        return dict
    }
    
    static func getDictFromDict(dict: [String: AnyObject], key: String) -> [String: AnyObject] {
        
        var newDict: [String: AnyObject] = [:]
        
        if ((dict[key] as? [String: AnyObject]) != nil) {
            newDict = dict[key] as! [String: AnyObject]
        }
        return newDict
    }
    
    static func getArrayFromDict(dict: [String: AnyObject], key: String) -> [AnyObject] {
        
        var arr: [AnyObject] = []
        
        if ((dict[key] as? [AnyObject]) != nil) {
            arr = dict[key] as! [AnyObject]
        }
        return arr
    }
    
    static func getBoolFromDict(dict: [String: AnyObject], key: String) -> Bool {
        
        var isBool: Bool = false
        
        if ((dict[key] as? Bool) != nil) {
            isBool = (dict[key] as! Bool)
        }
        return isBool
    }
    
    static func getStringFromDict(dict: [String: AnyObject], key: String) -> String {
        
        var strValue: String = ""
        if ((dict[key] as? Int) != nil) {
            strValue = String(format: "%d", dict[key] as! Int)
            
        } else if ((dict[key] as? Double) != nil) {
            strValue = String(format: "%g", dict[key] as! Double)
            
        } else if ((dict[key] as? String) != nil) {
            strValue = dict[key] as! String
        }
        
        return strValue
    }
    
    static func getIntFromDict(dict: [String: AnyObject], key: String) -> Int {
        
        var value: Int = 0
        if ((dict[key] as? Int) != nil) {
            value = dict[key] as! Int
        }
        
        return value
    }
    
    static func getStringFromArray(arr: [String], index: Int) -> String {
        
        var strValue: String = ""
        if arr.count > 0 && index < arr.count {
            strValue = arr[index]
        }
        
        return strValue
    }
    
    //MARK:- Get OtherData Method
    
    static func showLoader() {
        
        DispatchQueue.main.async {
            SVProgressHUD.show()
            SVProgressHUD.setDefaultMaskType(.custom)
        }
    }
    
    static func hideLoader() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
    
    static func DisplayValidationAlert(strMessage: String, viewVC: UIViewController) {
        
        DispatchQueue.main.async {
            
            let alert: UIAlertController = UIAlertController(title: APPNAME, message: strMessage, preferredStyle: .alert)

            let strTitle: String = strMessage
            let action: UIAlertAction = UIAlertAction(title: strTitle, style: .default) { (action) in
                
            }
            alert.addAction(action)
            
            viewVC.present(alert, animated: true, completion: nil)
        }
        
    }
    
    static func DisplayAlertWith_TitleandAction_WithVC(strAlertTitle: String, strMessage: String, arrActionTitle: [String], viewVC: UIViewController, completionBlock: @escaping (_ strValue: String, _ index: Int) -> ()) {

        DispatchQueue.main.async {
            let alert: UIAlertController = UIAlertController(title: strAlertTitle, message: strMessage, preferredStyle: .alert)

            for i in 0...arrActionTitle.count - 1 {
                let strTitle: String = arrActionTitle[i]
                let action: UIAlertAction = UIAlertAction(title: strTitle, style: .default) { (action) in
                    completionBlock(strTitle, i)
                }
                alert.addAction(action)
            }
            viewVC.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK:- Service Method
    
    static func serviceCall_DownloadYoutubeVideo(url: URL, viewVC: UIViewController, completionSuccess: @escaping (_ downloadURL: URL?) -> (), completionFailure: @escaping (_ error: Error) -> (), completionNetworkError: @escaping () -> ()) {
        
        AF.download(url).downloadProgress { progress in
            print(progress.fractionCompleted)
            
        }.responseURL { url in
            
            switch url.result {
            case .success(let url):
                completionSuccess(url)
                break
                
            case .failure(let error):
                completionFailure(error)
            }
        }
        
    }
    
    static func serviceCall(url: URL, method: HTTPMethod, parameterList: Parameters, viewVC: UIViewController, completionSuccess: @escaping (_ resDict: [String: AnyObject], _ rStatus: Int) -> (), completionFailure: @escaping (_ error: Error) -> (), completionNetworkError: @escaping () -> ()) {
        
        if (Alamofire.NetworkReachabilityManager()?.isReachable)! {
            
            DispatchQueue.main.async {
                SVProgressHUD.show()
                SVProgressHUD.setDefaultMaskType(.custom)
            }
            
            AF.request(url, method: method , parameters: parameterList)
                .responseJSON { response in
                    
                    switch response.result {
                    case .success(let val):
                        
                        if val as? [String: AnyObject] != nil {
                            DispatchQueue.main.async {
                                let resDict: [String: AnyObject] = val as! [String : AnyObject]
                                
                                let status: Int = Service.getIntFromDict(dict: resDict, key: RESPONSE.status)
                                
                                SVProgressHUD.dismiss()
                                
                                completionSuccess(resDict , status)
                            }
                        } else {
                            completionSuccess([:] , 0)
                        }
                        break
                        
                    case .failure(let error):
                        
                        DispatchQueue.main.async {
                            completionFailure(error)
                            SVProgressHUD.dismiss()
                        }
                    }
                }
        } else {
            
            Service.DisplayValidationAlert(strMessage: "Internet connection problem", viewVC: viewVC)
            completionNetworkError()
        }
    }
}
