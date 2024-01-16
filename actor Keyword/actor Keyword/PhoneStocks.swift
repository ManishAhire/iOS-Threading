//
//  PhoneStocks.swift
//  actor Keyword
//
//  Created by Manish on 16/01/24.
//

import Foundation

class PhoneStocks {
    
    var stocks : Array<String> = ["iPhone 11", "iPhone 12", "iPhone 13"]
    
    func getAvailableStock() {
        print("Available Stock : \(stocks)")
    }
    
    func purchase(phone: String) {
        
        guard let index = stocks.firstIndex(of: phone) else {
            print("No sunch phone in stock")
            return
        }
        
        stocks.remove(at: index)
        
        print("Congralutions on purshase of a new \(phone)")
    }
}
