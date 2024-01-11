/*
     Race Condition: Race conditions occurs where two or more threads access shared data and modify it simultaneously, resulting in unpredictable behavior.
 
    Using NSLock(), we can avoid the race condition
*/

import UIKit

var accountBalance = 5000
let lock = NSLock()

struct Bank {
    
    let withdrawMethod : String
    
    func withdraw(amount : Int) {
        
        lock.lock()
        if accountBalance > amount {
            
            print("\(withdrawMethod) : Sufficent Balance")
            
            Thread.sleep(forTimeInterval: Double.random(in: 0...4))
            
            accountBalance = accountBalance - amount
            
            print("\(withdrawMethod) Done: \(amount) has been withdraw")
            print("Current Balance: \(accountBalance)")
            
        } else {
            
            print("\(withdrawMethod) Faild: Insufficent Balance")
            
        }
        lock.unlock()
    }
}

let queue = DispatchQueue(label: "withdrawalQueue", attributes: .concurrent)

queue.async {
    let netbanking = Bank(withdrawMethod: "Netbanking")
    netbanking.withdraw(amount: 3000)
}

queue.async {
    let atm = Bank(withdrawMethod: "ATM")
    atm.withdraw(amount: 4000)
}





