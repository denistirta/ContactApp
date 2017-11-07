//
//  FieldAdd.swift
//  ContactApp
//
//  Created by denis tirta on 11/4/17.
//  Copyright © 2017 denis tirta. All rights reserved.
//

import UIKit

protocol FieldAddDelegate {
    func didChangeTextField(text: UITextField)
}

class FieldAdd: UITableViewCell, UITextFieldDelegate {
    
    var delegate: FieldAddDelegate?
    
    @IBOutlet var title: UILabel!
    @IBOutlet var value: UITextField!
    
//    @IBOutlet weak var first: UITextField!
//    @IBOutlet weak var last: UITextField!
//    @IBOutlet weak var mobile: UITextField!
//    @IBOutlet weak var email: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        value.delegate = self
        value.addTarget(self, action: #selector(textfieldDidCHange(_:)), for: .editingChanged)

        value.layer.borderColor = UIColor.white .cgColor
        value.layer.borderWidth = 5
        value.clipsToBounds = true
        
//        first.delegate = self
//        last.delegate = self
//        mobile.delegate = self
//        email.delegate = self
        
//        first.layer.borderColor = UIColor.white.cgColor
//        first.layer.borderWidth = 5
//        first.clipsToBounds = true
//
//        last.layer.borderColor = UIColor.white.cgColor
//        last.layer.borderWidth = 5
//        last.clipsToBounds = true
//
//        mobile.layer.borderColor = UIColor.white.cgColor
//        mobile.layer.borderWidth = 5
//        mobile.clipsToBounds = true
//
//        email.layer.borderColor = UIColor.white.cgColor
//        email.layer.borderWidth = 5
//        email.clipsToBounds = true
//
//        first.tag = 1
//        last.tag = 2
//        mobile.tag = 3
//        email.tag = 4
        
//        first.addTarget(self, action: #selector(textfieldDidCHange(_:)), for: .editingChanged)
//        last.addTarget(self, action: #selector(textfieldDidCHange(_:)), for: .editingChanged)
//        mobile.addTarget(self, action: #selector(textfieldDidCHange(_:)), for: .editingChanged)
//        email.addTarget(self, action: #selector(textfieldDidCHange(_:)), for: .editingChanged)

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        value.resignFirstResponder()
        return true
    }

    func textfieldDidCHange(_ textField: UITextField){
        delegate?.didChangeTextField(text:textField)
    }
    
}
