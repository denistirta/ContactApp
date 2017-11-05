//
//  PhotoView.swift
//  ContactApp
//
//  Created by denis tirta on 11/5/17.
//  Copyright © 2017 denis tirta. All rights reserved.
//

import UIKit

protocol PhotoViewDelegate {
    func menu(index: IndexPath)
}

class PhotoView: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, MenuCellDelegete {
    
    var delegate: PhotoViewDelegate?
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var menu: UICollectionView!
    var dataMenu = NSArray()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dataMenu = ["message", "call", "email", "favourite"]
        
        img.layer.cornerRadius = img.frame.size.width/2
        img.clipsToBounds = true
        
        menu.delegate = self
        menu.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width/5, height: 50)
        layout.scrollDirection = .horizontal
        
        menu.setCollectionViewLayout(layout, animated: true)
        menu.register(UINib(nibName: "MenuCell", bundle:nil), forCellWithReuseIdentifier: "MenuCell")
        menu.isScrollEnabled = false
        menu.allowsSelection = false
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataMenu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as! MenuCell
       
        cell.nameMenu.text = "\(dataMenu[indexPath.row])"
        
        cell.index = indexPath
        cell.delegate = self
        return cell
    }
    
    // MenuCelldelegate
    func PushCell(index: IndexPath) {
        delegate?.menu(index: index)
    }
    //end
    
}
