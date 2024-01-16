import UIKit

/*
    Dispatch Barrier: A dispatch barrier allows us to create a synchronization point within a concurrent dispatch queue. 
*/
class PhoneStocks {
    
    var stocks : Array<String> = ["iPhone 11", "iPhone 12", "iPhone 13"]
    
    let barrier = DispatchQueue(label: "Barrier")
    
    func getAvailableStock() {
        
        barrier.sync {
            print("Available Stock : \(stocks)")
        }
        
    }
    
    func purchase(phone: String) {
        
        barrier.async(flags: .barrier) {
            guard let index = self.stocks.firstIndex(of: phone) else {
                print("No sunch phone in stock")
                return
            }
            
            self.stocks.remove(at: index)
            
            print("Congralutions on purshase of a new \(phone)")
        }
    }
}


let objPhoneStocks = PhoneStocks()

let queue = DispatchQueue(label: "PhoneStock", attributes: .concurrent)

queue.async {
    objPhoneStocks.purchase(phone: "iPhone 11")
}

queue.async {
    objPhoneStocks.getAvailableStock()
}



