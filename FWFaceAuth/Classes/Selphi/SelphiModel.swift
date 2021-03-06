//
//  public_protocol_IDCaptureDisplayDelegate__class____________func_displayView_viewModel__IDCaptureModel_View_______UserPhotographModels.swift
//  FWFaceAuth
//
//  Created by Grecia Escárcega on 06/12/19.
//  Copyright (c) 2019 Grecia Escárcega. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import FPhiWidgetSelphi

public enum SelphiModel {

    enum Request {
        struct Photo {
            var liveness: FPhiWidgetLivenessMode?
            var extraction: FPhiWidgetExtractionMode?
            var viewController: SelphiViewController?
            
            init() {
                self.liveness = nil
                self.extraction = nil
                self.viewController = nil
            }
            
            init(liveness: FPhiWidgetLivenessMode, extraction: FPhiWidgetExtractionMode, viewController: SelphiViewController) {
                self.liveness = liveness
                self.extraction = extraction
                self.viewController = viewController
            }
        }
        
        struct Matcher {
            var extraction: FPhiWidgetExtractionMode
        }
        
        struct Segue {
            var destination: FaceAuthDelegate
        }
    }
    
    public enum Response {
        struct Photo {
            var userImage: UIImage
            var firstViewSetup: Bool
        }
        
        struct Matcher {
            var segueOption: Int
        }
        public struct SelphiResult {
            public var image: UIImage
            public var templateSelfie: String
            public var templateRostroSelfie: String
            public var selfie64: String
        }
    }
    
    enum ViewController {
        struct View {
            var firstViewSetup: Bool
            var userImage: UIImage
        }
        
        struct Segue {
            var segueOption: Int
        }
    }
    
}
