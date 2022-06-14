//
//  UserPhotographRouter.swift
//  FWFaceAuth
//
//  Created by Grecia Escárcega on 06/12/19.
//  Copyright (c) 2019 Grecia Escárcega. All rights reserved.
//

import UIKit

protocol SelphiRouterDelegate {
    func performSegue(segueRequest: SelphiModel.Request.Segue)
}

protocol SelphiDataPassing {
    var dataStore: SelphiDataStore? { get }
}

class SelphiRouter: SelphiRouterDelegate, SelphiDataPassing {
    
    var dataStore: SelphiDataStore?
    weak var viewController: SelphiViewController!
    var delegate: FaceAuthDelegate!
  
    // MARK: Routing
    
    func performSegue(segueRequest: SelphiModel.Request.Segue) {
        endAppFlow(segueRequest.destination)
        var string: String {
            switch dataStore!.authResult {
            case true:
                return "VERDADERO"
            case false:
                return "FALSO"
            default:
                return ""
            }
        }
        let response = FaceAuthModel.Response(authResult: dataStore!.authResult, string: string, isEnrolled: viewController.isEnrolled!, selphiResult: dataStore!.selphiWidget!, selphIdResult: viewController.selphIDWidgetResult, idTransaction: dataStore!.idTransaction ?? "")
        segueRequest.destination.responseHandler(response: response)
    }
      
    func endAppFlow<T>(_ topView: T) {
        viewController.navigationController?.popToViewController(topView as! UIViewController, animated: false)
    }
    
    
}
