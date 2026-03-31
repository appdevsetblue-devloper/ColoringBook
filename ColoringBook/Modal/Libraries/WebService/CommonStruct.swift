//
//  CommonStruct.swift
//  UKCoin
//
//  Created by COMPUCARE SYSTEMS on 28/05/20.
//  Copyright © 2020 COMPUCARE SYSTEMS. All rights reserved.
//

import UIKit

let APPNAME : String = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? ""

let MOBILE_TYPE : String = "2"
let FCM : String = UIDevice.current.identifierForVendor!.uuidString

let IPHONE_5S: Bool = UIScreen.main.bounds.size.width == 320
let IPHONE_6S: Bool = UIScreen.main.bounds.size.width == 375

let APPDELEGATE = UIApplication.shared.delegate as! AppDelegate

struct DATA_TYPE {
    static let STRING: String = "STRING"
    static let DICTIONARY: String = "DICTIONARY"
}

struct REQUEST {
    static let category: String = "category"
    static let category_type: String = "category_type"

}


//MARK: -  RESPONSE

struct RESPONSE {
    static let cat_id: String = "cat_id"
    static let cat_name: String = "cat_name"
    static let cat_icon: String = "cat_icon"
    static let subcat_icon: String = "subcat_icon"

    static let status: String = "status"
    static let data: String = "data"
    static let media_info: String = "media_info"

    static let subcategories: String = "subcategories"
    static let media: String = "media"
    
    static let subcat_id: String = "subcat_id"
    static let subcat_name: String = "subcat_name"
    
    static let media_id: String = "media_id"
    static let parent_id: String = "parent_id"
    
    static let media_file: String = "media_file"
    static let media_type: String = "media_type"
    
    static let drawing_media: String = "drawing_media"
    static let fill_media: String = "fill_media"
    static let video_media: String = "video_media"


}

struct API_LIST {
    
    static let localPath: String = "https://eray.in/colourbook/api/"
    static let mainPath: String = API_LIST.localPath
    static let categoryList: String = API_LIST.localPath + "category/list"
    static let subCategory: String = API_LIST.localPath + "subcategory/list"

}

struct IMAGE_LIST {
    static let check: String = "check"
}
