//
//  CustomCheckBox.swift
//  TestATASKApp
//
//  Created by Jeri Purnama on 20/06/23.
//

import UIKit

class CustomCheckbox: UIControl {
    var isChecked: Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    
        let context = UIGraphicsGetCurrentContext()
        
        context?.setStrokeColor(UIColor.lightGray.cgColor)
        context?.setLineWidth(2.0)
        
        context?.addEllipse(in: rect.insetBy(dx: 2, dy: 2))
        context?.strokePath()
        
        if isChecked {
            context?.setFillColor(UIColor.black.cgColor)
            context?.addEllipse(in: rect.insetBy(dx: rect.width * 0.25, dy: rect.height * 0.25))
            context?.fillPath()
        } else {
            context?.setFillColor(UIColor.white.cgColor)
            context?.addEllipse(in: rect.insetBy(dx: rect.width * 0.25, dy: rect.height * 0.25))
            context?.fillPath()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isChecked = !isChecked
        sendActions(for: .valueChanged)
    }
}
