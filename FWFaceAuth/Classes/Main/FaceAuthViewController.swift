//
//  FaceAuthViewController.swift
//  FWFaceAuth
//
//  Created by Grecia Escárcega on 12/12/19.
//  Copyright © 2019 Grecia Escárcega. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import FirebaseAnalytics

public class FaceAuthViewController: UIViewController {
    
    
    public var faceAuthRequest: FaceAuthModel.Request?
    public var delegate: FaceAuthDelegate?
    var token: String?
    var isEnrolled: Bool?
    let activityIndicatorView = UIActivityIndicatorView(style: .large)
    var activityData: ActivityData!
    var selphIDWidgetResult:  SelphIdModel.WidgetResult?
    
    public var idCliente: String?
    public var numeroCuenta: String?
    var firebaseAnalytics = Analytics()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barStyle = .default
        self.configureNavigationBar()
        
        
    }
}
