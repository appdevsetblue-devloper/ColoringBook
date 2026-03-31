//
//  DefaulValues.swift
//
//  Created by Devang Tandel on 22/03/17.
//  Copyright © 2017 Setblue. All rights reserved.
//

import Foundation

public func setStringValueToUserDefaults(strValue: String, ForKey strKey: String) {
    
    let defaults = UserDefaults.standard
    defaults.setValue("\(strValue)", forKey: strKey)
    defaults.synchronize()
}

public func getStringValueFromUserDefaults_ForKey(strKey: String) -> String {
    
    let defaults = UserDefaults.standard
    var s: String? = nil
    s = defaults.string(forKey: strKey)
    return s!
}

public func setIntegerValueToUserDefaults(intValue: Int, ForKey intKey: String) {
    
    let defaults = UserDefaults.standard
    defaults.set(intValue, forKey: intKey)
    defaults.synchronize()
}

public func getIntegerValueFromUserDefaults_ForKey(intKey: String) -> Int {
    
    var i: Int = 0
    let defaults = UserDefaults.standard
    i = Int(defaults.integer(forKey: intKey))
    
    return i
}

public func setBooleanValueToUserDefaults(booleanValue: Bool, ForKey booleanKey: String) {
    
    let defaults = UserDefaults.standard
    defaults.set(booleanValue, forKey: booleanKey)
    defaults.synchronize()
    
}

public func getBooleanValueFromUserDefaults_ForKey(booleanKey: String) -> Bool {
    
    let defaults = UserDefaults.standard
    
    var b: Bool = false
    b = defaults.bool(forKey: booleanKey)
    
    return b
}


public func setObjectValueToUserDefaults(idValue: AnyObject, ForKey strKey: String) {
    let defaults = UserDefaults.standard
    defaults.set(idValue, forKey: strKey)
    defaults.synchronize()
    
}

public func getObjectValueFromUserDefaults_ForKey(strKey: String) -> AnyObject {
    
    let defaults = UserDefaults.standard
    var obj: AnyObject? = nil
    obj = defaults.object(forKey: strKey) as AnyObject?
    
    return obj!
}

public func setCustomObjToUserDefaults(CustomeObj: AnyObject, ForKey CustomeObjKey: String) {
    
    let defaults = UserDefaults.standard
    let encodedData = NSKeyedArchiver.archivedData(withRootObject: CustomeObj)
    defaults.set(encodedData, forKey: CustomeObjKey)
    defaults.synchronize()
    
}

public func getCustomObjFromUserDefaults_ForKey(CustomeObjKey: String) -> AnyObject {
    
    let defaults = UserDefaults.standard
    
    let decoded  = defaults.object(forKey: CustomeObjKey) as! NSData
    let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data)! as AnyObject
    return decodedTeams
}

public func removeObjectForKey(objectKey: String) {
    
    let defaults = UserDefaults.standard
    defaults.removeObject(forKey: objectKey)
    defaults.setValue(nil, forKey: objectKey)
    defaults.synchronize()
}

public func removeAllKeyFromDefault(){
    UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    
    if let bundle = Bundle.main.bundleIdentifier {
        UserDefaults.standard.removePersistentDomain(forName: bundle)
    }
    UserDefaults.standard.synchronize()
}

public func iskeyAlreadyExist(key: String) -> Bool {
    return UserDefaults.standard.object(forKey: key) != nil
    
}
