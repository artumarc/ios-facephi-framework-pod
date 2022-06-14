//
//  VerifyIDBackViewController.swift
//  FWFaceAuth
//
//  Created by Jorge Villalba on 25/02/21.
//

import Foundation

class VerifyIDBackViewController:FaceAuthViewController{
 
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
        default:
            self.navigationController?.popViewController(animated: true)
            return
        }
        documentImage.image = selphIDWidgetResult?.backImage
    }
    
    
    
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        router.routeToSelphi()
    }
    @IBAction func recaptureButtonTap(_ sender: Any) {
       // router.routeToSelphiId()
      //  self.navigationController?.popToViewController(SelphIDViewController(), animated: true)
        
        
        let allVC = self.navigationController?.viewControllers

        if  let selphIDViewController = allVC![allVC!.count - 3] as? SelphIDViewController {
        self.navigationController!.popToViewController(selphIDViewController, animated: true)
        }
        
    }
    
    private func setup() {
          let viewController = self
          let router = VerifyIDRouter()
          viewController.router = router
          router.viewBackController = viewController
      }
    
}
