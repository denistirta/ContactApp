//
//  Server.swift
//  ContactApp
//
//  Created by Denis Tirta Prada on 11/2/17.
//  Copyright © 2017 Mediatechindo.Denis. All rights reserved.
//

import UIKit

let headersAuth = [
    "key": "Content-Type",
    "value": "application/json",
    "description": ""
]

public enum Base: String {
    case baseGlobal   = "http://gojek-contacts-app.herokuapp.com"
}

func Contact() -> String{
    let contact = "\(Base.baseGlobal.rawValue)/contacts.json"
    return contact
}

func ContactID(id: String) -> String{
    let contactid = "\(Base.baseGlobal.rawValue)/contacts/\(id).json"
    return contactid
}
