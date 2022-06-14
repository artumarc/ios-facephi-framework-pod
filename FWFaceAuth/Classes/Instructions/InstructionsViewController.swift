//
//  InstructionsViewController.swift
//  FWFaceAuth
//
//  Created by Grecia Escárcega on 14/01/20.
//  Copyright (c) 2020 Grecia Escárcega. All rights reserved.
//

import UIKit


protocol InstructionsViewControllerDelegate: class {
    
}

class InstructionsViewController: FaceAuthViewController, InstructionsViewControllerDelegate {
    
    @IBOutlet weak var firstStepView: StepView!
    @IBOutlet weak var secondStepView: StepView!
    @IBOutlet weak var thirdStepView: StepView!
    @IBOutlet weak var continueButton: UIButton!
    
    var Evento_Analytics: Dictionary = [String: String]()
    var interactor: InstructionsInteractorDelegate?
    var router: (NSObjectProtocol & InstructionsRouterDelegate & InstructionsDataRoutingDelegate)?
    
    
    var stepsData: [Instructions.Step]?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Datos de la app de clientes
        idCliente = self.faceAuthRequest?.client
        numeroCuenta = self.faceAuthRequest?.account
        
        trazabilidad_pasos_av_enter(eventName: TrazabilidadAnalytics.Event_Name_FW.PASOS_AV_ENTER)
        let bundle = Util.getBundle()
        if let url = bundle.url(forResource: "Steps", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let steps = try decoder.decode([Instructions.Step].self, from: data)
                viewSetup(isEnrolled: self.isEnrolled! , steps: steps)
            } catch {
                print(InstructionModuleErros.JSON_PARSE_ERROR)
            }
        }
    }
    
    @IBAction func continueButtonTap(_ sender: UIButton) {
        trazabilidad_clicks(eventName: TrazabilidadAnalytics.Event_Name_FW.CONTINUAR_AV_CLICK)
        self.router?.routeToAuthScreen(isEnrolled: isEnrolled!)
    }
    
    func viewSetup(isEnrolled: Bool, steps: [Instructions.Step]) {
        continueButton.configureButton(enabled: true)
        
        if isEnrolled {
            setupStepView(view: firstStepView, stepNumber: steps[1].step - 1, imageName: steps[1].image, stepLabel: steps[1].label)
            setupStepView(view: secondStepView, stepNumber: steps[2].step - 1, imageName: steps[2].image, stepLabel: steps[2].label)
            hideStepView(view: thirdStepView)
        } else {
            setupStepView(view: firstStepView, stepNumber: steps[0].step, imageName: steps[0].image, stepLabel: steps[0].label)
            setupStepView(view: secondStepView, stepNumber: steps[1].step, imageName: steps[1].image, stepLabel: steps[1].label)
            setupStepView(view: thirdStepView, stepNumber: steps[2].step, imageName: steps[2].image, stepLabel: steps[2].label)
        }
    }
    
    
    func setupStepView(view: StepView, stepNumber: Int, imageName: String, stepLabel: String) {
        view.stepIconImageView.contentMode = .scaleAspectFit
        view.stepNumberLabel.text = "Paso \(stepNumber)"
        view.stepIconImageView.image = UIImage(named: imageName, in: Util.getBundle(), compatibleWith: nil)
        view.stepLabel.text = stepLabel
    }
    
    func hideStepView(view: StepView) {
        view.stepIconImageView.isHidden = true
        view.stepNumberLabel.isHidden = true
        view.stepLabel.isHidden = true
    }
    
//    MARK: - Communication setup
    
    private func setup() {
        let viewController = self
        let interactor = InstructionsInteractor()
        let presenter = InstructionsPresenter()
        let router = InstructionsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

}

extension InstructionsViewController {
    
    private func trazabilidad_pasos_av_enter(eventName : String){
        
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.SCREEN_NAME] = TrazabilidadAnalytics.Screen_Name_FW.CAPTURA_PASOS_PARA_RETIRO_SCREEN
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.EVENT_NAME] = eventName
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.EVENT_ACTION] = TrazabilidadAnalytics.Event_Action_FW.ACTION_OPEN
        
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.NUMERO_CUENTA] = numeroCuenta
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.ID_CLIENTE] = idCliente
        
        RegistrarEventoAnalytics.registrarEvento(event_name: eventName, paramteters: Evento_Analytics)
    }
    
    private func trazabilidad_clicks(eventName : String){
        
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.SCREEN_NAME] = TrazabilidadAnalytics.Screen_Name_FW.CAPTURA_PASOS_PARA_RETIRO_SCREEN
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.EVENT_NAME] = eventName
        
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.NUMERO_CUENTA] = numeroCuenta
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.ID_CLIENTE] = idCliente
        
        RegistrarEventoAnalytics.registrarEvento(event_name: eventName, paramteters: Evento_Analytics)
    }
}
