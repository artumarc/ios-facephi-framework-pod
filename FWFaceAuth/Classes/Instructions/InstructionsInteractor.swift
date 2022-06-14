//
//  InstructionsInteractor.swift
//  FWFaceAuth
//
//  Created by Grecia Escárcega on 14/01/20.
//  Copyright (c) 2020 Grecia Escárcega. All rights reserved.
//

import UIKit

protocol InstructionsInteractorDelegate {
}

protocol InstructionsDataStore {
}

class InstructionsInteractor: InstructionsInteractorDelegate, InstructionsDataStore, InstructionsWorkerDelegate {
    var presenter: InstructionsPresenterDelegate?
    var worker: InstructionsWorker?
}
