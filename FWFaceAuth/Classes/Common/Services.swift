//
//  Network.swift
//  FWFaceAuth
//
//  Created by Grecia Escárcega on 12/12/19.
//  Copyright © 2019 Grecia Escárcega. All rights reserved.
//

import UIKit

struct Services {
    
    static let shared = Services()
    
    let jsonDecoder = JSONDecoder()
    let network = Network(baseURLComponents: URLComponents(string: Constants.url)!)
    
    func token(_ completion: @escaping (String?) -> Void) {
        
        let bodyDictionary = [
            "grant_type":"client_credentials"
        ]
        
        let body = Util.dictionaryToData(dictionary: bodyDictionary)!
        
        let headers = [
            "Content-Type":"application/x-www-form-urlencoded"
        ]
        
        let credentials = [
            "userName": Constants.usr,
            "password": Constants.pss
        ]
        
        // MARK: -- debug
        if Constants.Debug.active {
            let requestBodyDict: [String: Any?] = [
                "origen": Constants.Debug.origin,
                "num_cuenta": Constants.Debug.client,
                "curp": Constants.Debug.curp,
                "json": bodyDictionary,
                "endpoint": "https://api.dev.profuturo.mx/oauth2/token"
            ]
            
            let requestBody = try! JSONSerialization.data(withJSONObject: requestBodyDict, options: [])
            
            RequestDebug.post(request: requestBody) { (result) in
                if result {
                    self.network.post(path: "/oauth2/token", headers: headers, body: body, authCredentials: credentials){ (code, data, headers) in
                        if code == 200 {
                            guard let jsonData = data, let oauth = try? self.jsonDecoder.decode(ServiceModel.OAuth.self, from: jsonData) else { DispatchQueue.main.async { completion(nil) }
                                return
                            }
                            DispatchQueue.main.async { completion(oauth.accessToken) }
                        } else {
                            DispatchQueue.main.async { completion(nil) }
                        }
                    }
                }
            }
        } else {
            self.network.post(path: "/oauth2/token", headers: headers, body: body, authCredentials: credentials){ (code, data, headers) in
                if code == 200 {
                    guard let jsonData = data, let oauth = try? self.jsonDecoder.decode(ServiceModel.OAuth.self, from: jsonData) else {
                        DispatchQueue.main.async { completion(nil) }
                        return
                    }
                    DispatchQueue.main.async { completion(oauth.accessToken) }
                } else {
                    DispatchQueue.main.async { completion(nil) }
                }
            }
        }
        return
        
    }
    
    func getClient(token: String, curp: String, _ completion: @escaping (Bool?) -> Void) {
        
        let path = "/grupo/1/autenticacion-universal/personas/\(curp)/factores/facial"
        
        let headers = [
            "Authorization":"Bearer \(token)",
            "Content-Type":"application/x-www-form-urlencoded"
        ]
        
        // MARK: -- debug
        if Constants.Debug.active {
            let requestBodyDict: [String: Any?] = [
                "origen": Constants.Debug.origin,
                "num_cuenta": Constants.Debug.client,
                "curp": Constants.Debug.curp,
                "json": [:],
                "endpoint": Constants.url + path
            ]
            
            let requestBody = try! JSONSerialization.data(withJSONObject: requestBodyDict, options: [])
            
            RequestDebug.post(request: requestBody) { (result) in
                if result {
                    DispatchQueue.main.async {
                        self.network.get(path: path, headers: headers) { (code, data, headers) in
                            if code == 200 {
                                DispatchQueue.main.async { completion(true) }
                            } else if code == 404 {
                                DispatchQueue.main.async { completion(false) }
                            } else {
                                DispatchQueue.main.async { completion(nil) }
                            }
                        }
                    }
                }
            }
        } else {
            self.network.get(path: path, headers: headers) { (code, data, headers) in
                if code == 200 {
                    DispatchQueue.main.async { completion(true) }
                } else if code == 404 {
                    DispatchQueue.main.async { completion(false) }
                } else {
                    DispatchQueue.main.async { completion(nil) }
                }
            }
        }
        return
    }
    
    func authenticateOrEnroll(authenticate: Bool, token: String, curp: String, body: Data, _ completion: @escaping (ServiceModel.AuthenticatorEnroller?, ServiceModel.AuthenticatorEnrollerString?, [AnyHashable: Any]?) -> Void) {
        var path = "/grupo/1/autenticacion-universal/personas/\(curp)/factores/facial"
        let headers = [
            "Authorization": "Bearer \(token)",
            "content-type": "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW"
        ]
        if authenticate {
            path += "/autenticar"
        }
        let body = body
        network.post(path: path, headers: headers, body: body) { (code, data, headers) in
            print("RESPUESTA DE authenticateOrEnroll: codigo(\(code)) data(\(data))")
            
            if let code = code, code == 200 {
    
                if let jsonData = data, let result = try? self.jsonDecoder.decode(ServiceModel.AuthenticatorEnroller.self, from: jsonData){
                    DispatchQueue.main.async { completion(result, nil,headers) }
                } else if let jsonData = data, let result = try? self.jsonDecoder.decode(ServiceModel.AuthenticatorEnrollerString.self, from: jsonData) {
                    DispatchQueue.main.async { completion(nil, result,headers) }
                } else {
                    DispatchQueue.main.async { completion(nil, nil,nil) }
                }
            } else if code != nil  {
                DispatchQueue.main.async { completion(nil, nil,nil) }
            } else {
                DispatchQueue.main.async { completion(nil, nil,nil) }
            }
            
            return
        }
    }

}
