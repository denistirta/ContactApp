//
//  Function.swift
//  ContactApp
//
//  Created by denis tirta on 11/4/17.
//  Copyright © 2017 denis tirta. All rights reserved.
//

import UIKit

var loading = AASquaresLoading()

class Function {

    static func loadingShow(targetVC: UIViewController){
        loading = AASquaresLoading(target: targetVC.view, size: 40)
        loading.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        loading.color = UIColor.white
    }
    
    static func AlertMessage(title: String, message: String, targetVC: UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        targetVC.present(alert, animated: true, completion: nil)
    }
    
    static func createGradientLayer(color1: UIColor, color2: UIColor, view: UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        view.layer.addSublayer(gradientLayer)
    }
    
}
