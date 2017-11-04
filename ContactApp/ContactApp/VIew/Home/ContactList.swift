//
//  ContactList.swift
//  ContactApp
//
//  Created by Denis Tirta Prada on 11/2/17.
//  Copyright © 2017 Mediatechindo.Denis. All rights reserved.
//

import UIKit

protocol ContactListDelegate {
    func pushCell(index: IndexPath)
}

class ContactList: UITableViewCell {
    
    var delegate: ContactListDelegate?
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var favorite: UIImageView!
    var index = IndexPath()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        img.layer.cornerRadius = img.frame.size.width/2
        img.clipsToBounds = true
        
    }
    
    @IBAction func pushBtnCell(_ sender: Any) {
        delegate?.pushCell(index: index)
    }
    
}
