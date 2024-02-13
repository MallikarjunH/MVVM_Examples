//
//  APIManager.swift
//  Example1
//
//  Created by EOO61 on 02/02/24.
//

import UIKit
import Foundation

class APIManager: NSObject,URLSessionDelegate {

    
    static let shared = APIManager()
    
    private override init(){}
    
    //MARK: GET API Call
    
    public func getAPICallMethod(apiUrl:String, params:[String:Any], completion: @escaping (_ statusCode:Int, _ isSuccess:Bool, _ msgValue: String, _ errorValue:Error?, _ result:Data?) -> Void) {
        
        if !Reachability.isConnectedToNetwork(){
            completion(503, false, "Please check your internet connection and try again", nil, nil)
            return
        }
        
        /*
        let headers = [
            "content-type": "application/json",
            "cache-control": "no-cache",
            "authorization": "Basic" + " " + AppPrefsManager.sharedInstance.getAuthToken()
        ]
        */
        
        let request = NSMutableURLRequest(url: NSURL(string: apiUrl )! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 90.0)
        request.httpMethod = "GET"
       // request.allHTTPHeaderFields = headers
        
        //let session = URLSession.shared
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                
                print(error as Any)
                let httpResponse = response as? HTTPURLResponse
                let statusCode = httpResponse?.statusCode ?? 0
                if statusCode == 0 && error?._code ==  NSURLErrorTimedOut {
                    completion(statusCode, false, "Request Timed out. The server is not reachable.", error, nil)
                }else {
                    completion(statusCode, false, AlertMessages.somethingWentWrong, error, nil)
                }
                
            }else {
                
                let httpResponse = response as? HTTPURLResponse
                let statusCode = httpResponse?.statusCode ?? 0
                
                /*
                let responseDic = try? JSONSerialization.jsonObject(with: data!, options: [])
                let dicResponse = responseDic as? [String: Any] ?? [String: Any]()
                print("Response: \(dicResponse)")
        
                let isSuccess = dicResponse["IsSuccess"] as? Bool ?? false
                
                var msgValue = AlertMessages.somethingWentWrong
                if let msg = dicResponse["Messages"] as? [String] {
                    if msg.count > 0 {
                        msgValue = msg[0]
                    }
                }
                else if let msg = dicResponse["Message"] as? String {
                    msgValue = msg
                }
                */
                
                completion(statusCode, true, "", nil, data)
                
            }
        })
        dataTask.resume()
    }
    
   // public func getAPICallMethod(apiUrl:String, params:[String:Any], completion: @escaping (_ statusCode:Int, _ isSuccess:Bool, _ msgValue: String, _ errorValue:Error?, _ result:[String:Any]) -> Void) {
    /*
    public func getAPICallMethod(apiUrl:String, params:[String:Any], completion: @escaping (_ statusCode:Int, _ isSuccess:Bool, _ msgValue: String, _ errorValue:Error?, _ result:[String:Any]) -> Void) {
        
        if !Reachability.isConnectedToNetwork(){
            completion(503, false, "Please check your internet connection and try again", nil, [:])
            return
        }
        
        /*
        let headers = [
            "content-type": "application/json",
            "cache-control": "no-cache",
            "authorization": "Basic" + " " + AppPrefsManager.sharedInstance.getAuthToken()
        ]
        */
        
        let request = NSMutableURLRequest(url: NSURL(string: apiUrl )! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 90.0)
        request.httpMethod = "GET"
       // request.allHTTPHeaderFields = headers
        
        //let session = URLSession.shared
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                
                print(error as Any)
                let httpResponse = response as? HTTPURLResponse
                let statusCode = httpResponse?.statusCode ?? 0
                if statusCode == 0 && error?._code ==  NSURLErrorTimedOut {
                    completion(statusCode, false, "Request Timed out. The server is not reachable.", error, [:])
                }else {
                    completion(statusCode, false, AlertMessages.somethingWentWrong, error, [:])
                }
                
            }else {
                
                let httpResponse = response as? HTTPURLResponse
                let statusCode = httpResponse?.statusCode ?? 0
                
                let responseDic = try? JSONSerialization.jsonObject(with: data!, options: [])
                let dicResponse = responseDic as? [String: Any] ?? [String: Any]()
                print("Response: \(dicResponse)")
        
                let isSuccess = dicResponse["IsSuccess"] as? Bool ?? false
                
                var msgValue = AlertMessages.somethingWentWrong
                if let msg = dicResponse["Messages"] as? [String] {
                    if msg.count > 0 {
                        msgValue = msg[0]
                    }
                }
                else if let msg = dicResponse["Message"] as? String {
                    msgValue = msg
                }
                
                completion(statusCode, isSuccess, msgValue, nil, dicResponse)
                
            }
        })
        dataTask.resume()
    }
    */
    
    //MARK: URLSessionDelegate
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        //Trust the certificate even if not valid
        let urlCredential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
        
        completionHandler(.useCredential, urlCredential)
    }
    
}
