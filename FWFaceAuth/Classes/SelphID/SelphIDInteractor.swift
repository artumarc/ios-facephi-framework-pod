//
//  IdentificationCaptureInteractor.swift
//  FWFaceAuth
//
//  Created by Grecia Escárcega on 05/12/19.
//  Copyright © 2019 Grecia Escárcega. All rights reserved.
//

import UIKit
import FPhiSelphIDWidgetiOS

protocol SelphIDInteractorDelegate {
    
    func startSelphID(request: SelphIdModel.Request)
    
}

protocol SelphIDDataStore {
    var selpIDWidgetResult: SelphIdModel.WidgetResult! { get }
}

class SelphIDInteractor: SelphIDInteractorDelegate, SelphIDDataStore {
    
    var presenter: SelphIDPresenterDelegate!
    var worker = SelphIDWorker()
    
    // Data store
    var selpIDWidgetResult: SelphIdModel.WidgetResult!
    
    // Delegate
    func startSelphID(request: SelphIdModel.Request) {
        worker.delegate = self
        worker.document = request.document
        worker.showWidget(bundle: request.bundle)
    }
}


// MARK: - Worker
extension SelphIDInteractor: SelphIDWorkerDelegate {
    
    func returnData(widgetResult: SelphIdModel.WidgetResult) {
        self.selpIDWidgetResult = widgetResult
        presenter?.verifyID()
    }
    
    func returnWidget(widget: FPhiSelphIDWidget) {
        presenter?.presentWidget(widget: widget)
    }
    
}

