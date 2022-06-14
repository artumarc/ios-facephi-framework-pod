//
//  IdentificationCaptureViewController.swift
//  FWFaceAuth
//
//  Created by Grecia Escárcega on 04/12/19.
//  Copyright (c) 2019 Grecia Escárcega. All rights reserved.
//

import UIKit
import FPhiSelphIDWidgetiOS


protocol SelphIDViewControllerDelegate: class {
    func nextScreen()
    func presentWidget(widget: FPhiSelphIDWidget)
}

class SelphIDViewController: FaceAuthViewController {
    
    var Evento_Analytics: Dictionary = [String: String]()
    var interactor: SelphIDInteractorDelegate!
    var router: (SelphIdRouterDelegate & SelphIdDataPassingDelegate)?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var portraitView: UIView!
    @IBOutlet weak var idImageView: UIImageView!
    @IBOutlet weak var checkMarkImageView: UIImageView!
    @IBOutlet weak var tryAgainButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var portraitTitleSeparationConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var ineCaptureButton: UIButton!
    @IBOutlet weak var passportCaptureButton: UIButton!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trazabilidad_captura_ine_av_enter​(eventName: TrazabilidadAnalytics.Event_Name_FW.CAPTURA_INE_AV_ENTER)
        setUpButtonImage(button: ineCaptureButton)
        setUpButtonImage(button: passportCaptureButton)
    }
    
    func setUpButtonImage(button: UIButton) {
        button.imageView?.contentMode = .scaleAspectFit
    }
    
    @IBAction func captureIDButtonTapped(_ sender: UIButton) {
        var canContinue = false
        var request: SelphIdModel.Request!
        let parentBundle = self.faceAuthRequest!.appBundle
        if sender.tag == 0 {
            request = SelphIdModel.Request(bundle: parentBundle, document: .DTIDCard)
            canContinue = true
        } else {
            if self.faceAuthRequest?.processID == 235 {
                canContinue = false
                self.promptNoPassport()
            }else{
                request = SelphIdModel.Request(bundle: parentBundle, document: .DTPassport)
                canContinue = true
            }
        }
        if canContinue {
            Util.isCameraAuthorized { (granted, flag) in
                if granted {
                    DispatchQueue.main.async {
                        self.interactor.startSelphID(request: request)
                    }
                }
                else {
                    switch flag {
                    case .notDetermined:
                        AVCaptureDevice.requestAccess(for: .video) { granted in
                            if granted {
                                DispatchQueue.main.async {
                                    self.interactor.startSelphID(request: request)
                                }
                            }
                            else {
                                self.promptForCameraUsage()
                            }
                        }
                        break
                    default:
                        DispatchQueue.main.async {
                            self.promptForCameraUsage()
                        }
                        break
                    }
                }
            }
        }
    }
}

// MARK: - VIP setup
extension SelphIDViewController {
     private func setup() {
           let viewController = self
           let interactor = SelphIDInteractor()
           let presenter = SelphIDPresenter()
           let router = SelphIdRouter()
           viewController.interactor = interactor
           viewController.router = router
           interactor.presenter = presenter
           presenter.viewController = viewController
           router.viewController = viewController
           router.dataStore = interactor
    }
}

// MARK: - SelphIDViewControllerDelegate
extension SelphIDViewController: SelphIDViewControllerDelegate{
    func nextScreen() {
        router?.routeToVerifyID()
    }
    
    func presentWidget(widget: FPhiSelphIDWidget) {
        self.present(widget, animated: true, completion: nil)
    }
}

// MARK: - Trazabilidad

extension SelphIDViewController {
    
    private func trazabilidad_captura_ine_av_enter​(eventName : String){
        
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.SCREEN_NAME] = TrazabilidadAnalytics.Screen_Name_FW.CAPTURA_INE_IFE_FRENTE_RETIRO_SCREEN
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.EVENT_NAME] = eventName
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.EVENT_ACTION] = TrazabilidadAnalytics.Event_Action_FW.ACTION_OPEN
        
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.NUMERO_CUENTA] = numeroCuenta
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.ID_CLIENTE] = idCliente
        
        RegistrarEventoAnalytics.registrarEvento(event_name: eventName, paramteters: Evento_Analytics)
    }
    
    private func trazabilidad_frente_ine_av_click​(eventName : String){
        
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.SCREEN_NAME] = TrazabilidadAnalytics.Screen_Name_FW.CAPTURA_INE_IFE_FRENTE_RETIRO_SCREEN
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.EVENT_NAME] = eventName
        
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.NUMERO_CUENTA] = numeroCuenta
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.ID_CLIENTE] = idCliente
        
        RegistrarEventoAnalytics.registrarEvento(event_name: eventName, paramteters: Evento_Analytics)
    }
}
