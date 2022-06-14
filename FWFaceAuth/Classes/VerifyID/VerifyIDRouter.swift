//
//  VerifyIDRouter.swift
//  FirebaseCore
//
//  Created by Grecia Escárcega on 22/07/20.
//

import UIKit

protocol VerifyIDRouterDelegate {
    func routeToSelphi()
    func routeToBackId()
    func routeToSelphiPass()
   
    
}

class VerifyIDRouter: VerifyIDRouterDelegate {
  
    weak var viewController: VerifyIDViewController?
    weak var viewBackController: VerifyIDBackViewController?
  
    // MARK: Routing
    
    func routeToBackId() {
        var destination = VerifyIDBackViewController(nibName: "VerifyIDBackViewController", bundle: Util.getBundle())
        passDataToBack(source: viewController!, destination: &destination)
        navigateToBack(source: viewController!, destination: destination)
    }
    
    func routeToSelphi() {
        var destination = SelphiViewController(nibName: "SelphiViewController", bundle: Util.getBundle())
        passDataToSelphi(source: viewBackController!, destination: &destination)
        navigateToSelphi(source: viewBackController!, destination: destination)
    }
   
    
    func routeToSelphiPass() {
        var destination = SelphiViewController(nibName: "SelphiViewController", bundle: Util.getBundle())
        passDataToSelphiPass(source: viewController!, destination: &destination)
        navigateToSelphiPass(source: viewController!, destination: destination)
    }

    // MARK: Navigation
  
    func navigateToSelphi(source: VerifyIDBackViewController, destination: SelphiViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    func navigateToSelphiPass(source: VerifyIDViewController, destination: SelphiViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    func navigateToBack(source: VerifyIDViewController, destination: VerifyIDBackViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    
  
//       MARK: Passing data
      
      func passDataToSelphi(source: VerifyIDBackViewController, destination: inout SelphiViewController) {
        destination.delegate = source.delegate
        destination.faceAuthRequest = source.faceAuthRequest
        destination.selphIDWidgetResult = source.selphIDWidgetResult
        destination.token = source.token
        destination.isEnrolled = source.isEnrolled
        destination.activityData = source.activityData
      }
    
    func passDataToSelphiPass(source: VerifyIDViewController, destination: inout SelphiViewController) {
      destination.delegate = source.delegate
      destination.faceAuthRequest = source.faceAuthRequest
      destination.selphIDWidgetResult = source.selphIDWidgetResult
      destination.token = source.token
      destination.isEnrolled = source.isEnrolled
      destination.activityData = source.activityData
    }
    
    func passDataToBack(source: VerifyIDViewController, destination: inout VerifyIDBackViewController) {
      destination.delegate = source.delegate
      destination.faceAuthRequest = source.faceAuthRequest
      destination.selphIDWidgetResult = source.selphIDWidgetResult
      destination.token = source.token
      destination.isEnrolled = source.isEnrolled
      destination.activityData = source.activityData
    }
}
