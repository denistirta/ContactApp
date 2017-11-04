//
//  HeaderHome.swift
//  ContactApp
//
//  Created by denis tirta on 11/4/17.
//  Copyright © 2017 denis tirta. All rights reserved.
//

import UIKit

protocol HeaderHomeDelegate {
    func groups()
    func add()
    
}

class HeaderHome: UIView {
    
    var delegate: HeaderHomeDelegate?
    @IBOutlet weak var btnGroups: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func pushGroups(_ sender: Any) {
        delegate?.groups()
    }
    
    @IBAction func pushAdd(_ sender: Any) {
        delegate?.add()
    }
    
}
