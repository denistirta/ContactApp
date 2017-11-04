//
//  HeaderAdd.swift
//  ContactApp
//
//  Created by denis tirta on 11/4/17.
//  Copyright © 2017 denis tirta. All rights reserved.
//

import UIKit

protocol HeaderAddDelegate {
    func Cancel()
    func Done()
}

class HeaderAdd: UIView {
    
    var delegate: HeaderAddDelegate?
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnDone: UIButton!
    
    @IBAction func pushBtnCancel(_ sender: Any) {
        delegate?.Cancel()
    }
    
    @IBAction func pushBtnDone(_ sender: Any) {
        delegate?.Done()
    }
    
}
