//
//  IdentificationCaptureModels.swift
//  FWFaceAuth
//
//  Created by Grecia Escárcega on 04/12/19.
//  Copyright (c) 2019 Grecia Escárcega. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import FPhiSelphIDWidgetiOS

public enum SelphIdModel {
    
    struct Request {
        var bundle: Bundle
        var document: FPhiSelphIDWidgetDocumentType
    }
    
    struct Response {
        var idPhotograph: UIImage
        var firstViewSetup: Bool
    }
        
    struct View {
        var idPhotograph: UIImage
        var firstViewSetup: Bool
    }
    
    struct Data {
        var validationRequest: FaceAuthModel
        var selphIdData: WidgetResult
    }
    
    public struct WidgetResult {
        public var documentScanned: DocumentType
        public var frontImage: UIImage
        public var backImage: UIImage?
        public var tokenOCR: String
        public var tokenFaceImage: String
    }
    
    struct Field {
        let code: String
        let value: String
    }
}
