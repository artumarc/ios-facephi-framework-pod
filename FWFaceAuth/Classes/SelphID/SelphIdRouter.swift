//
//  IDCaptureRouter.swift
//  FWFaceAuth
//
//  Created by Grecia Escárcega on 05/12/19.
//  Copyright © 2019 Grecia Escárcega. All rights reserved.
//

import UIKit

protocol SelphIdRouterDelegate {
    func routeToVerifyID()
    
}

protocol SelphIdDataPassingDelegate {
    var dataStore: SelphIDDataStore? { get }
}

class SelphIdRouter: SelphIdRouterDelegate, SelphIdDataPassingDelegate {
  
    weak var viewController: SelphIDViewController?
    var dataStore: SelphIDDataStore?
  
    // MARK: Routing
    
    func routeToVerifyID() {
        var destination = VerifyIDViewController(nibName: "VerifyIDViewController", bundle: Util.getBundle())
        passDataToVerifyID(source: viewController!, destination: &destination)
        navigateToVerifyID(source: viewController!, destination: destination)
    }

    // MARK: Navigation
  
    func navigateToVerifyID(source: SelphIDViewController, destination: VerifyIDViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
  
//       MARK: Passing data
      
      func passDataToVerifyID(source: SelphIDViewController, destination: inout VerifyIDViewController) {
        destination.delegate = source.delegate
        destination.faceAuthRequest = source.faceAuthRequest
        destination.selphIDWidgetResult = dataStore?.selpIDWidgetResult
        destination.token = source.token
        destination.isEnrolled = source.isEnrolled
        destination.activityData = source.activityData
      }
}
