//
//  AddContact.swift
//  ContactApp
//
//  Created by denis tirta on 11/4/17.
//  Copyright © 2017 denis tirta. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class AddContact: UIViewController, UITableViewDelegate, UITableViewDataSource, HeaderAddDelegate, PhotoAddDelegate, FieldAddDelegate {
    
    var header = HeaderAdd()
    var table = UITableView()
    var data = NSMutableArray()
    
    var edit = Bool()
    
    var id = String()
    var first = String()
    var last = String()
    var mobile = String()
    var email = String()
    var img = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        createView()
    }
    
    func createView(){
        self.view.backgroundColor = UIColor.white
        
        header = Bundle.main.loadNibNamed("HeaderAdd", owner: nil, options: nil)?.first as! HeaderAdd
        header.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 80)
        header.delegate = self
        self.view.addSubview(header)
        
        // Create Table
        table.frame = CGRect(x: 0, y: 80, width: self.view.frame.size.width, height: self.view.frame.size.height-80)
        table.delegate = self;
        table.dataSource = self;
        table.backgroundColor = UIColor.white
        table.separatorColor = UIColor.groupTableViewBackground
        table.allowsSelection = false
        
        table.register(UINib(nibName: "PhotoAdd", bundle: nil), forCellReuseIdentifier: "PhotoAdd")
        table.register(UINib(nibName: "FieldAdd", bundle: nil), forCellReuseIdentifier: "FieldAdd")

        self.view .addSubview(table)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 200
        case 1:
            return 150
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoAdd", for: indexPath) as! PhotoAdd
            
            cell.imgProfile.sd_setImage(with: URL(string: img), placeholderImage: UIImage(named: "PlaceholderProfile"), options: SDWebImageOptions.refreshCached)
            
            cell.delegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FieldAdd", for: indexPath) as! FieldAdd
            
            cell.first.text = first
            cell.last.text = last
            cell.mobile.text = mobile
            cell.email.text = email
            
            cell.delegate = self
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
    
    //HeaderAddDelegate
    func Cancel() {
        navigationController?.popViewController(animated: true)
    }
    
    func Done() {
        // save
    }
    //end
    
    //PhotoAddDelegate
    func takePicture() {
        
    }
    //end
    
    //FieldAddDelegate
    func didChangeTextField(text: UITextField) {
        switch text.tag {
        case 0:
            first = text.text!
        case 0:
            first = text.text!
        case 0:
            first = text.text!
        case 0:
            first = text.text!
        default:
            break
        }
        
    }
    
    func send() {
        
    }
    //end
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
}
