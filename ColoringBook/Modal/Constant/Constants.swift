//
//  Constants.swift
//
//  Created by Devang Tandel on 22/03/17.
//  Copyright © 2017 Setblue. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import SystemConfiguration
import FCAlertView

//MARK:- Application related variables

let APP_DELEGATE = UIApplication.shared.delegate as! AppDelegate
public let APP_NAME: String = Bundle.main.infoDictionary!["CFBundleName"] as! String
public let APP_VERSION: String = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
public let KEYCHAIN_KEY = ""

public let APP_STOREID: String = "1338155056"
public let AD_TIME_INTERVAL : Int = 20

public let GOOGLE_AD_ID = "ca-app-pub-3833054414357969~3195095473"
public let GOOGLE_AD_INTERSTITAL = "ca-app-pub-3833054414357969/8498914113"
public let GOOGLE_AD_BANNER = "ca-app-pub-3833054414357969/2045665337"

/*
public let GOOGLE_AD_ID = ""
public let GOOGLE_AD_INTERSTITAL = ""
public let GOOGLE_AD_BANNER = ""
*/


//MARK: - IS SIMULATOR
public let isSimulator: Bool = {
    var isSim = false
    #if arch(i386) || arch(x86_64)
        isSim = true
    #endif
    return isSim
}()


//MARK: - STORYBORAD NAME
let SB_MAIN  = "Main"

//MARK: - NAVIGATIONBAR
let NAV_MENU = "navMenu"
let NAV_HOME = "navHome"
let NAV_COLLECTION = "navCollection"
let NAV_SAVE = "navSave"
let NAV_BAG = "navBag"
let NAV_ACCOUNT = "navAccount"

//MARK: -  VIEW CONTROLLER  ID

let VC_HOME = "idHomeVC"
let VC_CATEGORY = "idCategoryVC"
let VC_CATEGORY_LIST = "idCategoryListVC"
let VC_PAINT = "idPaintingTestVC"
let VC_LEARN = "LearnVC"
let VC_PLAY_KIDS_VIDEO = "PlayKidsVideoVC"

//NOTIFICATION CONSTANT


//MARK: - IMAGES
let ICON_MENU = "icon_Menu"
let ICON_BACK = "icon_Back"


//MARK:- Category Array



//MARK: -  GET VC FOR NAVIGATION
public func getStoryboard(_ storyboardName: String) -> UIStoryboard {
    return UIStoryboard(name: "\(storyboardName)", bundle: nil)
}

public func loadVC(_ strStoryboardId: String, strVCId: String) -> UIViewController {
    let vc = getStoryboard(strStoryboardId).instantiateViewController(withIdentifier: strVCId)
    return vc
}

extension UIDevice {
    var hasNotch: Bool {
        if #available(iOS 11.0, *) {
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            return keyWindow?.safeAreaInsets.bottom ?? 0 > 0
        }
        return false
    }

}
//MARK: - iOS version checking Functions
public func IOS_VERSION() -> String {
    return UIDevice.current.systemVersion
}

public func IOS_EQUAL_TO(_ xx: Float) -> Bool {
    return IOS_VERSION().compare(String(xx), options: .numeric) == .orderedSame
}

//MARK : - UD KEY
let UD_KEY_UDID = "Device_Unique_Key"
let UD_KEY_ACCESSTOKEN = "Access TokenKey"
let UD_KEY_APPUSER = "App User"
let UD_KEY_CURRENCYSYMBOL = "curremcy symbol"

//MARK: - GET FULL SCREEN SIZE
public func fixedScreenSize() -> CGSize {
    
    let screenSize = UIScreen.main.bounds.size
    if NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1 && UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation) {
        return CGSize(width: screenSize.width, height: screenSize.height)
    }
    return screenSize
}

public func SCREENWIDTH() -> CGFloat{
    return fixedScreenSize().width
}

public func SCREENHEIGHT() -> CGFloat{
    return fixedScreenSize().height
}

//MARK: - NETWORK INDICATOR

public func ShowNetworkIndicator(_ xx :Bool){
    runOnMainThread {
         UIApplication.shared.isNetworkActivityIndicatorVisible = xx
    }
}


/**
 Get image from image name
 */
//MARK: - Get image from image name
public func Set_Local_Image(_ imageName :String) -> UIImage{
    return UIImage(named:imageName)!
}


/**
 Color functions
 */
//MARK: - Color functions
public func COLOR_CUSTOM(_ Red: Float, _ Green: Float , _ Blue: Float, _ Alpha: Float) -> UIColor {
    return  UIColor (red:  CGFloat(Red)/255.0, green: CGFloat(Green)/255.0, blue: CGFloat(Blue)/255.0, alpha: CGFloat(Alpha))
}

public func UIColorFromRGB(_ rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}


public func randomColorWithOpacity(opacity: CGFloat) -> UIColor {
    let r: UInt32 = arc4random_uniform(255)
    let g: UInt32 = arc4random_uniform(255)
    let b: UInt32 = arc4random_uniform(255)
    
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: opacity)
}

public func APPBLUECOLORWITHRANDOMOPECITY() -> UIColor {
    return UIColor(red: 0 / 255.0, green: 180 / 255.0, blue: 180 / 255.0, alpha: CGFloat(drand48()) )
}

/**
 Log trace
 */
//MARK: - Log trace

public func DLog<T>(_ message:T,  file: String = #file, function: String = #function, lineNumber: Int = #line ) {
    #if DEBUG
        if let text = message as? String {
            print("\((file as NSString).lastPathComponent) -> \(function) line: \(lineNumber): \(text)")
        }
    #endif
}


/**
 Check string is available or not
 */
//MARK: - Check string is available or not
public func isLike(_ source: String , compare: String) ->Bool{
    var exists = true
    ((source).lowercased().range(of: (compare as String))  != nil) ? (exists = true) : (exists = false)
    return exists
}


/**
 Calculate heght of label
 */
//MARK: - Calculate heght of label
public func calculatedHeight(_ Label: UILabel) -> CGFloat {
    let text: String = Label.text!
    return text.heightForWidth(width: Label.frame.size.width, font: Label.font)
}


/**
 Get current time stamp
 */
//MARK: - Get current time stamp
public var CurrentTimeStamp: String {
    return "\(Date().timeIntervalSince1970 * 1000)"
}

struct Constants {
    
    enum CurrentDevice : Int {
        case phone // iPhone and iPod touch style UI
        case pad // iPad style UI
    }
    
    struct MixpanelConstants {
        static let activeScreen = "Active Screen";
    }
    
    struct CrashlyticsConstants {
        static let userType = "User Type";
    }
    
}


//MARK: NULL to NIL
//Convert Null Value to nil
public func NULL_TO_NIL(_ value : AnyObject?) -> AnyObject? {
    if value is NSNull || value == nil {
        return "" as AnyObject?
    } else {
        return value
    }
}

//MARK:- RANDOM STRING GENERATOR
//Generate random string with specified length
func randomString(length: Int) -> String {
    
    let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let len = UInt32(letters.length)
    
    var randomString = ""
    
    for _ in 0 ..< length {
        let rand = arc4random_uniform(len)
        var nextChar = letters.character(at: Int(rand))
        randomString += NSString(characters: &nextChar, length: 1) as String
    }
    
    return randomString
}

//MARK : - CHECK INTERNET CONNECTION
func isConnectedToNetwork() -> Bool {
    
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    
    var flags = SCNetworkReachabilityFlags()
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
        return false
    }
    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    return (isReachable && !needsConnection)
}

//MARK: - APP GENERALS
public let APP_THEME_COLOR =  COLOR_CUSTOM(1, 171, 187, 1.0)
public let COLOR_CLEAR = UIColor.clear
public let COLOR_WHITE = UIColor.white
public let COLOR_BLACK = UIColor.red
public let COLOR_RED = UIColor.red


//MARK: - ISIPAD
func isiPad()->Bool{
    return UIDevice.current.userInterfaceIdiom == .pad ? true :  false
}

func isIphoneX()->Bool{
    
    var modelIdentifier = ""
    if isSimulator {
        modelIdentifier = ProcessInfo.processInfo.environment["SIMULATOR_MODEL_IDENTIFIER"] ?? ""
    } else {
        var size = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0, count: size)
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        modelIdentifier = String(cString: machine)
    }
    
    return modelIdentifier == "iPhone10,3" || modelIdentifier == "iPhone10,6"
}
var hasTopNotch: Bool {
    if #available(iOS 11.0, tvOS 11.0, *) {
        return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
    }
    return false
}
//MARK: - GET UDID
func getUDID() -> String {
    
    var UDID = ""
    if iskeyAlreadyExist(key: UD_KEY_UDID){
        UDID = getStringValueFromUserDefaults_ForKey(strKey: UD_KEY_UDID)
    }else{
        let theUUID : CFUUID = CFUUIDCreate(nil);
        let string : CFString = CFUUIDCreateString(nil, theUUID);
        UDID =  string as String
        setStringValueToUserDefaults(strValue: UDID, ForKey: UD_KEY_UDID)
    }
    return UDID
}

//MARK: - GET UDID
func getAccessToken() -> String {
    
    var accessToken = ""
    if iskeyAlreadyExist(key: UD_KEY_ACCESSTOKEN){
        accessToken = getStringValueFromUserDefaults_ForKey(strKey: UD_KEY_ACCESSTOKEN)
    }
    return accessToken
}

//MARK: - GET UNIQUE ID FOR DEVICE
func getUniqueID() -> String{
    
    let keychain = KeychainSwift()
    if let receivedData = keychain.get(KEYCHAIN_KEY) {
        return receivedData
    }else{
        let strId: String = CFUUIDCreateString(nil, CFUUIDCreate(nil)) as String
        keychain.set(strId, forKey: KEYCHAIN_KEY)
        return strId
    }
}

//MARK: - FONT FUNCTION
public func printFonts(){
    
    // Get all fonts families
    for family in UIFont.familyNames {
        NSLog("\(family)")
        
        // Show all fonts for any given family
        for name in UIFont.fontNames(forFamilyName: family) {
            NSLog("   \(name)")
        }
    }
}
public func FONT_HEADER_REGULAR(_ size: CGFloat) -> UIFont {
    return UIFont(name: "TrebuchetMS-Bold", size: size)!
}
public func FONT_REGULAR(_ size: CGFloat) -> UIFont {
    return UIFont(name: "TrebuchetMS", size: size)!
}

//MARK: - THREAD FUNCTION
/**
 Runs a block On Main Thread
 */
public func runOnMainThread(block: @escaping () -> ()) {
    
    DispatchQueue.main.async { 
        block()
    }
}

/**
 Runs a block in background
 */
public func runInBackground(block: @escaping () -> ()) {
    
    DispatchQueue.global(qos: .background).async {
        block()
    }
}

public func runAfterTime(time: Double ,block : @escaping() -> ()){
    
    DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            block()
    }
}

public func hideKeyboard(){
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
}

//MARK: - SHOW ALERT
func showAlertWithTitleWithMessage(message:String)  {
    
    let alert : FCAlertView = FCAlertView()
    alert.avoidCustomImageTint =  true
    alert.detachButtons = true
    alert.colorScheme = APP_THEME_COLOR
    alert.showAlert(in: APP_DELEGATE.window, withTitle: APP_NAME, withSubtitle: message, withCustomImage: nil   , withDoneButtonTitle: "Ok", andButtons: nil)
}

func showNoInternetAlert()  {
    
    let alert : FCAlertView = FCAlertView()
    alert.detachButtons = true
    alert.titleColor = APP_THEME_COLOR
    alert.showAlert(in: APP_DELEGATE.window, withTitle: APP_NAME, withSubtitle: "No internet connection available. Please try again!", withCustomImage: nil , withDoneButtonTitle: "Dismiss", andButtons: nil)
}

func saveImageDocumentDirectoryWithDate(tempImage:UIImage, block : @escaping (_ url: URL?) -> Void ){
    
    let documentsDirectoryURL = try! FileManager().url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    
    let random : String =  randomString(length: 5)
    let fileURL = documentsDirectoryURL.appendingPathComponent(String(format:"CPImage%@.png",random))
    do {
        try UIImagePNGRepresentation(tempImage)?.write(to: fileURL)
    } catch {
        block(nil)
    }
    block(fileURL)
}
func showNoInternetMAlert()  {
    
    let alert : FCAlertView = FCAlertView()
    alert.avoidCustomImageTint =  true
    alert.titleColor = APP_THEME_COLOR
    alert.firstButtonTitleColor = UIColor.red
    alert.firstButtonTitleColor = UIColor.white
    alert.showAlert(in: APP_DELEGATE.window, withTitle: APP_NAME, withSubtitle: "No internet connection available. Please try again!", withCustomImage: nil , withDoneButtonTitle: "Dismiss", andButtons: nil)
}

func timeAgoSinceDate(_ date:Date, numericDates:Bool = false) -> String {
    let calendar = NSCalendar.current
    let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
    let now = Date()
    let earliest = now < date ? now : date
    let latest = (earliest == now) ? date : now
    let components = calendar.dateComponents(unitFlags, from: earliest,  to: latest)
    
    if (components.year! >= 2) {
        return "\(components.year!) years ago"
    } else if (components.year! >= 1){
        if (numericDates){
            return "1 year ago"
        } else {
            return "Last year"
        }
    } else if (components.month! >= 2) {
        return "\(components.month!) months ago"
    } else if (components.month! >= 1){
        if (numericDates){
            return "1 month ago"
        } else {
            return "Last month"
        }
    } else if (components.weekOfYear! >= 2) {
        return "\(components.weekOfYear!) weeks ago"
    } else if (components.weekOfYear! >= 1){
        if (numericDates){
            return "1 week ago"
        } else {
            return "Last week"
        }
    } else if (components.day! >= 2) {
        return "\(components.day!) days ago"
    } else if (components.day! >= 1){
        if (numericDates){
            return "1 day ago"
        } else {
            return "Yesterday"
        }
    } else if (components.hour! >= 2) {
        return "\(components.hour!) hours ago"
    } else if (components.hour! >= 1){
        if (numericDates){
            return "1 hour ago"
        } else {
            return "An hour ago"
        }
    } else if (components.minute! >= 2) {
        return "\(components.minute!) minutes ago"
    } else if (components.minute! >= 1){
        if (numericDates){
            return "1 minute ago"
        } else {
            return "A minute ago"
        }
    } else if (components.second! >= 3) {
        return "\(components.second!) seconds ago"
    } else {
        return "Just now"
    }
}
/*
internal let UILayoutPriorityNotificationPadding: Float = 999

public struct Notification {
    static let titleFont = UIFont.boldSystemFont(ofSize: 14)
    static let subtitleFont = UIFont.systemFont(ofSize: 13)
    
    static let animationDuration: TimeInterval = 0.3 // second(s)
    public static let exhibitionDuration: TimeInterval = 5.0 // second(s)
    
}


public struct NotificationLayout {
    static let height: CGFloat = 64.0
    static var width: CGFloat { return UIScreen.main.bounds.size.width }
    
    static var labelTitleHeight: CGFloat = 26
    static var labelMessageHeight: CGFloat = 35
    static var dragViewHeight: CGFloat = 3
    
    public static let iconSize = CGSize(width: 22, height: 22)
    
    static let imageBorder: CGFloat = 15
    static let textBorder: CGFloat = 10
}

*/

