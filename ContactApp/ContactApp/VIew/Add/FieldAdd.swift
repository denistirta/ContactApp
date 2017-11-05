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
    func send()
}

class FieldAdd: UITableViewCell, UITextFieldDelegate {
    
    var delegate: FieldAddDelegate?
    
    @IBOutlet weak var first: UITextField!
    @IBOutlet weak var last: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var email: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        first.delegate = self
        last.delegate = self
        mobile.delegate = self
        email.delegate = self
        
        first.tag = 1
        last.tag = 2
        mobile.tag = 3
        email.tag = 4
        
        first.addTarget(self, action: #selector(textfieldDidCHange(_:)), for: .editingChanged)
        last.addTarget(self, action: #selector(textfieldDidCHange(_:)), for: .editingChanged)
        mobile.addTarget(self, action: #selector(textfieldDidCHange(_:)), for: .editingChanged)
        email.addTarget(self, action: #selector(textfieldDidCHange(_:)), for: .editingChanged)

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case first:
            last.becomeFirstResponder()
        case last:
            mobile.becomeFirstResponder()
        case mobile:
            email.becomeFirstResponder()
        case email:
            email.resignFirstResponder()
            delegate?.send()
        default:
            textField.becomeFirstResponder()
        }
        return true
    }

    func textfieldDidCHange(_ textField: UITextField){
        delegate?.didChangeTextField(text:textField)
    }
    
}
