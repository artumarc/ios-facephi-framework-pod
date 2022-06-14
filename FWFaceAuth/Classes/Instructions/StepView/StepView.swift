//
//  StepView.swift
//  FWFaceAuth
//
//  Created by Grecia Escárcega on 15/01/20.
//  Copyright © 2020 Grecia Escárcega. All rights reserved.
//

import UIKit

@IBDesignable
class StepView: UIView {
    
    @IBOutlet weak var stepIconImageView: UIImageView!
    @IBOutlet weak var stepNumberLabel: UILabel!
    @IBOutlet weak var stepLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib()
    }
    
    func loadFromNib() {
        let nib = UINib(nibName: "StepView", bundle: Util.getBundle())
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
      override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
