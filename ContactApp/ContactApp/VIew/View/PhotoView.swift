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

class PhotoView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, MenuCellDelegete {
    
    var delegate: PhotoViewDelegate?
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var menu: UICollectionView!
    @IBOutlet var bg: UIView!
    var dataMenu = NSArray()
    var favourite = Bool()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dataMenu = ["message", "call", "email", "favourite"]
        
        Function.createGradientLayer(color1: UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), color2: UIColor.init(red: 80/255, green: 227/255, blue: 194/255, alpha: 28), view: bg)
    
        img.layer.cornerRadius = img.frame.size.width/2
        img.layer.borderColor = UIColor.white .cgColor
        img.layer.borderWidth = 3
        img.clipsToBounds = true

        menu.delegate = self
        menu.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width/5, height: 70)
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
        cell.imgBtn.setImage(UIImage(named:"\(dataMenu[indexPath.row])"), for: .normal)
        
        if indexPath.row == 3{
            if favourite{
                cell.imgBtn.setImage(UIImage(named:"\(dataMenu[indexPath.row])"), for: .normal)
                cell.imgBtn.backgroundColor = UIColor.white
            }else{
                cell.imgBtn.setImage(UIImage(named:"star"), for: .normal)
                cell.imgBtn.backgroundColor = UIColor.init(red: 80/255, green: 227/255, blue: 194/255, alpha: 1)
            }
        }
        
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
