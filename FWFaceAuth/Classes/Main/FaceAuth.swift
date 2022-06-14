//
//  FaceAuth.swift
//  FWFaceAuth
//
//  Created by Grecia Escárcega on 12/12/19.
//  Copyright © 2019 Grecia Escárcega. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import FirebaseCore

public protocol FaceAuthDelegate: class {
    func showViewController<T>(viewController: T, error: Bool)
    func responseHandler(response: FaceAuthModel.Response)
    func removeBlur()
}

public class FaceAuth {
    
    public var delegate: FaceAuthDelegate?
    private var token: String?
    
    
    public init(delegate: FaceAuthDelegate) {
        self.delegate = delegate
    }
    
    public init() {
        
    }
    
    //MARK: - Flow
    
    public func startFaceAuth(request: FaceAuthModel.Request, uiConfiguration: FaceAuthModel.UIConfiguration) {
        if Constants.Debug.active {
            Constants.Debug.curp = request.curp
            Constants.Debug.client = request.client
        }
        
        getToken { (token) in
            if let token = token {
                self.getClient(curp: request.curp, token: token) { (isEnrolled) in
                    if let isEnrolled = isEnrolled {
                        
                        if uiConfiguration.withInstructions {
                            let instructionsViewController = InstructionsViewController(nibName: "InstructionsViewController", bundle: Util.getBundle())
                            instructionsViewController.isEnrolled = isEnrolled
                            instructionsViewController.delegate = self.delegate
                            instructionsViewController.token = token
                            instructionsViewController.faceAuthRequest = request
                            instructionsViewController.activityData = uiConfiguration.activityIndicator
                            self.delegate?.showViewController(viewController: instructionsViewController, error: false)
                        } else {
                            let selphIDViewController = SelphIDViewController(nibName: "SelphIDViewController", bundle: Util.getBundle())
                            selphIDViewController.isEnrolled = isEnrolled
                            selphIDViewController.delegate = self.delegate
                            selphIDViewController.token = token
                            selphIDViewController.faceAuthRequest = request
                            selphIDViewController.activityData = uiConfiguration.activityIndicator
                            self.delegate?.showViewController(viewController: selphIDViewController, error: false)
                        }
                    } else {
                        self.showError(serviceError: true)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.showError(serviceError: true)
                }
            }
        }
    }
    
    public func showError(serviceError: Bool) {
        let errorVC = ErrorViewController(nibName: "ErrorViewController", bundle: Util.getBundle())
        errorVC.delegate = self.delegate
        if serviceError {
            errorVC.appError = .ServiceError
        } else {
            errorVC.appError = .AuthenticationError
        }
        errorVC.view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)
        errorVC.view.isOpaque = false
        errorVC.modalPresentationStyle = .overCurrentContext
        self.delegate?.showViewController(viewController: errorVC, error: true)
    }
    
    //MARK: - Services
    
    private func getToken(_ completion: @escaping (String?) -> Void) {
        Services.shared.token(completion)
    }
    
    
    private func getClient(curp: String, token:String, _ completion: @escaping (Bool?) -> Void) {
        Services.shared.getClient(token: token, curp: curp, completion)
    }
}
