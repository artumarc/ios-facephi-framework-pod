//
//  Extensions.swift
//  FWFaceAuth
//
//  Created by Grecia Escárcega on 04/12/19.
//  Copyright © 2019 Grecia Escárcega. All rights reserved.
//

import UIKit

public enum ChangeableElementType {
    case button
    case label
}

extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}

extension UIButton {
    
    func addKernToTitleText() {
        if let titleLabelText = self.titleLabel?.text {
            let attributedString = NSMutableAttributedString(string: titleLabelText)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(1.0), range: NSRange(location: 0, length: attributedString.length))
            self.titleLabel!.attributedText = attributedString

        }
    }
    
    func underlineText() {
        if let titleLabelText = self.titleLabel?.text {
            let attributedString = NSMutableAttributedString(string: titleLabelText)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
            self.titleLabel!.attributedText = attributedString
        }
    }
    
    func roundCorners() {
        self.layer.cornerRadius = 22
    }
    
    func configureButton(enabled: Bool) {
        addKernToTitleText()
        roundCorners()
        enable(enabled)
    }
    
    func enable(_ enabled: Bool) {
        let color: UIColor
        if enabled {
            self.isEnabled = true
            color = UIColor.CustomPalette.darkishBlue!
        } else {
            self.isEnabled = false
            color = UIColor.lightGray
        }
        self.backgroundColor = color
    }
    
    
    func changeType(type: ChangeableElementType, title: String) {
        self.setTitle(title, for: .normal)
        switch type {
        case .label:
            self.isEnabled = false
            self.titleLabel?.textColor = UIColor.CustomPalette.darkishBlue
            break
        case .button:
            self.isEnabled = true
            self.underlineText()
            self.titleLabel?.textColor = UIColor.CustomPalette.cerulean
            break
        }
    }
}

extension UIColor {
    struct CustomPalette {
        static let darkishBlue = UIColor(named: "ProfuturoDarkishBlue", in: Util.getBundle(), compatibleWith: nil)
        static let cerulean = UIColor(named: "ProfuturoCerulean", in: Util.getBundle(), compatibleWith: nil)
        static let cerulean50 = UIColor(named: "ProfuturoCerulean50", in: Util.getBundle(), compatibleWith: nil)
        static let charcoalGrey = UIColor(named: "ProfuturoCharcoalGrey", in: Util.getBundle(), compatibleWith: nil)
    }
}

extension UIView {
    public func formatView(radius: CGFloat, color: UIColor?, borderWidth: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color?.cgColor ?? UIColor.lightGray.cgColor
    }
}

extension Data {
    mutating func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        self.append(data!)
    }
}

extension UIViewController {
    
    func setBlurView() {
        let blurView = UIVisualEffectView()
        blurView.frame = view.frame
        blurView.effect = UIBlurEffect(style: .light)
        view.addSubview(blurView)
    }
    
    func removeBlurView() {
        for subview in view.subviews {
            if subview.isKind(of: UIVisualEffectView.self) {
                subview.removeFromSuperview()
            }
        }
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func configureNavigationBar() {
    
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 130, height: 20))
        imageView.contentMode = .scaleAspectFit
        
        let image = UIImage(named: "logo", in: Util.getBundle(), compatibleWith: nil)
        imageView.image = image
        
        navigationItem.titleView = imageView
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 4.0
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.4
        self.navigationController?.navigationBar.layer.masksToBounds = false
        
        let rightButton = UIBarButtonItem(title: "      ", style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = rightButton
        
        let backImage = UIImage(named: "icn_back", in: Util.getBundle(), compatibleWith: nil)
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        
    }
    
    func promptForCameraUsage() {
        DispatchQueue.main.async {
                let alertText = "Por favor permite el acceso a la cámara desde\nAjustes -> Privacidad -> Camara\npara iniciar el proceso de autenticación."
                let alertButton = "OK"
                var goAction = UIAlertAction()

                if UIApplication.shared.canOpenURL(URL(string: UIApplication.openSettingsURLString)!) {
                    goAction = UIAlertAction(title: alertButton, style: .default, handler: {(alert: UIAlertAction!) -> Void in
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                    })
                } else {
                    goAction = UIAlertAction(title: alertButton, style: .default, handler: nil)
                }

                let alert = UIAlertController(title: "Acceso a la cámara denegado", message: alertText, preferredStyle: .alert)
                alert.addAction(goAction)
                self.present(alert, animated: true, completion: nil)
        }
    }
    
    func promptNoPassport() {
        DispatchQueue.main.async {
                let alertText = "Este proceso no tiene permitido el uso de pasaporte"
                let alertButton = "OK"
            
            let alert = UIAlertController(title: "", message: alertText, preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: alertButton, style: .default, handler: nil))

            self.present(alert, animated: true, completion:  nil)
        }
    }
}
