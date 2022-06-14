//
//  ValidationErrorViewController.swift
//  FWFaceAuth
//
//  Created by Grecia Escárcega on 04/12/19.
//  Copyright © 2019 Grecia Escárcega. All rights reserved.
//

import UIKit

class ErrorViewController: FaceAuthViewController {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var tryAgainButton: UIButton!
    
    var appError: AppError!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureErrorView()
    }

    @IBAction func dismissButtonTap(_ sender: UIButton) {
        self.delegate?.removeBlur()
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureErrorView() {
        if self.appError == .AuthenticationError {
            errorLabel.text = "No logramos comprobar\ntu identidad"
            tryAgainButton.isHidden = false
            tryAgainButton.configureButton(enabled: true)
        } else {
            errorLabel.text = "Error de conexión,\nintentálo más tarde"
            tryAgainButton.isHidden = true
        }
    }

}
