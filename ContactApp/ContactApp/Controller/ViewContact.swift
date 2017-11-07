//
//  ViewContact.swift
//  ContactApp
//
//  Created by denis tirta on 11/4/17.
//  Copyright © 2017 denis tirta. All rights reserved.
//

import UIKit
import MessageUI
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewContact: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate, HeaderAddDelegate, PhotoViewDelegate {
    
    var header = HeaderAdd()
    var headerImg = PhotoView()
    var table = UITableView()
    var data = NSMutableArray()
    
    var dataList = NSArray()
    var id = String()
    var img = String()
    var first = String()
    var last = String()
    var favorite = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataList = ["mobile", "email"]
        createView()
        getData()

    }
    
    func createView(){
        self.view.backgroundColor = UIColor.white
        
        header = Bundle.main.loadNibNamed("HeaderAdd", owner: nil, options: nil)?.first as! HeaderAdd
        header.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 60)
        header.btnCancel.setTitle("< Contact", for: .normal)
        header.btnDone.setTitle("Edit", for: .normal)
        header.delegate = self
        self.view.addSubview(header)
        
        headerImg = Bundle.main.loadNibNamed("PhotoView", owner: nil, options: nil)?.first as! PhotoView
        headerImg.frame = CGRect(x: 0, y: 60, width: self.view.frame.size.width, height: 250)
        headerImg.img.sd_setImage(with: URL(string: "\(img)"), placeholderImage: UIImage(named: "PlaceholderProfile"), options: SDWebImageOptions.refreshCached)
        headerImg.name.text = "\(first) \(last)"
        headerImg.favourite = favorite
        headerImg.delegate = self
        self.view.addSubview(headerImg)
        
        // Create Table
        table.frame = CGRect(x: 0, y: 310, width: self.view.frame.size.width, height: self.view.frame.size.height-310)
        table.delegate = self;
        table.dataSource = self;
        table.backgroundColor = UIColor.white
        table.separatorColor = UIColor.init(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        table.allowsSelection = false
        
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
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.data.count > 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FieldView", for: indexPath) as! FieldView
            
            cell.title.text = "\(dataList[indexPath.row])"
            let json = self.data[0] as! JSON
            
            if indexPath.row == 0{
                cell.value.text = "\(json["phone_number"])"
            }else{
                cell.value.text = "\(json["email"])"
            }
            
            cell.backgroundColor = UIColor.clear
            return cell
        }else{
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
        if MFMessageComposeViewController.canSendText(){
            let controller = MFMessageComposeViewController()
            controller.body = ""
            controller.recipients = [no]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    // MFMessageComposeViewControllerDelegate
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    // end
    
    func call(no: String){
        if let url = URL(string: "tel://\(no)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }

    }
    
    func email(email: String){
        if !MFMailComposeViewController.canSendMail() {
            Function.AlertMessage(title: "Error", message: "Mail services are not available", targetVC: self)
            return
        }
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        // Configure the fields of the interface.
        composeVC.setToRecipients(["\(email)"])
        composeVC.setSubject("")
        composeVC.setMessageBody("", isHTML: false)
        
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
    }
    
    // mailComposeDelegate
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    // end

    func favourite(){
        Function.AlertMessage(title: "Favourite", message: "", targetVC: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
}
