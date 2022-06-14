//
//  Model.swift
//  FWFaceAuth
//
//  Created by Grecia Escárcega on 05/12/19.
//  Copyright © 2019 Grecia Escárcega. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import FPhiSelphIDWidgetiOS

public enum FaceAuthModel {
    
    public struct Request {
        public var client: String
        public var account: String
        public var curp: String
        public var origen: Int
        public var nombre: String?
        public var apellidoPaterno: String?
        public var apellidoMaterno: String?
        public var processID: Int
        public var subProcessID: Int
        public var appBundle: Bundle
        
        public init (client: String, account: String, curp: String, nombre: String?, apellidoPaterno: String?, apellidoMaterno: String?, origenID: Int, processID: Int, subProcessID: Int, appBundle: Bundle){
            self.client = client
            self.account = account
            self.curp = curp
            self.processID = processID
            self.subProcessID = subProcessID
            self.appBundle = appBundle
            self.nombre = nombre
            self.apellidoMaterno = apellidoMaterno
            self.apellidoPaterno = apellidoPaterno
            self.origen = origenID
        }
    }
    
    public struct UIConfiguration {
        public var activityIndicator: ActivityData
        public var withInstructions: Bool
        
        public init (activityIndicator: ActivityData, withInstructions: Bool){
            self.activityIndicator = activityIndicator
            self.withInstructions = withInstructions
        }
    }

    public struct Response {
        public var authResult: Bool?
        public var string: String
        public var isEnrolled: Bool
        public var selphiResult: SelphiModel.Response.SelphiResult!
        public var selphIdResult: SelphIdModel.WidgetResult?
        public var idTransaction: String
    }
}

public enum DocumentType {
    case Card, Passport
}
