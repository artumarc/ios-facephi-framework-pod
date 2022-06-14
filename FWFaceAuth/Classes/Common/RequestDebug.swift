//
//  RequestDebug.swift
//  FirebaseCore
//
//  Created by Grecia Escárcega on 12/05/20.
//

import Foundation

struct RequestDebug {
    
    enum ServiceOption {
        case request, response, imageUpload
    }
    
    static func post(request body: Data?, _ completion: @escaping (Bool) -> Void) {
        var requestURLComponents = URLComponents(string: "")!
        
        requestURLComponents.path = ""

        var request = URLRequest(url: requestURLComponents.url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 500.0)

        if let body = body {
            request.httpBody = body
        }
        
        request.timeoutInterval = 180
        request.httpMethod = "POST"
        
        print("**************************************************************************")
        print("DEBUG_REQUEST: \(request)")
        if let data = body, let dataString = String(data: data, encoding: .utf8) {
            print("Response data string:\n \(dataString)")
        }

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("DEBUG_SERVICE_ERROR: \(error!.localizedDescription)")
                DispatchQueue.main.async { completion(false) }
                return
            } else {
                let httpResponse = response as! HTTPURLResponse
                switch httpResponse.statusCode {
                case 200:
                    let dataString = String(data: data!, encoding: .utf8)!
                    print("DEBUG_SERVICE_RESPONSE: \(dataString)")
                    if let jsonData = data, let result = try? JSONDecoder().decode(DebugModel.Request.self, from: jsonData) {
                        Constants.Debug.idRequest = Int(result.data!.id_request)
                        DispatchQueue.main.async { completion(true) }
                    }
                    break
                default:
                    let string = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
                    print("DEBUG_SERVICE_RESPONSE_ERROR: \(httpResponse.statusCode), \(string)")
                    DispatchQueue.main.async { completion(false) }
                    break
                }
            }
        }
        task.resume()
        return
    }
    
    static func post(response body: Data?) {
        var requestURLComponents = URLComponents(string: "")!
        
        requestURLComponents.path = ""

        var request = URLRequest(url: requestURLComponents.url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 500.0)

        if let body = body {
            request.httpBody = body
        }
        request.timeoutInterval = 180

        request.httpMethod = "POST"
        
        print("**************************************************************************")
        print("DEBUG_REQUEST: \(request)")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("SERVICE_ERROR: \(error!.localizedDescription)")
                return
            } else {
                let httpResponse = response as! HTTPURLResponse
                switch httpResponse.statusCode {
                case 200:
                    let dataString = String(data: data!, encoding: .utf8)!
                    print("SERVICE_RESPONSE: \(dataString)")
                    break
                default:
                    let string = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
                    print("SERVICE_RESPONSE_ERROR: \(httpResponse.statusCode), \(string)")
                    break
                }
            }
        }
        task.resume()
    }
    
    static func post(images body: Data?, _ completion: @escaping (DebugModel.Images?) -> Void) {
        let headers = [
            "content-type": "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW"
        ]
        
        var requestURLComponents = URLComponents(string: "")!
        
        requestURLComponents.path = ""

        var request = URLRequest(url: requestURLComponents.url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 500.0)

        if let body = body {
            request.httpBody = body
        }
        
        request.timeoutInterval = 180
        request.allHTTPHeaderFields = headers

        request.httpMethod = "POST"
        
        print("**************************************************************************")
        print("DEBUG_REQUEST: \(request)")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("SERVICE_ERROR: \(error!.localizedDescription)")
                DispatchQueue.main.async { completion(nil) }
                return
            } else {
                let httpResponse = response as! HTTPURLResponse
                switch httpResponse.statusCode {
                case 200:
                    let dataString = String(data: data!, encoding: .utf8)!
                    if let jsonData = data, let result = try? JSONDecoder().decode(DebugModel.UploadImages.self, from: jsonData) {
                        print("SERVICE_RESPONSE: \(dataString)")
                        DispatchQueue.main.async { completion(result.data) }
                    }
                    break
                default:
                    let string = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
                    print("SERVICE_RESPONSE_ERROR: \(httpResponse.statusCode), \(string)")
                    DispatchQueue.main.async { completion(nil) }
                    break
                }
            }
        }
        task.resume()
        return
    }
    
    enum DebugModel {
        struct Request: Codable {
            var data: RequestData?
            private enum CodingKeys: String, CodingKey {
                case data
            }
        }
        
        struct RequestData: Codable {
            var id_request: String
            private enum CodingKeys: String, CodingKey {
                case id_request
            }
        }
        
        struct Response: Codable {
            var data: Bool?
            private enum CodingKeys: String, CodingKey {
                case data
            }
        }
        
        struct Images: Codable {
            var imagen_selfie: String?
            var imagen_ine_frente: String?
            var imagen_ine_reverso: String?
            private enum CodingKeys: String, CodingKey {
                case imagen_selfie, imagen_ine_frente, imagen_ine_reverso
            }
        }
        
        struct UploadImages: Codable {
            var data: Images
            private enum CodingKeys: String, CodingKey {
                case data
            }
        }
    }
}
