//
//  ViewController.swift
//  actor Keyword
//
//  Created by Manish on 16/01/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let objPhoneStocks = PhoneStocks()
        
        let queue = DispatchQueue(label: "PhoneStocks", attributes: .concurrent)
        
        queue.async {
            objPhoneStocks.purchase(phone: "iPhone 11")
        }
        
        queue.async {
            objPhoneStocks.getAvailableStock()
        }
    }


}

