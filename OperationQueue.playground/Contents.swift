import UIKit

/*

    Operation Queue : The queue which is perform all the block operation which is Know as Operation Queue
 
*/

struct Demo {
    
    func doWork() {
        
        //MARK: Block Operation - 1
        let blockOperation1 = BlockOperation()
        
        blockOperation1.addExecutionBlock {
            print("Opeation1 - 1")
        }
        
        blockOperation1.addExecutionBlock {
            print("Opeation1 - 2")
        }
        
        blockOperation1.addExecutionBlock {
            print("Opeation1 - 3")
        }
        
        blockOperation1.addExecutionBlock {
            print("Opeation1 - 4")
        }
        
        blockOperation1.addExecutionBlock {
            print("Opeation1 - 5")
        }
        
        //MARK: Block Operation - 2
        let blockOperation2 = BlockOperation()
        
        blockOperation2.addExecutionBlock {
            print("Opeation2 - 6")
        }
        
        blockOperation2.addExecutionBlock {
            print("Opeation2 - 7")
        }
        
        blockOperation2.addExecutionBlock {
            print("Opeation2 - 8")
        }
        
        blockOperation2.addExecutionBlock {
            print("Opeation2 - 9")
        }
        
        blockOperation2.addExecutionBlock {
            print("Opeation2 - 10")
        }
        
        //MARK: Block Operation - 3
        let blockOperation3 = BlockOperation()
        
        blockOperation3.addExecutionBlock {
            print("Opeation3 - 6")
        }
        
        blockOperation3.addExecutionBlock {
            print("Opeation3 - 7")
        }
        
        blockOperation3.addExecutionBlock {
            print("Opeation3 - 8")
        }
        
        blockOperation3.addExecutionBlock {
            print("Opeation3 - 9")
        }
        
        blockOperation3.addExecutionBlock {
            print("Opeation3 - 10")
        }
        
        //MARK: Block Operation - 4
        let blockOperation4 = BlockOperation()
        
        blockOperation4.addExecutionBlock {
            print("Opeation4 - 6")
        }
        
        blockOperation4.addExecutionBlock {
            print("Opeation4 - 7")
        }
        
        blockOperation4.addExecutionBlock {
            print("Opeation4 - 8")
        }
        
        blockOperation4.addExecutionBlock {
            print("Opeation4 - 9")
        }
        
        blockOperation4.addExecutionBlock {
            print("Opeation4 - 10")
        }
        
//        blockOperation.start()
        
        //MARK: Operation Queue
        let operationQueue = OperationQueue()
        operationQueue.qualityOfService = .utility
//        operationQueue.maxConcurrentOperationCount = 2
        
//        operationQueue.addOperation(blockOperation)
        
        let arrBlockOperation : [BlockOperation] = [blockOperation1, blockOperation2, blockOperation3, blockOperation4]
        operationQueue.addOperations(arrBlockOperation, waitUntilFinished: false)
        
    }
}

let objDemo = Demo()
objDemo.doWork()
