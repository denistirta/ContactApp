//
//  PhotoAdd.swift
//  ContactApp
//
//  Created by denis tirta on 11/4/17.
//  Copyright © 2017 denis tirta. All rights reserved.
//

import UIKit

protocol PhotoAddDelegate {
    func takePicture()
}

class PhotoAdd: UITableViewCell {
    
    var delegate: PhotoAddDelegate?
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet var bg: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        Function.createGradientLayer(color1: UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), color2: UIColor.init(red: 80/255, green: 227/255, blue: 194/255, alpha: 28), view: bg)
        
        imgProfile.layer.cornerRadius = imgProfile.frame.size.width/2
        imgProfile.clipsToBounds = true
        
        btnCamera.layer.cornerRadius = btnCamera.frame.size.width/2
        btnCamera.clipsToBounds = true
        
    }
    
    @IBAction func pushBtnCamera(_ sender: Any) {
        delegate?.takePicture()
    }
    
}
