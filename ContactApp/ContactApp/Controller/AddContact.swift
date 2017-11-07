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
import Fusuma

class AddContact: UIViewController, UITableViewDelegate, UITableViewDataSource, HeaderAddDelegate, PhotoAddDelegate, FieldAddDelegate, FusumaDelegate {
    
    var header = HeaderAdd()
    var headerImg = PhotoAdd()
    var table = UITableView()
   
    var data = NSArray()
    var dataList = NSArray()
    var edit = Bool()
    
    var imgEdit = Bool()
    var imageProfile = UIImage()
    var fusuma = FusumaViewController()

    var id = String()
    var first = String()
    var last = String()
    var mobile = String()
    var email = String()
    var img = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = [first, last, mobile, email]
        dataList = ["First Name", "Last Name", "Mobile", "Email"]
        createView()
    }
    
    func createView(){
        self.view.backgroundColor = UIColor.white
        
        header = Bundle.main.loadNibNamed("HeaderAdd", owner: nil, options: nil)?.first as! HeaderAdd
        header.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 60)
        header.delegate = self
        self.view.addSubview(header)
        
        // Create Table
        table.frame = CGRect(x: 0, y: 60, width: self.view.frame.size.width, height: self.view.frame.size.height-60)
        table.delegate = self;
        table.dataSource = self;
        table.backgroundColor = UIColor.white
        table.separatorColor = UIColor.init(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        table.allowsSelection = false
        
        table.register(UINib(nibName: "PhotoAdd", bundle: nil), forCellReuseIdentifier: "PhotoAdd")
        table.register(UINib(nibName: "FieldAdd", bundle: nil), forCellReuseIdentifier: "FieldAdd")
        self.view .addSubview(table)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 200
        }else{
            return 56
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoAdd", for: indexPath) as! PhotoAdd
            
            if imgEdit{
                cell.imgProfile.image = imageProfile
            }else{
                cell.imgProfile.sd_setImage(with: URL(string: img), placeholderImage: UIImage(named: "PlaceholderProfile"), options: SDWebImageOptions.refreshCached)
            }
            
            cell.backgroundColor = UIColor.clear
            cell.delegate = self
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FieldAdd", for: indexPath) as! FieldAdd
            
            cell.title.text = "\(dataList[indexPath.row-1])"
            
            cell.value.placeholder = "\(dataList[indexPath.row-1])"
            cell.value.text = "\(data[indexPath.row-1])"
            
            if indexPath.row-1 == 2{
                cell.value.keyboardType = .numberPad
            }else if indexPath.row-1 == 3{
                cell.value.keyboardType = .emailAddress
            }
            
            cell.backgroundColor = UIColor.clear
            cell.delegate = self
            return cell
        }
    }
    
    //HeaderAddDelegate
    func Cancel() {
        navigationController?.popViewController(animated: true)
    }
    
    func Done() {
        // save
        Function.loadingShow(targetVC: self)
        loading.start()
        
        var toParam = String()
        if edit{
            toParam = Contact()
        }else{
            toParam = ContactID(id: id)
        }
        
        let param : [String: String] = [
            "first_name" : first,
            "last_name" : last,
            "phone_number" : mobile,
            "email" : email
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in param {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
            
//            if self.imgEdit{
//                multipartFormData.append(UIImagePNGRepresentation(self.imageProfile)!, withName: "profile_pic", fileName: "profile_pic", mimeType: "image/jpeg")
//            }
        
        }, to: toParam, headers: headersAuth)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    print(response.result)
//                    let jsonResult = JSON(response.result.value!)
//                    if !(jsonResult["error"]).boolValue{
                    
                        
//                    }else{
                        loading.stop()
//                    }
                }
            case .failure(let error):
                loading.stop()
                print("Error \(error.localizedDescription)")
            }
        }
        
    }
    //end
    
    //PhotoAddDelegate
    func takePicture() {
        fusuma.delegate = self
        fusuma.cropHeightRatio = 1.0
        fusumaTintColor = UIColor.white
        fusumaBackgroundColor = UIColor.init(red: 27/255.0, green: 58/255.0, blue: 109/255.0, alpha: 1.0)
        self.present(fusuma, animated: true, completion: nil)
    }
    //end
    
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
        imageProfile = image
    }
    
    func fusumaVideoCompleted(withFileURL fileURL: URL) {
        // not use video
    }
    
    func fusumaCameraRollUnauthorized() {
        print("Camera roll unauthorized")
        
        let alert = UIAlertController(title: "Access Requested",
                                      message: "Saving image needs to access your photo album",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Settings", style: .default) { (action) -> Void in
            
            if let url = URL(string:UIApplicationOpenSettingsURLString) {
                
                UIApplication.shared.openURL(url)
            }
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            
        })
        
        guard let vc = UIApplication.shared.delegate?.window??.rootViewController,
            let presented = vc.presentedViewController else {
                
                return
        }
        
        presented.present(alert, animated: true, completion: nil)
    }
    func fusumaDismissedWithImage(_ image: UIImage, source: FusumaMode) {
        imgEdit = true
        table.reloadData()
    }
    
    //FieldAddDelegate
    func didChangeTextField(text: UITextField) {
        switch text.tag {
        case 0:
            first = text.text!
            print(first)
        case 1:
            last = text.text!
            print(last)
        case 2:
            mobile = text.text!
            print(mobile)
        case 3:
            email = text.text!
            print(email)
        default:
            break
        }
    }
    //end
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true

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
