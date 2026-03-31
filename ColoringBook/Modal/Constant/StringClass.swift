//
//  StringClass.swift
//
//  Created by Devang Tandel on 22/03/17.
//  Copyright © 2017 Setblue. All rights reserved.
//

import Foundation
import UIKit

public extension String {

    /**
     Localize string
     */
    public  func localizedStringWithVariables(value: String, vars: CVarArg...) -> String {
        return String(format: NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: value, comment: ""), arguments: vars)
    }
    
    /// Return the float value
    public var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    /**
     Creates a substring with a given range
     */
    
    public func substringWithRange(range: Range<Int>) -> String {
        
        let start = self.index(self.startIndex, offsetBy: range.lowerBound)
        let end = self.index(self.startIndex, offsetBy: range.upperBound)
        return String(self[start...end])

    }
    
    
    
    /**
     Returns the index of the given character
     */
    public func indexOfCharacter(character: Character) -> Int {
        
        if let index = self.index(of: character) {
            return self.distance(from: self.startIndex, to: index)
        }
        return -1
    }

    
    
    /**
     Check if self is an email
     */
    public func isEmail() -> Bool {
        return String.isEmail(email: self)
    }
    
    public func isEmptyString() -> Bool {
        return String.isValid(string: self)
    }
    
    /**
     Encode the given string to Base64
     */
    public func encodeToBase64() -> String {
        return String.encodeToBase64(string: self)
    }
    
    /**
     Decode the given Base64 to string
     */
    public func decodeBase64() -> String {
        return String.decodeBase64(string: self)
    }
    
    /**
     Convert self to a NSData
     */
    public func convertToNSData() -> NSData {
        return self.data(using: String.Encoding.utf8)! as NSData
    }
    
    
    /**
     Returns a new string containing matching regular expressions replaced with the template string
     */
    public func stringByReplacingWithRegex(regexString: NSString, withString replacement: NSString) throws -> NSString {
        let regex: NSRegularExpression = try NSRegularExpression(pattern: regexString as String, options: .caseInsensitive)
        return regex.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range:NSMakeRange(0, self.count), withTemplate: "") as NSString
    }
    
    /**
     Encode self to an encoded url string
     */
    public func URLEncode() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
    
    /// Returns the last path component
    public var lastPathComponent: String {
        get {
            return (self as NSString).lastPathComponent
        }
    }
    
    /// Returns the path extension
    public var pathExtension: String {
        get {
            return (self as NSString).pathExtension
        }
    }
    
    /// Delete the last path component
    public var stringByDeletingLastPathComponent: String {
        get {
            return (self as NSString).deletingLastPathComponent
        }
    }
    
    /// Delete the path extension
    public var stringByDeletingPathExtension: String {
        get {
            return (self as NSString).deletingPathExtension
        }
    }
    
    /// Returns an array of path components
    public var pathComponents: [String] {
        get {
            return (self as NSString).pathComponents
        }
    }
    
    /**
     Appends a path component to the string
     */
    public func stringByAppendingPathComponent(path: String) -> String {
        let string = self as NSString
        
        return string.appendingPathComponent(path)
    }
    
    /**
     Appends a path extension to the string
     */
    public func stringByAppendingPathExtension(ext: String) -> String? {
        let nsSt = self as NSString
        
        return nsSt.appendingPathExtension(ext)
    }
    
    /// Converts self to a NSString
    public var NS: NSString {
        return (self as NSString)
    }
    
    /**
     Returns if self is a valid UUID or not
     */
    public func isUUID() -> Bool {
        do {
            let regex: NSRegularExpression = try NSRegularExpression(pattern: "^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", options: .caseInsensitive)
            let matches: Int = regex.numberOfMatches(in: self as String, options: .reportCompletion, range: NSMakeRange(0, self.count))
            return matches == 1
        } catch {
            return false
        }
    }
    
    /**
     Returns if self is a valid UUID for APNS (Apple Push Notification System) or not
     */
    public func isUUIDForAPNS() -> Bool {
        do {
            let regex: NSRegularExpression = try NSRegularExpression(pattern: "^[0-9a-f]{32}$", options: .caseInsensitive)
            let matches: Int = regex.numberOfMatches(in: self as String, options: .reportCompletion, range: NSMakeRange(0, self.count))
            return matches == 1
        } catch {
            return false
        }
    }
    
    /**
     Converts self to an UUID APNS valid (No "<>" or "-" or spaces)
     */
    public func convertToAPNSUUID() -> NSString {
        return self.trimmingCharacters(in: CharacterSet.init(charactersIn: "<>")).replacingOccurrences(of: " ", with: "").replacingOccurrences(of:"-", with: "") as NSString
    }
    
    /**
     Used to calculate text height for max width and font
     */
    public func heightForWidth(width: CGFloat, font: UIFont) -> CGFloat {
        var size: CGSize = CGSize.zero
        if self.count > 0 {
            let frame: CGRect = self.boundingRect(with: CGSize(width:width, height:999999), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : font], context: nil)
            size = CGSize(width: frame.size.width, height: frame.size.height + 1)
        }
        return size.height
    }
    
    public func getOnlyString() -> String{
        return self.trimmingCharacters(in: CharacterSet.init(charactersIn: " . ,*%#@!$^&()-")).replacingOccurrences(of: " ", with: "").lowercased()
    }
    
    // MARK: - Subscript functions -
    
    /**
     Returns the character at the given index
     */
    public subscript(index: Int) -> Character {
        return self[self.index(after: self.startIndex)]
    }
    
    /**
     Returns the index of the given character, -1 if not found
     */
    public subscript(character: Character) -> Int {
        return self.indexOfCharacter(character: character)
    }
    
    /**
     Returns the character at the given index as String
     */
    public subscript(index: Int) -> String {
        return String(self[index] as Character)
    }
    
    /**
     Returns the string from a given range
     */
    public subscript(range: Range<Int>) -> String {
        return substringWithRange(range: range)
    }

    
    /**
     Check if the given string is an email
     */
    public static func isEmail(email: String) -> Bool {
        let emailRegEx: String = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        let regExPredicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return regExPredicate.evaluate(with: email.lowercased())
    }
    
    /**
     Convert a string to UTF8
     
     - parameter string: String to be converted
     
     - returns: Returns the converted string
     */
    public static func convertToUTF8Entities(string: String) -> String {
        return string.replacingOccurrences(of: "%27", with: "'")
            .replacingOccurrences(of: "%e2%80%99".capitalized, with: "’")
            .replacingOccurrences(of: "%2d".capitalized, with: "-")
            .replacingOccurrences(of: "%c2%ab".capitalized, with: "«")
            .replacingOccurrences(of: "%c2%bb".capitalized, with: "»")
            .replacingOccurrences(of: "%c3%80".capitalized, with: "À")
            .replacingOccurrences(of: "%c3%82".capitalized, with: "Â")
            .replacingOccurrences(of: "%c3%84".capitalized, with: "Ä")
            .replacingOccurrences(of: "%c3%86".capitalized, with: "Æ")
            .replacingOccurrences(of: "%c3%87".capitalized, with: "Ç")
            .replacingOccurrences(of: "%c3%88".capitalized, with: "È")
            .replacingOccurrences(of: "%c3%89".capitalized, with: "É")
            .replacingOccurrences(of: "%c3%8a".capitalized, with: "Ê")
            .replacingOccurrences(of: "%c3%8b".capitalized, with: "Ë")
            .replacingOccurrences(of: "%c3%8f".capitalized, with: "Ï")
            .replacingOccurrences(of: "%c3%91".capitalized, with: "Ñ")
            .replacingOccurrences(of: "%c3%94".capitalized, with: "Ô")
            .replacingOccurrences(of: "%c3%96".capitalized, with: "Ö")
            .replacingOccurrences(of: "%c3%9b".capitalized, with: "Û")
            .replacingOccurrences(of: "%c3%9c".capitalized, with: "Ü")
            .replacingOccurrences(of: "%c3%a0".capitalized, with: "à")
            .replacingOccurrences(of: "%c3%a2".capitalized, with: "â")
            .replacingOccurrences(of: "%c3%a4".capitalized, with: "ä")
            .replacingOccurrences(of: "%c3%a6".capitalized, with: "æ")
            .replacingOccurrences(of: "%c3%a7".capitalized, with: "ç")
            .replacingOccurrences(of: "%c3%a8".capitalized, with: "è")
            .replacingOccurrences(of: "%c3%a9".capitalized, with: "é")
            .replacingOccurrences(of: "%c3%af".capitalized, with: "ï")
            .replacingOccurrences(of: "%c3%b4".capitalized, with: "ô")
            .replacingOccurrences(of: "%c3%b6".capitalized, with: "ö")
            .replacingOccurrences(of: "%c3%bb".capitalized, with: "û")
            .replacingOccurrences(of: "%c3%bc".capitalized, with: "ü")
            .replacingOccurrences(of: "%c3%bf".capitalized, with: "ÿ")
            .replacingOccurrences(of: "%20", with: " ")
    }
    
    /**
     Encode the given string to Base64
     
     - parameter string: String to encode
     
     - returns: Returns the encoded string
     */
    public static func encodeToBase64(string: String) -> String {
        let data: NSData = string.data(using: String.Encoding.utf8)! as NSData
        return data.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    }
    
    /**
     Decode the given Base64 to string
     
     - parameter string: String to decode
     
     - returns: Returns the decoded string
     */
    public static func decodeBase64(string: String) -> String {
        let data: NSData = NSData(base64Encoded: string as String, options: NSData.Base64DecodingOptions(rawValue: 0))!
        return NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)! as String
    }
    
    
    public static func isValid (string: String) -> Bool {
        return ((string.removeWhiteSpacesFromString() == "") || string.count == 0 || (string == "(null)") || (string.isEmpty)) ? false : true
    }
    
    func removeWhiteSpacesFromString() -> String {
        let trimmedString: String = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return trimmedString
    }
    
    /**
     Remove double or more duplicated spaces
     
     - returns: String without additional spaces
     */
    var removeExcessiveSpaces: String {
        let components = self.components(separatedBy: CharacterSet.whitespacesAndNewlines)
        let filtered = components.filter({!$0.isEmpty})
        return filtered.joined(separator: " ")
    }
    
    /**
     Used to create an UUID as String
     
     - returns: Returns the created UUID string
     */
    public static func generateUUID() -> String {
        let theUUID: CFUUID? = CFUUIDCreate(kCFAllocatorDefault)
        let string: CFString? = CFUUIDCreateString(kCFAllocatorDefault, theUUID)
        return string! as String
    }
    
    public var parseJSONString: AnyObject?
    {
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        if let jsonData = data
        {
            // Will return an object or nil if JSON decoding fails
            do
            {
                let message = try JSONSerialization.jsonObject(with: jsonData, options:.mutableContainers)
                if let jsonResult = message as? NSMutableArray
                {
                    return jsonResult //Will return the json array output
                }else{
                    return nil
                }
            }
            catch let error as NSError{
                print(error)
                return nil
            }
        }
        else{
            // Lossless conversion of the string was not possible
            return nil
        }
    }
    
    var isBlank: Bool {
        get {
            let trimmed =  trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            return trimmed.isEmpty
        }
    }
    
    func errorPlaceHolderString(stringColor:UIColor) -> NSAttributedString{
        
        let attributesDictionary = [NSAttributedStringKey.foregroundColor: stringColor]
        return NSAttributedString(string: self, attributes: attributesDictionary)
    
    }
    
    /**
     Check if the given string is an valid phone number
     **/
    //MARK: - IS VALID PHONE NUMBER
    var isValidPhone : Bool {
        
        let charcter  = CharacterSet(charactersIn: "+0123456789").inverted
        var filtered:String!
        let inputString:[String] = self.components(separatedBy:charcter)
        filtered = inputString.joined(separator: "")
        
        if filtered == self {
            if  self.count > 8 && self.count < 16 {
                return true
            }
        }
        return  false
    }
    
    /**
     Check if the given string is a PAN Number
     **/
    //MARK: - IS VALID PAN
    var isPan : Bool {
        let panRegEx: String = "[A-Z]{5}[0-9]{4}[A-Z]{1}"
        let regExPredicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", panRegEx)
        return regExPredicate.evaluate(with: self)
    }
    
    /**
     Check if the given string is a GST Number
     **/
    //MARK: - IS VALID GST
    var isGSTNo : Bool {
        let gstRegEx: String = "\\d{2}[A-Z]{5}\\d{4}[A-Z]{1}\\d[Z]{1}[A-Z\\d]{1}"
        let regExPredicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", gstRegEx)
        return regExPredicate.evaluate(with: self)
    }
}
