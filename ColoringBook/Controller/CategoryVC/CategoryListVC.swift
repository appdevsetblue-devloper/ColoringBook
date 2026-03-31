//
//  CategoryListVC.swift
//  ColoringBook
//
//  Created by I MAC on 16/01/18.
//  Copyright © 2018 I MAC. All rights reserved.
//

import UIKit
import SDWebImage
import AVFoundation
import Alamofire
import Network

class CategoryListVC: UIViewController {

    //MARK: - DECLARATION METHOD

    @IBOutlet weak var colCategoryList: UICollectionView!
    
    var arrCategory = [AnyObject]()
    var strCategoryID : String = ""
    var strCategoryType : String = ""
    var strTitle : String = ""
    
    var dictMedia : [String: AnyObject] = [:]

    //MARK: - UIVIEW METHOD

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collectionViewLayout: UICollectionViewFlowLayout = (colCategoryList!.collectionViewLayout as! UICollectionViewFlowLayout)
        collectionViewLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        self.callServiceForGetCategoryList()
        
    }
    
    //MARK: - BUTTON METHOD
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - HELPER METHOD

    func displayCategoryList() {
        DispatchQueue.main.async {
            self.colCategoryList.dataSource = self
            self.colCategoryList.delegate = self
            self.colCategoryList.reloadData()
        }
    }
    
    //MARK: - SERVICE METHOD
    
    func callServiceForGetCategoryList() {
        
        var parameter: Parameters = [:]
        parameter[REQUEST.category] = self.strCategoryID
        parameter[REQUEST.category_type] = self.strCategoryType

        Service.serviceCall(url: URL(string: API_LIST.subCategory)!, method: .post, parameterList: parameter, viewVC: self) { resDict, rStatus in
            
            self.arrCategory = []
            if rStatus == 1 {
                
                let dictData = Service.getDictFromDict(dict: resDict, key: RESPONSE.data)
                
                let arrSubCategory: [AnyObject] = Service.getArrayFromDict(dict: dictData, key: RESPONSE.subcategories)
                
                self.dictMedia = Service.getDictFromDict(dict: dictData, key: RESPONSE.media)
                
                let arrMedia: [AnyObject] = Service.getArrayFromDict(dict: self.dictMedia, key: RESPONSE.media)
                
                self.arrCategory.append(contentsOf: arrSubCategory)
                self.arrCategory.append(contentsOf: arrMedia)
            }

            self.displayCategoryList()
            
        } completionFailure: { error in
            
        } completionNetworkError: {
            
        }
    }
    
}

//MARK: - UICOLLECTION VIEW METHOD

extension CategoryListVC : UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellsize:CGFloat = (isiPad() ? (((self.colCategoryList.frame.width) / 3) - 10) : ((self.colCategoryList.frame.width / 2) - 5))
        
        return CGSize(width: cellsize, height: cellsize)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrCategory.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let dictCategory: [String: AnyObject] = Service.getDictFromArray(arr: self.arrCategory, index: indexPath.row)
        
        let strSubcatID: String = Service.getStringFromDict(dict: dictCategory, key: RESPONSE.subcat_id)
        
        if strSubcatID != "" {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colCell", for: indexPath)
            let lblName : UILabel = cell.viewWithTag(1002) as! UILabel
            let imgCategory : UIImageView = cell.viewWithTag(1001) as! UIImageView
            
            let strCategory: String = Service.getStringFromDict(dict: dictCategory, key: RESPONSE.subcat_name)
            let strCategoryImage: String = Service.getStringFromDict(dict: dictCategory, key: RESPONSE.subcat_icon)

            lblName.text = strCategory
            
            if let url = URL(string: strCategoryImage) {
                imgCategory.sd_setImage(with: url, completed: nil)
            }
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colCellList", for: indexPath)
                    
            let img : UIImageView = cell.viewWithTag(1001) as! UIImageView
            let imgVideo : UIImageView = cell.viewWithTag(2001) as! UIImageView

            let strMediaURL: String = Service.getStringFromDict(dict: dictCategory, key: RESPONSE.media_file)
            
            let strMediaType: String = Service.getStringFromDict(dict: dictCategory, key: RESPONSE.media_type)
            
            if strMediaType == "3" {
                imgVideo.isHidden = false
            } else {
                imgVideo.isHidden = true
            }
            
            if let url: URL = URL(string: strMediaURL) {
                img.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                img.sd_setImage(with: url, completed: nil)
            }
                    
            return cell
            
        }

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let dictCategory: [String: AnyObject] = Service.getDictFromArray(arr: self.arrCategory, index: indexPath.row)
        
        let strSubcatID: String = Service.getStringFromDict(dict: dictCategory, key: RESPONSE.subcat_id)
        
        if strSubcatID != "" {
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: VC_CATEGORY_LIST) as! CategoryListVC
            
            let dictCategory: [String: AnyObject] = Service.getDictFromArray(arr: self.arrCategory, index: indexPath.row)
            
            let strCategoryID: String = Service.getStringFromDict(dict: dictCategory, key: RESPONSE.subcat_id)
            
            let strCategoryName: String = Service.getStringFromDict(dict: dictCategory, key: RESPONSE.subcat_name)

            nextViewController.strCategoryID = strCategoryID
            nextViewController.strCategoryType = "subcategory"
            nextViewController.strTitle = strCategoryName

            nextViewController.modalPresentationStyle = .fullScreen
            self.present(nextViewController, animated:true, completion:nil)
            
        } else {
            
            let strMediaType: String = Service.getStringFromDict(dict: dictCategory, key: RESPONSE.media_type)
            
            if strMediaType == "3" {
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: VC_PLAY_KIDS_VIDEO) as! PlayKidsVideoVC

                nextViewController.modalPresentationStyle = .fullScreen
                
                let strVideoName: String = Service.getStringFromDict(dict: dictCategory, key: RESPONSE.media_info)
                
                nextViewController.strVideoName = strVideoName
                nextViewController.strTitleName = self.strTitle
                self.present(nextViewController, animated:true, completion:nil)

            } else if strMediaType == "1" {
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: VC_LEARN) as! LearnVC
                
                nextViewController.modalPresentationStyle = .fullScreen
                
                let strMediaID: String = Service.getStringFromDict(dict: dictCategory, key: RESPONSE.media_id)
                
                let arrDrawing: [AnyObject] = Service.getArrayFromDict(dict: self.dictMedia, key: RESPONSE.drawing_media)
                
                nextViewController.arrLearnList = arrDrawing
                nextViewController.strTitleName = self.strTitle

                let index: Int = arrDrawing.index(where: {$0["media_id"] as! String == strMediaID}) ?? -1
                
                if index >= 0 && index < arrDrawing.count {
                    
                    nextViewController.index = index
                    self.present(nextViewController, animated:true, completion:nil)
                }

            } else {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: VC_PAINT) as! PaintingTestVC
                
                nextViewController.modalPresentationStyle = .fullScreen
                
                let arrFill: [AnyObject] = Service.getArrayFromDict(dict: self.dictMedia, key: RESPONSE.fill_media)
                
                nextViewController.arrPaintingImage = arrFill
                nextViewController.strTitleName = self.strTitle
                
                let strMediaID: String = Service.getStringFromDict(dict: dictCategory, key: RESPONSE.media_id)
                
                let index: Int = arrFill.index(where: {$0["media_id"] as! String == strMediaID}) ?? -1
                
                if index >= 0 && index < arrFill.count {
                    nextViewController.index = index
                    self.present(nextViewController, animated:true, completion:nil)
                }
            }
        }
    }
}
