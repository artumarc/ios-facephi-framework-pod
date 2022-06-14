//
//  UserPhotographPresenter.swift
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

protocol SelphiPresenterDelegate {
    func presentView(response: SelphiModel.Response.Photo)
    func performSegue()
}

class SelphiPresenter: SelphiPresenterDelegate {
  
    weak var viewController: SelphiDisplayDelegate?
  
    func presentView(response: SelphiModel.Response.Photo) {
        let viewModel = SelphiModel.ViewController.View(firstViewSetup: response.firstViewSetup, userImage: response.userImage)
        viewController?.displayView(viewModel: viewModel)
    }
    
    func performSegue() {
        viewController?.nextView()
    }
}
