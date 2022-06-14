//
//  Client.swift
//  FWFaceAuth
//
//  Created by Grecia Escárcega on 17/01/20.
//  Copyright © 2020 Grecia Escárcega. All rights reserved.
//

import Foundation

typealias dataHandler = (Int?, Data?) -> Void

struct Network {
  
    let baseURLComponents: URLComponents
    
    // Determines if client was enrolled
    func get(path: String, headers: [String : String], successHandler: @escaping (Int?, Data?, [AnyHashable: Any]?) -> Void){
        request(method: "GET", path: path, headers: headers, body: nil, authCredentials: nil, successHandler: successHandler)
    }
    
    // Retrieves token
    func post(path: String, headers: [String : String], body: Data, authCredentials: [String : String]?, successHandler: @escaping (Int?, Data?, [AnyHashable: Any]?) -> Void) {
        request(method: "POST", path: path, headers: headers, body: body, authCredentials: authCredentials, successHandler: successHandler)
    }
    
    // Enrolls client and authenticates
    func post(path: String, headers: [String : String], body: Data, successHandler: @escaping (Int?, Data?, [AnyHashable: Any]?) -> Void){
        request(method: "POST", path: path, headers: headers, body: body, authCredentials: nil, successHandler: successHandler)
    }

    // Generic request function
    func request(method: String, path: String, headers: [String : String], body: Data?, authCredentials: [String : String]?, successHandler: @escaping (Int?, Data?, [AnyHashable: Any]?) -> Void) {
        
        var requestURLComponents = baseURLComponents
        requestURLComponents.path = path
        
        var request = URLRequest(url: requestURLComponents.url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 240)
        
        let urlconfig = URLSessionConfiguration.default
        urlconfig.timeoutIntervalForRequest = 240
        urlconfig.timeoutIntervalForResource = 240
        request.timeoutInterval = 240

        
        var headers = headers
        
        if let credentials = authCredentials { 
            let loginString = String(format: "%@:%@", credentials["userName"]!, credentials["password"]!)
            let loginData = loginString.data(using: String.Encoding.utf8)!
            let base64LoginString = loginData.base64EncodedString()
            headers["Authorization"] = "Basic \(base64LoginString)"
        }
        
        if let body = body {
            request.httpBody = body
        }
        
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        print("**************************************************************************")
        print("Request: \(request)")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("SERVICE_ERROR: \(error!.localizedDescription)")
                if Constants.Debug.active, Constants.Debug.idRequest != nil {
                    let debugBody: [String: Any?] = [
                        "origen": Constants.Debug.origin,
                        "num_cuenta": Constants.Debug.client!,
                        "curp": Constants.Debug.curp!,
                        "json": error!.localizedDescription,
                        "endpoint": Constants.url + path,
                        "status": nil,
                        "id_parent_request": Constants.Debug.idRequest!
                    ]
                    
                    let debugData = try! JSONSerialization.data(withJSONObject: debugBody, options: [])
                    DispatchQueue.main.async { RequestDebug.post(response: debugData) }
                }
                DispatchQueue.main.async { successHandler(nil, nil,nil) }
                return
            } else {
                let httpResponse = response as! HTTPURLResponse
                switch httpResponse.statusCode {
                case 200:
                    let dataString = String(data: data!, encoding: .utf8)!
                    print("SERVICE_RESPONSE: \(dataString)")
                    
                    if Constants.Debug.active, Constants.Debug.idRequest != nil {
                        let debugBody: [String: Any?] = [
                            "origen": Constants.Debug.origin,
                            "num_cuenta": Constants.Debug.client!,
                            "curp": Constants.Debug.curp!,
                            "json": dataString,
                            "endpoint": Constants.url + path,
                            "status": httpResponse.statusCode,
                            "id_parent_request": Constants.Debug.idRequest!
                        ]
                        
                        let debugData = try! JSONSerialization.data(withJSONObject: debugBody, options: [])
                        DispatchQueue.main.async { RequestDebug.post(response: debugData) }
                    }
                    
                    
                    DispatchQueue.main.async { successHandler(httpResponse.statusCode, data,httpResponse.allHeaderFields) }
                    break
                default:
                    let string = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
                    print("SERVICE_RESPONSE_ERROR: \(httpResponse.statusCode), \(string)")
                    if Constants.Debug.active, Constants.Debug.idRequest != nil {
                        let debugBody: [String: Any?] = [
                            "origen": Constants.Debug.origin,
                            "num_cuenta": Constants.Debug.client!,
                            "curp": Constants.Debug.curp!,
                            "json": string,
                            "endpoint": Constants.url + path,
                            "status": httpResponse.statusCode,
                            "id_parent_request": Constants.Debug.idRequest!
                        ]
                        
                        let debugData = try! JSONSerialization.data(withJSONObject: debugBody, options: [])
                        DispatchQueue.main.async { RequestDebug.post(response: debugData) }
                    }
                    DispatchQueue.main.async { successHandler(httpResponse.statusCode, nil,nil) }
                    break
                }
            }
        }
        task.resume()
        return
    }
}
