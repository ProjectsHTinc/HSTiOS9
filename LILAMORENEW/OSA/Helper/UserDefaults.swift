//
//  UserDefaults.swift
//  EnsyfiApp
//
//  Created by HappysanziMac on 27/09/21.
//

import Foundation
import UIKit

enum UserDefaultsKey : String
{
      case institude_Code_Key
      case user_login_type_Key
      case user_idkey
      case userTypeKey
      case userOtpListSessionkey
      case namekey
      case newsletter_statusKey
      case phone_numberKey
      case profile_picturekey
      case profileInfokey
      case address_idkey
      case email_idkey
      case deviceTokenKey
}

extension UserDefaults
{
    open func setOtpArray<T: Codable>(_ value: [T], forKey defaultName: String){
        let data = value.map { try? JSONEncoder().encode($0) }
        
        set(data, forKey: UserDefaultsKey.userOtpListSessionkey.rawValue)
    }
    
    open func getsOtpArrayData<T>(_ type: T.Type, forKey defaultName: String) -> [T] where T : Decodable {
        guard let encodedData = array(forKey: UserDefaultsKey.userOtpListSessionkey.rawValue) as? [Data] else {
            return []
        }
        
        return encodedData.map { try! JSONDecoder().decode(type, from: $0) }
    }
    
    open func setProfileInfo<T: Codable>(_ value: [T], forKey defaultName: String){
        let data = value.map { try? JSONEncoder().encode($0) }
        
        set(data, forKey: UserDefaultsKey.profileInfokey.rawValue)
    }
    
    open func getProfileInfo<T>(_ type: T.Type, forKey defaultName: String) -> [T] where T : Decodable {
        guard let encodedData = array(forKey: UserDefaultsKey.profileInfokey.rawValue) as? [Data] else {
            return []
        }
        
        return encodedData.map { try! JSONDecoder().decode(type, from: $0) }
    }
    
    func clearUserData()
    {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.userOtpListSessionkey.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.institude_Code_Key.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.user_idkey.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.userTypeKey.rawValue)
//        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.last_loginKey.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.namekey.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.newsletter_statusKey.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.phone_numberKey.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.profile_picturekey.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.address_idkey.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.email_idkey.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.deviceTokenKey.rawValue)
    }
}
