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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgProfile.layer.cornerRadius = imgProfile.frame.size.width/2
        imgProfile.clipsToBounds = true
        
        btnCamera.layer.cornerRadius = btnCamera.frame.size.width/2
        btnCamera.clipsToBounds = true
        
    }
    
    @IBAction func pushBtnCamera(_ sender: Any) {
        delegate?.takePicture()
    }
    
}
