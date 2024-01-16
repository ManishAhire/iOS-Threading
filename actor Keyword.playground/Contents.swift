import UIKit

/*
    actor Keyword: It is used to handle data race in a concurrent enviornment.
    
    Data Race: Multiple threads access shared resource or shared memory location in concurrent environment, without any locks or checks
*/

actor PhoneStocks {
    
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


let objPhoneStocks = PhoneStocks()

let queue = DispatchQueue(label: "PhoneStock", attributes: .concurrent)

queue.async {
    
    Task.detached {
        await objPhoneStocks.purchase(phone: "iPhone 11")
    }
}

queue.async {
    
    Task.detached {
        await objPhoneStocks.getAvailableStock()
    }
}



