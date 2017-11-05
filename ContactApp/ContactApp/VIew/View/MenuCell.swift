//
//  MenuCell.swift
//  ContactApp
//
//  Created by denis tirta on 11/5/17.
//  Copyright © 2017 denis tirta. All rights reserved.
//

import UIKit

protocol MenuCellDelegete {
    func PushCell(index: IndexPath)
}

class MenuCell: UICollectionViewCell {
    
    var delegate: MenuCellDelegete?
    @IBOutlet weak var imgBtn: UIButton!
    @IBOutlet weak var nameMenu: UILabel!
    var index = IndexPath()
    
    @IBAction func pushCell(_ sender: Any) {
        delegate?.PushCell(index: index)
    }
    
}
