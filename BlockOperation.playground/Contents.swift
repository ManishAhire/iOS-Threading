import UIKit

/*

    Block Operation: It is a subclass of Operation Class. It manages the concurrent execution of one or more blocks.
*/

struct Demo {
    
    func doOperations() {
        
        let blockOperation = BlockOperation()
        
        blockOperation.addExecutionBlock {
            print("Operation - 1")
        }
        
        blockOperation.addExecutionBlock {
            print("Operation - 2")
        }
        
        blockOperation.addExecutionBlock {
            print("Operation - 3")
        }
        
        blockOperation.start()
    }
}

let objDemo = Demo()
objDemo.doOperations()
