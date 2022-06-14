//
//  InstructionsRouter.swift
//  FWFaceAuth
//
//  Created by Grecia Escárcega on 14/01/20.
//  Copyright (c) 2020 Grecia Escárcega. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol InstructionsRouterDelegate {
    func routeToAuthScreen(isEnrolled: Bool)
}

protocol InstructionsDataRoutingDelegate {
    var dataStore: InstructionsDataStore? { get }
}

class InstructionsRouter: NSObject, InstructionsRouterDelegate, InstructionsDataRoutingDelegate {
    
    weak var viewController: InstructionsViewController?
    var dataStore: InstructionsDataStore?

    func routeToAuthScreen(isEnrolled: Bool) {
        if isEnrolled {
            let selphiViewController = SelphiViewController(nibName: "SelphiViewController", bundle: Util.getBundle())
            selphiViewController.isEnrolled = isEnrolled
            selphiViewController.extractionType = .EMAuthenticate
            selphiViewController.token = viewController!.token
            selphiViewController.faceAuthRequest = viewController!.faceAuthRequest
            selphiViewController.activityData = viewController!.activityData
            selphiViewController.delegate = viewController!.delegate
            viewController?.navigationController?.pushViewController(selphiViewController, animated: true)
        } else {
            let selphIdViewController = SelphIDViewController(nibName: "SelphIDViewController", bundle: Util.getBundle())
            selphIdViewController.isEnrolled = isEnrolled
            selphIdViewController.faceAuthRequest = viewController!.faceAuthRequest
            selphIdViewController.token = viewController!.token
            selphIdViewController.delegate = viewController!.delegate
            selphIdViewController.activityData = viewController!.activityData
            viewController?.navigationController?.pushViewController(selphIdViewController, animated: true)
        }
    }
}