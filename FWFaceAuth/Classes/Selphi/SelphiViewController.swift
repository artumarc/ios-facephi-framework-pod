//
//  UserPhotographViewController.swift
//  FWFaceAuth
//
//  Created by Grecia Escárcega on 04/12/19.
//  Copyright © 2019 Grecia Escárcega. All rights reserved.
//

import UIKit
import FPhiWidgetSelphi
import NVActivityIndicatorView

protocol SelphiDisplayDelegate: class {
    func displayView(viewModel: SelphiModel.ViewController.View)
    func nextView()
}

class SelphiViewController: FaceAuthViewController, SelphiDisplayDelegate {
    
    var interactor: SelphiInteractorDelegate?
    var router: (SelphiDataPassing & SelphiRouterDelegate)?
    
    var Evento_Analytics: Dictionary = [String: String]()
    var isStatusBarHidden = false { didSet { setNeedsStatusBarAppearanceUpdate() }}
    var extractionType: FPhiWidgetExtractionMode = .EMAuthenticate
    var request = SelphiModel.Request.Photo()
    var segue: Int? = nil
    
    //var validationRequest:

    @IBOutlet weak var imageViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var portraitView: UIView!
    @IBOutlet weak var userPhotoImageView: UIImageView!
    @IBOutlet weak var checkMarkImageView: UIImageView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var tryAgainButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
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
        trazabilidad_foto_enter(eventName: TrazabilidadAnalytics.Event_Name_FW.FOTO_ENTER)
        buildPhotoRequest(liveness: .LMLivenessPassive, extraction: self.extractionType)
        initialViewSetup(true)
    }
    
    
    func displayView(viewModel: SelphiModel.ViewController.View) {
        initialViewSetup(viewModel.firstViewSetup)
        userPhotoImageView.image = viewModel.userImage
    }
    
    
    @IBAction func continueButton(_ sender: UIButton) {
        if sender.tag == 1 {
            trazabilidad_confirmar_foto_click​(eventName: TrazabilidadAnalytics.Event_Name_FW.CONFIRMAR_FOTO_CLICK)
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.activityData, nil)
            if let isEnrolled = self.isEnrolled, !isEnrolled {
                interactor?.enroll(request: self.faceAuthRequest!, selphIDWidget: self.selphIDWidgetResult!, token: self.token!)
            } else {
                interactor?.authenticate(request: self.faceAuthRequest!, token: self.token!)
            }
        } else {
            startSelphi()
        }
        
    }

    @IBAction func takePhotoButtonTapped(_ sender: UIButton) {
        trazabilidad_confirmar_foto_click​(eventName: TrazabilidadAnalytics.Event_Name_FW.REEMPLAZAR_FOTO_CLICK)//
        //self.interactor?.takePhotograph(request: request)
        startSelphi()
    }
    
    func buildPhotoRequest(liveness: FPhiWidgetLivenessMode, extraction: FPhiWidgetExtractionMode){
        self.request.liveness = liveness
        self.request.extraction = extraction
        self.request.viewController = self
    }
    
    func initialViewSetup(_ bool: Bool) {
        continueButton.configureButton(enabled: true)
        checkMarkImageView.isHidden = bool
        if bool {
            tryAgainButton.isHidden = true
        } else {
            tryAgainButton.isHidden = false
            continueButton.setTitle("Continuar", for: .normal)
            userPhotoImageView.contentMode = .scaleAspectFill
            continueButton.tag = 1
            view.layoutIfNeeded()
            titleLabel.text = "Tu foto"
        }
        continueButton.addKernToTitleText()
    }
    
    func nextView() {
        DispatchQueue.main.async {
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
            let segue = SelphiModel.Request.Segue(destination: self.delegate!)
            self.router?.performSegue(segueRequest: segue)
        }
    }
    
    private func setup() {
        let viewController = self
        let interactor = SelphiInteractor()
        let presenter = SelphiPresenter()
        let router = SelphiRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func startSelphi() {
        Util.isCameraAuthorized { (granted, flag) in
            if granted {
                DispatchQueue.main.async {
                    self.interactor?.takePhotograph(request: self.request)
                }
            }
            else {
                switch flag {
                case .notDetermined:
                    AVCaptureDevice.requestAccess(for: .video) { granted in
                        if granted {
                            DispatchQueue.main.async {
                                self.interactor?.takePhotograph(request: self.request)
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


extension SelphiViewController {
    
    private func trazabilidad_foto_enter(eventName : String){
        
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.SCREEN_NAME] = TrazabilidadAnalytics.Screen_Name_FW.FOTO_RETIRO_SCREEN
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.EVENT_NAME] = eventName
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.EVENT_ACTION] = TrazabilidadAnalytics.Event_Action_FW.ACTION_OPEN
        
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.NUMERO_CUENTA] = numeroCuenta
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.ID_CLIENTE] = idCliente
        
        RegistrarEventoAnalytics.registrarEvento(event_name: eventName, paramteters: Evento_Analytics)
    }
    
    private func trazabilidad_confirmar_foto_click​(eventName : String){
        
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.SCREEN_NAME] = TrazabilidadAnalytics.Screen_Name_FW.FOTO_RETIRO_SCREEN
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.EVENT_NAME] = eventName
        
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.NUMERO_CUENTA] = numeroCuenta
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.ID_CLIENTE] = idCliente
        
        RegistrarEventoAnalytics.registrarEvento(event_name: eventName, paramteters: Evento_Analytics)
    }
}
