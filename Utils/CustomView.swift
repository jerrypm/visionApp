//
//  CustomView.swift
//  TestATASKApp
//
//  Created by Jeri Purnama on 20/06/23.
//

import UIKit

class CustomView: UIView {
    let checkbox1 = CustomCheckbox()
    let checkbox2 = CustomCheckbox()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        layer.borderWidth = 2
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        layer.cornerRadius = 10
        backgroundColor = .white
        
        let label1 = UILabel(frame: CGRect(x: 20, y: 20, width: frame.width - 70, height: 30))
        label1.text = "User file storage"
        label1.textAlignment = .left
        addSubview(label1)
        
        let label2 = UILabel(frame: CGRect(x: 20, y: 60, width: frame.width - 70, height: 30))
        label2.text = "User database storage"
        label2.textAlignment = .left
        addSubview(label2)
        
        checkbox1.frame = CGRect(x: frame.width - 50, y: 20, width: 30, height: 30)
        checkbox1.backgroundColor = .white
        checkbox2.frame = CGRect(x: frame.width - 50, y: 60, width: 30, height: 30)
        checkbox2.backgroundColor = .white
        
        checkbox1.addTarget(self, action: #selector(checkboxChanged(_:)), for: .valueChanged)
        checkbox2.addTarget(self, action: #selector(checkboxChanged(_:)), for: .valueChanged)
        
        addSubview(checkbox1)
        addSubview(checkbox2)
        
        checkbox1.isChecked = true
    }
    
    @objc func checkboxChanged(_ sender: CustomCheckbox) {
        if sender == checkbox1 {
            checkbox1.isChecked = true
            checkbox2.isChecked = false
        } else if sender == checkbox2 {
            checkbox2.isChecked = true
            checkbox1.isChecked = false
        }
        
    }
}
