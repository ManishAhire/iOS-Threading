import UIKit

protocol Account {
    
    func withDraw(amount : Double) throws
}

enum WithdrawalError : Error {
    case inSufficientAccountBalance
}

var accountBalance = 50000.00

struct ATM : Account {
    
    func withDraw(amount: Double) throws {
        
        print("Inside ATM")
        
        guard accountBalance > amount else {
            
            throw WithdrawalError.inSufficientAccountBalance
        }
        
        Thread.sleep(forTimeInterval: Double.random(in: 1...3))
        
        accountBalance = accountBalance - amount
    }
    
    func printMessage() {
        print("ATM Withdrawal Successful, new account balance \(accountBalance)")
    }
}

struct Bank : Account {
    
    func withDraw(amount: Double) throws {
        
        print("Inside Bank")
        
        guard accountBalance > amount else {
            throw WithdrawalError.inSufficientAccountBalance
        }
        
        Thread.sleep(forTimeInterval: Double.random(in: 1...3))
        
        accountBalance = accountBalance - amount
    }
    
    func printMessage() {
        print("Bank Withdrawal Successful, new account balance \(accountBalance)")
    }
}


let queue = DispatchQueue(label: "semaphore", qos: .utility, attributes: .concurrent)

let semaphore = DispatchSemaphore(value: 1) // Run one thread at a time

queue.async {
    
    do {
        
        semaphore.wait()
        
        let atm = ATM()
        try atm.withDraw(amount: 30000.00)
        atm.printMessage()
        
        semaphore.signal()
        
    }
    catch WithdrawalError.inSufficientAccountBalance {
        semaphore.signal()
        
        print("ATM withdrawal failed : Insufficent Balance")
    }
    catch {
        semaphore.signal()
        print("Something went wrong")
    }
}

queue.async {
    do {
        
        semaphore.wait()
        
        let bank = Bank()
        try bank.withDraw(amount: 25000.00)
        bank.printMessage()
        
        semaphore.signal()
    }
    catch WithdrawalError.inSufficientAccountBalance {
        semaphore.signal()
        
        print("Bank withdrawal failed : Insufficent Balance")
    }
    catch {
        
        semaphore.signal() 
        print("Something went wrong")
    }
}
