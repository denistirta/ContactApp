//
//  HomeController.swift
//  ContactApp
//
//  Created by Denis Tirta Prada on 11/2/17.
//  Copyright © 2017 Mediatechindo.Denis. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class HomeController: UIViewController, UITableViewDataSource, UITableViewDelegate, HeaderHomeDelegate, ContactListDelegate {
    
    var header = HeaderHome()
    var table = UITableView()
    var data = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        createView()
        
    }
    
    func createView(){
        
        header = Bundle.main.loadNibNamed("HeaderHome", owner: nil, options: nil)?.first as! HeaderHome
        header.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 80)
        header.title.text = "Contact"
        header.delegate = self
        self.view.addSubview(header)
        
        // Create Table
        table.frame = CGRect(x: 0, y: 80, width: self.view.frame.size.width, height: self.view.frame.size.height-80)
        table.delegate = self;
        table.dataSource = self;
        table.backgroundColor = UIColor.init(red: 54/255, green: 54/255, blue: 54/255, alpha: 1)
        table.separatorColor = UIColor.clear
        table.allowsSelection = false
        
        table.register(UINib(nibName: "ContactList", bundle: nil), forCellReuseIdentifier: "ContactList")
        self.view .addSubview(table)
        
    }
    
    func getData(){
        Function.loadingShow(targetVC: self)
        loading.start()

        print(Contact())
        
        Alamofire.request("\(Contact())")
            .responseJSON { response in
                switch response.result{
                case .success( _):
                    
                    let jsonResult = JSON(response.result.value!)
                    if !(jsonResult["error"].boolValue){
                        
                        for i in 0..<jsonResult.count{
                            self.data.add(jsonResult[i])
                        }
                        
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
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactList", for: indexPath) as! ContactList
        
        let json = self.data[indexPath.row] as! JSON
        cell.name.text = "\(json["first_name"]) \(json["last_name"])"
        
        cell.index = indexPath
        cell.delegate = self
        return cell
    }
    
    //HeaderHomeDelegate
    func groups() {
        
    }
    
    func add() {
        
    }
    //end
    
    //ContactListDelegate
    func pushCell(index: IndexPath) {
        
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
