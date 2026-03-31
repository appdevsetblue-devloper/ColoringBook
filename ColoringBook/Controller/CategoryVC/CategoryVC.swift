//  CategoryVC.swift
//  ColoringBook
//
//  Created by I MAC on 16/01/18.
//  Copyright © 2018 I MAC. All rights reserved.
//

import UIKit
import Alamofire

class CategoryVC: BaseVC {
    
    //MARK: - DECLARATION METHOD
    
    @IBOutlet weak var colCategory: UICollectionView!
//    var arrImgCategory : [UIImage] = [UIImage(named:"Alphabets")!,
//                                      #imageLiteral(resourceName: "cat_animal"),
//                                      #imageLiteral(resourceName: "cat_boys"),
//                                      #imageLiteral(resourceName: "cat_cartoon"),
//                                      #imageLiteral(resourceName: "cat_christmas"),
//                                      #imageLiteral(resourceName: "cat_girls"),
//                                      UIImage(named:"numbersCategory")!,
//                                      UIImage(named:"shapesCategory")!,
//                                      #imageLiteral(resourceName: "cat_vehical"),
//                                      UIImage(named:"KidsSong")!]
    
    var arrCategory : [AnyObject] = []

    //MARK: - UIVIEW METHOD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collectionViewLayout: UICollectionViewFlowLayout = (colCategory!.collectionViewLayout as! UICollectionViewFlowLayout)
        collectionViewLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        self.callServiceForGetCategory()
    }
    
    //MARK: - BUTTON METHOD

    @IBAction func btnBackTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - HELPER METHOD

    func displayCategoryList() {
        DispatchQueue.main.async {
            self.colCategory.dataSource = self
            self.colCategory.delegate = self
            self.colCategory.reloadData()
        }
    }
    
    //MARK: - SERVICE METHOD
    
    func callServiceForGetCategory() {
        
        Service.serviceCall(url: URL(string: API_LIST.categoryList)!, method: .post, parameterList: [:], viewVC: self) { resDict, rStatus in
            
            self.arrCategory = []
            if rStatus == 1 {
                self.arrCategory = Service.getArrayFromDict(dict: resDict, key: RESPONSE.data)
            }
            self.displayCategoryList()
            
        } completionFailure: { error in
            
        } completionNetworkError: {
            
        }
    }

}

//MARK: - UICOLLECTION VIEW METHOD

extension CategoryVC : UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellsize:CGFloat = (isiPad() ? (((colCategory.frame.width) / 3) - 10) : ((colCategory.frame.width / 2) - 5))
        
        return CGSize(width: cellsize, height: cellsize)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.arrCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colCell", for: indexPath)
        let lblName : UILabel = cell.viewWithTag(1002) as! UILabel
        let imgCategory : UIImageView = cell.viewWithTag(1001) as! UIImageView
        
        let dictCategory: [String: AnyObject] = Service.getDictFromArray(arr: self.arrCategory, index: indexPath.row)
        
        let strCategory: String = Service.getStringFromDict(dict: dictCategory, key: RESPONSE.cat_name)
        let strCategoryImage: String = Service.getStringFromDict(dict: dictCategory, key: RESPONSE.cat_icon)

        lblName.text = strCategory
        
        if let url = URL(string: strCategoryImage) {
            imgCategory.sd_setImage(with: url, completed: nil)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: VC_CATEGORY_LIST) as! CategoryListVC
        
        let dictCategory: [String: AnyObject] = Service.getDictFromArray(arr: self.arrCategory, index: indexPath.row)
        
        let strCategoryID: String = Service.getStringFromDict(dict: dictCategory, key: RESPONSE.cat_id)
        let strCategoryName: String = Service.getStringFromDict(dict: dictCategory, key: RESPONSE.cat_name)

        nextViewController.strCategoryID = strCategoryID
        nextViewController.strCategoryType = "category"
        nextViewController.strTitle = strCategoryName

        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated:true, completion:nil)
    }
    
}
