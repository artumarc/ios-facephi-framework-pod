//
//  Util.swift
//  FWFaceAuth
//
//  Created by Grecia Escárcega on 18/12/19.
//  Copyright © 2019 Grecia Escárcega. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class Util {
    static func getBundle() -> Bundle {
        let podBundle = Bundle(for: self)
        if let bundleURL = podBundle.url(forResource: "FWFaceAuth", withExtension: "bundle") {
            return Bundle(url: bundleURL)!
        } else {
            return podBundle
        }
    }
    
    static func dictionaryToData(dictionary: [String: Any]) -> Data? {
        var dataString = [String]()
        for(key, value) in dictionary {
            dataString.append(key + "=\(value)")
        }
        let dataMap = dataString.map { String($0) }.joined(separator: "&")
        let data = dataMap.data(using: .utf8)
        return data
    }
    
    static func formDataBody(parameters: [String: Any], images: [String: Data?]) -> Data {
        let boundary = "----WebKitFormBoundary7MA4YWxkTrZu0gW"
        let mimeType = "image/jpeg"
        var body = Data()
        let boundaryPrefix = "--\(boundary)\r\n"
        for (key, value) in parameters {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
        for (key, value) in images {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(key).jpeg\"\r\n")
            body.appendString("Content-Type: \(mimeType)\r\n\r\n")
            if let value = value { body.append(value) }
            body.appendString("\r\n")
        }
        
        body.appendString("--".appending(boundary.appending("--")))
        
        return body
    }
    
    
    static func debugImages(images: [String: Data?]) -> Data {
        let boundary = "----WebKitFormBoundary7MA4YWxkTrZu0gW"
        let mimeType = "image/jpeg"
        var body = Data()
        let boundaryPrefix = "--\(boundary)\r\n"

        for (key, value) in images {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(key).jpeg\"\r\n")
            body.appendString("Content-Type: \(mimeType)\r\n\r\n")
            if let value = value { body.append(value) }
            body.appendString("\r\n")
        }
        
        body.appendString("--".appending(boundary.appending("--")))
        
        return body
    }
    
    static func loginStringToBase64(userName: String, password: String) -> String {
        let loginString = String(format: "%@:%@", userName, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        return loginData.base64EncodedString()
    }
    
    static func isCameraAuthorized(isAuthorizedHandler: (Bool, AVAuthorizationStatus?) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                isAuthorizedHandler(true, nil)
                break
            case .denied:
                isAuthorizedHandler(false, .denied)
                break
            case .notDetermined:
                isAuthorizedHandler(false, .notDetermined)
                break
            case .restricted:
                isAuthorizedHandler(false, .restricted)
                break
        }
    }
    
}


