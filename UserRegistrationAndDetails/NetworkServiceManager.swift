//
//  NetworkServiceManager.swift
//  InputForm
//
//  Created by OPTLPTP021 on 9/4/17.
//  Copyright © 2017 OPTLPTP021. All rights reserved.
//

import UIKit

import SwiftyJSON

protocol NetworkServiceManagerDelegate {
    func onSuccess(response: AnyObject)
    func onFail(response: String)
}

class NetworkServiceManager: NSObject {
    private let urlSession = URLSession.shared
    var delegate: NetworkServiceManagerDelegate?
    
    override init() {
        
        
    }
    
    
    func createAPIRequest(apiUrl: String, requestBody: NSDictionary, httpMethod: String){
        var urlRequest = URLRequest(url: NSURL(string: apiUrl)! as URL)
        
        urlRequest.httpMethod = httpMethod
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if httpMethod == "POST"
        {
            urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: requestBody, options: []) //passing the request body. not required for get as we are not passing anything
        }
        
        let task = self.urlSession.dataTask(with: urlRequest as URLRequest) { (responseData, urlResponse, error) in
            if error == nil
            {
                if let jsonResponse = try? JSONSerialization.jsonObject(with: responseData!, options: .mutableContainers) as AnyObject
                {
                    //print(jsonResponse)
                    
                    if (jsonResponse.isKind(of: NSDictionary.self))
                    {
                        let status = jsonResponse["status"]
                        let error = jsonResponse["error"] as? NSDictionary
                        
                        if status != nil && status as! String == "ok"
                        {
                            DispatchQueue.main.async {
                                self.delegate?.onSuccess(response: jsonResponse)
                            }
                        }
                        if(error != nil)
                        {
                            DispatchQueue.main.async {
                                let message = error?["message"]
                                if message != nil
                                {
                                    DispatchQueue.main.async {
                                        self.delegate?.onFail(response: message as! String)
                                    }
                                }
                                
                            }
                        }
                    }
                    else if (jsonResponse.isKind(of: NSArray.self))
                    {
                        DispatchQueue.main.async {
                            self.delegate?.onSuccess(response: jsonResponse)
                        }
                    }
                    
                    
                    
                }
                    
                else
                {
                    DispatchQueue.main.async {
                        self.delegate?.onFail(response: "Data parsing Error!!")
                    }
                    
                }
            }
            else
            {
                print((error! as NSError).userInfo)
                
                DispatchQueue.main.async {
                    self.delegate?.onFail(response: "Network request Failed")
                    
                }
            }
            
        }
        
        task.resume()
    }
}

