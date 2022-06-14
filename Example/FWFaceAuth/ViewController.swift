//
//  ViewController.swift
//  FWFaceAuth
//
//  Created by GreciaEM on 01/22/2020.
//  Copyright (c) 2020 GreciaEM. All rights reserved.
//

import UIKit
import FWFaceAuth
import NVActivityIndicatorView
import Crashlytics

class ViewController: UIViewController, FaceAuthDelegate {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    let activityData = ActivityData()
    let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .large)
    var faceAuth = FaceAuth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        faceAuth.delegate = self

        Evento_Analytics[Trazabilidad.Clave.SCREEN_NAME] = "MAIN_BUTTON"
        Evento_Analytics[Trazabilidad.Clave.EVENT_ACTION] = "LAUNCH_SCREEN_BUTTON"
        Evento_Analytics[Trazabilidad.Clave.EVENT_NAME] = "OPEN_LAUNCHFACE"
        analytics.registrarEvento(event_name: "OPEN_LAUNCHFACE", paramteters: Evento_Analytics)
    }
    
    
    @IBAction func button(_ sender: UIButton) {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
        let uiConfig = FaceAuthModel.UIConfiguration(activityIndicator: activityData, withInstructions: true)
        let request = FaceAuthModel.Request(client: "", account: "158199925", curp: "PESH911005HMCRLC07", nombre: nil, apellidoPaterno: nil, apellidoMaterno: nil, origenID: 32, processID: 243, subProcessID: 311, appBundle: Bundle(for: type(of: self)))
        faceAuth.startFaceAuth(request: request, uiConfiguration: uiConfig)
        
        Evento_Analytics[Trazabilidad.Clave.SCREEN_NAME] = "MAIN_BUTTON"
        Evento_Analytics[Trazabilidad.Clave.EVENT_ACTION] = "LAUNCH_FACEPHI"
        Evento_Analytics[Trazabilidad.Clave.EVENT_NAME] = "LAUNCH_FACEPHI"
        analytics.registrarEvento(event_name: "LAUNCH_FACEPHI", paramteters: Evento_Analytics)
        
    }
    
    func setBlurView() {
        let blurView = UIVisualEffectView()
        blurView.frame = view.frame
        blurView.effect = UIBlurEffect(style: .light)
        view.addSubview(blurView)
    }
    
    // MARK: - Framework
    func showViewController<T>(viewController: T, error: Bool) {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
        guard let vc = viewController as? FaceAuthViewController else { return }
        if error {
            self.navigationController?.navigationBar.isHidden = true
            setBlurView()
            
            self.navigationController?.present(vc, animated: true, completion: nil)
            
            

            
            Evento_Analytics[Trazabilidad.Clave.SCREEN_NAME] = "MAIN_BUTTON"
            Evento_Analytics[Trazabilidad.Clave.EVENT_ACTION] = "ERROR"
            Evento_Analytics[Trazabilidad.Clave.EVENT_NAME] = "SHOW_ERROR"
            analytics.registrarEvento(event_name: "SHOW_ERROR", paramteters: Evento_Analytics)
            
        } else {
            self.navigationController?.pushViewController(vc, animated: true)
            

            
            Evento_Analytics[Trazabilidad.Clave.SCREEN_NAME] = "MAIN_BUTTON"
            Evento_Analytics[Trazabilidad.Clave.EVENT_ACTION] = "SHOW_FACEPHI"
            Evento_Analytics[Trazabilidad.Clave.EVENT_NAME] = "SHOW_FACEPHI"
            analytics.registrarEvento(event_name: "SHOW_FACEPHI", paramteters: Evento_Analytics)
            
        }
    }
    
    func responseHandler(response: FaceAuthModel.Response) {
        print(response.selphiResult.image)
        
        
        if let authResult = response.authResult {
            if authResult {
                performSegue(withIdentifier: "homeRetiroSegue", sender: nil)
            } else {
                faceAuth.showError(serviceError: false)
            }
        } else {
            faceAuth.showError(serviceError: true)
        }
        
        
        Evento_Analytics[Trazabilidad.Clave.SCREEN_NAME] = "MAIN_BUTTON"
        Evento_Analytics[Trazabilidad.Clave.EVENT_ACTION] = "RESULT_\(response.authResult)"
        Evento_Analytics[Trazabilidad.Clave.EVENT_NAME] = "RESPONSE_FACE"
        
        analytics.registrarEvento(event_name: "RESPONSE_FACE", paramteters: Evento_Analytics)
        
    }
    
    func removeBlur() {
        removeBlurView()
    }
    
//    MARK: - Helpers
    func removeBlurView() {
        for subview in view.subviews {
            if subview.isKind(of: UIVisualEffectView.self) {
                subview.removeFromSuperview()
            }
        }
        self.navigationController?.navigationBar.isHidden = false
    }
}
