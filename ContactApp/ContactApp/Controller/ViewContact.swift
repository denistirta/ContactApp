//
//  ViewContact.swift
//  ContactApp
//
//  Created by denis tirta on 11/4/17.
//  Copyright © 2017 denis tirta. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewContact: UIViewController, UITableViewDelegate, UITableViewDataSource, HeaderAddDelegate, PhotoViewDelegate {
    
    var header = HeaderAdd()
    var table = UITableView()
    var data = NSMutableArray()
    var id = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        createView()
    }
    
    func createView(){
        self.view.backgroundColor = UIColor.white
        
        header = Bundle.main.loadNibNamed("HeaderAdd", owner: nil, options: nil)?.first as! HeaderAdd
        header.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 80)
        header.btnCancel.setTitle("< Contact", for: .normal)
        header.btnDone.setTitle("Edit", for: .normal)
        header.delegate = self
        self.view.addSubview(header)
        
        // Create Table
        table.frame = CGRect(x: 0, y: 80, width: self.view.frame.size.width, height: self.view.frame.size.height-80)
        table.delegate = self;
        table.dataSource = self;
        table.backgroundColor = UIColor.white
        table.separatorColor = UIColor.clear
        table.allowsSelection = false
        
        table.register(UINib(nibName: "PhotoView", bundle: nil), forCellReuseIdentifier: "PhotoView")
        table.register(UINib(nibName: "FieldView", bundle: nil), forCellReuseIdentifier: "FieldView")
        
        self.view .addSubview(table)
        
    }
    
    func getData(){
        Function.loadingShow(targetVC: self)
        loading.start()
        
        print("\(ContactID(id: id))")
        
        Alamofire.request("\(ContactID(id: id))")
            .responseJSON { response in
                switch response.result{
                case .success( _):
                    
                    let jsonResult = JSON(response.result.value!)
                    print(jsonResult)
                    if !(jsonResult["error"].boolValue){
                        
                        self.data.add(jsonResult)
                        self.table.reloadData()
                        
                        
                    }else{
                        
                    }
                case .failure(let error) :
                    print(error)
                }
                loading.stop()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.data.count > 0{
            return 2
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 250
        case 1:
            return 90
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoView", for: indexPath) as! PhotoView
            
            let json = self.data[0] as! JSON
            cell.img.sd_setImage(with: URL(string: "\(json["profile_pic"])"), placeholderImage: UIImage(named: "PlaceholderProfile"), options: SDWebImageOptions.refreshCached)
            cell.name.text = "\(json["first_name"]) \(json["last_name"])"
            cell.delegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FieldView", for: indexPath) as! FieldView
            
            let json = self.data[0] as! JSON
            cell.mobile.text = "\(json["phone_number"])"
            cell.email.text = "\(json["email"])"
            
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
        // function edit
        let json = self.data[0] as! JSON
        
        let story = UIStoryboard(name: "Main", bundle: nil)
        let controll = story.instantiateViewController(withIdentifier: "AddContact") as! AddContact
        controll.edit = true
        controll.id = id
        controll.first = "\(json["first_name"])"
        controll.last = "\(json["last_name"])"
        controll.mobile = "\(json["phone_number"])"
        controll.email = "\(json["email"])"
        controll.img = "\(json["profile_pic"])"
        navigationController?.pushViewController(controll, animated: true)
    }
    //end
    
    //PhotoViewDelegate
    func menu(index: IndexPath) {
        let json = self.data[0] as! JSON
        print("\(json["phone_number"])")
        switch index.row {
        case 0:
            message(no: "\(json["phone_number"])")
        case 1:
            call(no: "\(json["phone_number"])")
        case 2:
            email(email: "\(json["email"])")
        case 3:
            favourite()
        default:
            break
        }
    }
    //end
    
    func message(no: String){
        Function.AlertMessage(title: "\(no)", message: "", targetVC: self)
    }
    
    func call(no: String){
        Function.AlertMessage(title: "\(no)", message: "", targetVC: self)
    }
    
    func email(email: String){
        Function.AlertMessage(title: "\(email)", message: "", targetVC: self)
    }
    
    func favourite(){
        Function.AlertMessage(title: "Favourite", message: "", targetVC: self)
    }
    
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
