//
//  VerifyIDViewController.swift
//  FirebaseCore
//
//  Created by Grecia Escárcega on 21/07/20.
//

import UIKit
import FPhiSelphIDWidgetiOS

class VerifyIDViewController: FaceAuthViewController {
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var documentImage: UIImageView!
    @IBOutlet weak var portraitView: UIView!
    
    
    var router: VerifyIDRouterDelegate!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.portraitView.layer.borderColor = UIColor.clear.cgColor
        continueButton.configureButton(enabled: true)
        switch selphIDWidgetResult?.documentScanned {
        case .Card:
            titleLabel.text = "Tu INE/IFE"
            break
        case .Passport:
            titleLabel.text = "Tu Pasaporte"
            break
        default:
            self.navigationController?.popViewController(animated: true)
            return
        }
        documentImage.image = selphIDWidgetResult?.frontImage
    }


    @IBAction func continueButtonTapped(_ sender: UIButton) {
        
        switch selphIDWidgetResult?.documentScanned {
            case .Card:
                router.routeToBackId()
            break
            default:
                router.routeToSelphiPass()
            break
        }
        
        
    }
    
    @IBAction func recaptureButtonTap(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
     private func setup() {
           let viewController = self
           let router = VerifyIDRouter()
           viewController.router = router
           router.viewController = viewController
       
     }

}
