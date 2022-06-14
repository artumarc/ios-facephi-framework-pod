//
//  IdentificationCapturePresenter.swift
//  FWFaceAuth
//
//  Created by Grecia Escárcega on 05/12/19.
//  Copyright © 2019 Grecia Escárcega. All rights reserved.
//

import Foundation
import FPhiSelphIDWidgetiOS

protocol SelphIDPresenterDelegate {
    func presentWidget(widget: FPhiSelphIDWidget)
    func verifyID()
}

class SelphIDPresenter: SelphIDPresenterDelegate {
    func verifyID() {
        viewController?.nextScreen()
    }
    
    
    weak var viewController: SelphIDViewControllerDelegate?
    
    func presentWidget(widget: FPhiSelphIDWidget) {
        viewController?.presentWidget(widget: widget)
    }
    
}
