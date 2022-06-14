//
//  IDCaptureWorker.swift
//  FWFaceAuth
//
//  Created by Grecia Escárcega on 05/12/19.
//  Copyright © 2019 Grecia Escárcega. All rights reserved.
//

import UIKit
import Microblink
import Microblink.MBException
import FPhiSelphIDWidgetiOS
import os.log

protocol SelphIDWorkerDelegate {
    func returnData(widgetResult: SelphIdModel.WidgetResult)
    func returnWidget(widget: FPhiSelphIDWidget)
}

class SelphIDWorker {
    
    var delegate: SelphIDWorkerDelegate!
    var selphIDWidget: FPhiSelphIDWidget?
    var document: FPhiSelphIDWidgetDocumentType!
    var documentType: DocumentType {
        if document == .DTIDCard {
            return .Card
        } else {
            return .Passport
        }
    }
    
    var Evento_Analytics: Dictionary = [String: String]()
    
    init(delegate: SelphIDWorkerDelegate, document: FPhiSelphIDWidgetDocumentType) {
        self.delegate = delegate
        self.document = document
    }
    
    init() {}

    func showWidget(bundle: Bundle) {
        
        let thisBundle = Util.getBundle()
        
        guard let license = getLicense(bundle) else { return }
        
        guard let widgetResources = getSelphIDWidgetResources(thisBundle) else { return }
        
        if let path = bundle.path(forResource: "GoogleService-Info", ofType: "plist"), let data = FileManager.default.contents(atPath: path), let plist = try? PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format: nil), let dictionary = plist as? [String: Any] {
            let firebase = [
                "GoogleAppID": dictionary["GOOGLE_APP_ID"] as! String,
                "GCMSenderID": dictionary["GCM_SENDER_ID"] as! String
            ]
            selphIDWidget = FPhiSelphIDWidget(frontCameraIfAvailable: true, resources: widgetResources, delegate: self, license: license, error: nil, credentials: firebase)
        } else {
            selphIDWidget = try? FPhiSelphIDWidget(frontCameraIfAvailable: true, resources: widgetResources, delegate: self, license: license)
        }
        
        guard let widget = selphIDWidget else { return }
        
        
        //widget.scanSide = .DSFront
        widget.scanMode = .SMSearch
        widget.showTutorial = true
        widget.scanType = document
        widget.wizardMode = true
      //  widget.showAfterCapture = false
        widget.specificData = "MX|<ALL>"
        widget.startExtraction()
        
    
        delegate.returnWidget(widget: widget)
    }
    
}

// MARK: - FPhiSelphIDWidgetProtocol

extension SelphIDWorker: FPhiSelphIDWidgetProtocol {
    
    func onEvent(_ time: Date!, type: String!, info: String!) {
        print(type + info)
    }
    
    func getLicense(_ bundle: Bundle) -> String? {
        let fileName = Constants.license
        print(Constants.license)
        guard let path = bundle.path(forResource: fileName, ofType: "lic") else { return nil }
        guard let license = try? String(contentsOfFile: path, encoding: .utf8) else { return nil }
        return license
    }

    func getSelphIDWidgetResources(_ bundle: Bundle) -> String? {
        let widgetResources = bundle.path(forResource: "SelphID-1.0", ofType: "zip")
        return widgetResources
    }
    
    var description: String {
        return ""
    }
    
    var hash: Int {
        return 0
    }
    
    var superclass: AnyClass? {
        return nil
    }
    
    
    func captureFinished() {
        os_log("[Widget] - %s", log: .default, type: .debug, "Capture finished")
        guard let results = selphIDWidget?.results else { return }
        guard let frontImage = results.frontDocument else { return }
        guard let tokenOCR = results.tokenOCR else { return }
        guard let tokenFaceImage = results.tokenFaceImage else { return }
        let widgetResult = SelphIdModel.WidgetResult(documentScanned: documentType, frontImage: frontImage, backImage: results.backDocument, tokenOCR: tokenOCR, tokenFaceImage: tokenFaceImage)
        delegate?.returnData(widgetResult: widgetResult)
    }
    func captureCancelled() {
        //Este evento no se trazo en android
        //trazabilidad_clicks(eventName: TrazabilidadAnalytics.Event_Name_FW.CERRAR_CAPTURA_RETIRO_AV_CLICK)
            os_log("[Widget] - %s", log: .default, type: .debug, "Capture cancelled")
    }
    
        /**
         Invoked when the extraction process fail.
         - Optional method
         */
    func captureFailed(_ error: Error!) {
        //Este evento no se trazo en android
        //trazabilidad_clicks_failedsuccess(eventName: TrazabilidadAnalytics.Event_Name_FW.SCAN_CLICK, result: TrazabilidadAnalytics.Event_Name_FW.FAILED, error: "Capture failed")
            os_log("[Widget] - %s", log: .default, type: .debug, "Capture failed")
    }
    
        /**
         Invoked when extraction process is aborted by timeout.
         - Optional method
         */
    func captureTimeout() {
        //Este evento no se trazo en android
        //trazabilidad_clicks_failedsuccess(eventName: TrazabilidadAnalytics.Event_Name_FW.SCAN_CLICK, result: TrazabilidadAnalytics.Event_Name_FW.FAILED, error: "Capture timeout")
            os_log("[Widget] - %s", log: .default, type: .debug, "Capture timeout")
    }

    // Funciones de protocolo
    func isEqual(_ object: Any?) -> Bool {
        return true
    }
    
    func `self`() -> Self {
        self
    }
    
    func perform(_ aSelector: Selector!) -> Unmanaged<AnyObject>! {
        return nil
    }
    
    func perform(_ aSelector: Selector!, with object: Any!) -> Unmanaged<AnyObject>! {
        return nil
    }
    
    func perform(_ aSelector: Selector!, with object1: Any!, with object2: Any!) -> Unmanaged<AnyObject>! {
        return nil
    }
    
    func isProxy() -> Bool {
        return true
    }
    
    func isKind(of aClass: AnyClass) -> Bool {
        return true
    }
    
    func isMember(of aClass: AnyClass) -> Bool {
        return true
    }
    
    func conforms(to aProtocol: Protocol) -> Bool {
        return true
    }
    
    func responds(to aSelector: Selector!) -> Bool {
        return true
    }
    
}

// MARK: - Trazabilidad

extension SelphIDWorker {
    
    private func trazabilidad_escaner_frente_retiro_av_enter(eventName : String){
        var Evento_Analytics: Dictionary = [String: String]()
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.SCREEN_NAME] = TrazabilidadAnalytics.Screen_Name_FW.CAPTURA_INE_IFE_FRENTE_RETIRO_SCREEN
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.EVENT_NAME] = eventName
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.EVENT_ACTION] = TrazabilidadAnalytics.Event_Action_FW.ACTION_OPEN
        
        //Evento_Analytics[TrazabilidadAnalytics.ClaveFW.NUMERO_CUENTA] = numeroCuenta
        //Evento_Analytics[TrazabilidadAnalytics.ClaveFW.ID_CLIENTE] = idCliente
        
        RegistrarEventoAnalytics.registrarEvento(event_name: eventName, paramteters: Evento_Analytics)
    }
    
    private func trazabilidad_clicks(eventName : String){
        
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.SCREEN_NAME] = TrazabilidadAnalytics.Screen_Name_FW.CAPTURA_INE_IFE_FRENTE_RETIRO_SCREEN
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.EVENT_NAME] = eventName
        
        //Evento_Analytics[TrazabilidadAnalytics.ClaveFW.NUMERO_CUENTA] = numeroCuenta
        //Evento_Analytics[TrazabilidadAnalytics.ClaveFW.ID_CLIENTE] = idCliente
        
        RegistrarEventoAnalytics.registrarEvento(event_name: eventName, paramteters: Evento_Analytics)
    }
    
    private func trazabilidad_clicks_failedsuccess(eventName : String, result: String, error: String){
        
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.SCREEN_NAME] = TrazabilidadAnalytics.Screen_Name_FW.CAPTURA_INE_IFE_FRENTE_RETIRO_SCREEN
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.EVENT_NAME] = eventName
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.RESULT_SCAN] = result
        Evento_Analytics[TrazabilidadAnalytics.ClaveFW.MENSAJE_ERROR] = error
        
        //Evento_Analytics[TrazabilidadAnalytics.ClaveFW.NUMERO_CUENTA] = numeroCuenta
        //Evento_Analytics[TrazabilidadAnalytics.ClaveFW.ID_CLIENTE] = idCliente
        
        RegistrarEventoAnalytics.registrarEvento(event_name: eventName, paramteters: Evento_Analytics)
    }
}
