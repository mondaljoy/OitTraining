//
//  ProfileController.swift
//  InputForm
//
//  Created by Animesh Sen on 9/5/17.
//  Copyright © 2017 OPTLPTP021. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol ProfileControllerDelegate {
    func onSuccess(response: String)
    
    func onFail(response: String)
    
}

class ProfileController: NSObject, NetworkServiceManagerDelegate {
    
    let networkServiceManager = NetworkServiceManager()
    var delegate: ProfileControllerDelegate?
     let userProfileBaseClass = UserProfileBaseClass()
    
    private static var privateShared : ProfileController?
    
    var firstName: String?
    var lastName: String?
    var age: String?
    var dept: String?
    var gender: String?
    var photo: String?
    var allUserDetails = [UserProfileBaseClass]()
    
    class func shared() -> ProfileController {
        guard let uwShared = privateShared
            else
        {
            privateShared = ProfileController()
            return privateShared!
        }
        return uwShared
    }
    
    class func dispose() {
        privateShared = nil
    }
    
    private override init() {}
    
    //MARK: - API calls
    
    func handleAddUserProfileRequest()  {
        //let dic = NSMutableDictionary()
        
        
       
        userProfileBaseClass.firstName = firstName
        userProfileBaseClass.lastName = lastName
        userProfileBaseClass.dob = age
        userProfileBaseClass.gender = gender
        userProfileBaseClass.dept = dept
        userProfileBaseClass.photo = photo
        
      
        
        self.networkServiceManager.delegate = self
        
        self.networkServiceManager.createAPIRequest(apiUrl: "http://profile.getsandbox.com/addUser", requestBody: userProfileBaseClass.dictionaryRepresentation() as NSDictionary, httpMethod: "POST")
    }
    
    func handleGetUserProfileRequest()  {
        
        self.networkServiceManager.delegate = self
        
        self.networkServiceManager.createAPIRequest(apiUrl: "http://profile.getsandbox.com/users", requestBody: [:], httpMethod: "GET")
    }
    
    func onSuccess(response: AnyObject)
    {
        
        if response.isKind(of: NSArray.self)
        {
            allUserDetails.removeAll()
            
            let response = response as! [AnyObject]
            
            for item in response
            {
                if item.isKind(of: NSDictionary.self)
                {
                    let jsonObj = JSON(item)
                    let userProfile = UserProfileBaseClass(json: jsonObj)
                    allUserDetails.append(userProfile)
                }
            }
        }
        
        self.delegate?.onSuccess(response: "")
        
    }
    
    func onFail(response: String)
    {
        self.delegate?.onFail(response: response)
    }
    
}
