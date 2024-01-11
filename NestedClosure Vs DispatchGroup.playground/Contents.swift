import UIKit

struct Demo {
    
    func callAPIA( completion: @escaping(String) ->  Void) {
        
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) {
            
            completion("Response of API A")
        }
    }
    
    func callAPIB( completion: @escaping((String) -> Void)) {
        
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(2), execute: {
            completion("Response of API B")
        })
    }
    
    func callAPIC( completion: @escaping((String) -> Void)) {
        
        
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(3), execute: {
            completion("Response of API C")
        })
    }
    
    func callNestedClosure() {
        
        var data : [String] = []
        
        let startTime = Date()
        
        callAPIA { responseFromA in
            
            callAPIB { responseFromB in
                
                callAPIC { responseFromC in
                    
                    data.append(responseFromA)
                    data.append(responseFromB)
                    data.append(responseFromC)
                    
                    print("Nested Closure : API Data: \(data)")
                    print("Time taken by Nested Closures : \(Date().timeIntervalSince(startTime))")
                }
            }
        }
    }
    
    func callDispatchGroup() {
        
        var data : [String] = []
        let dispatchgroup = DispatchGroup()
        
        let startTime = Date()
        
        dispatchgroup.enter()
        callAPIA { responseFromA in
            data.append(responseFromA)
            dispatchgroup.leave()
        }
        
        
        dispatchgroup.enter()
        callAPIB { responseFromB in
            data.append(responseFromB)
            dispatchgroup.leave()
        }
        
        dispatchgroup.enter()
        callAPIC { responseFromC in
            data.append(responseFromC)
            dispatchgroup.leave()
        }
        
        
        dispatchgroup.notify(queue: .main) {
            print("Dispatch Group : API Data : \(data)")
            print("Time taken by Dispatch Group: \(Date().timeIntervalSince(startTime))")
        }
    }
}

let objDemo = Demo()
objDemo.callNestedClosure()
objDemo.callDispatchGroup()


