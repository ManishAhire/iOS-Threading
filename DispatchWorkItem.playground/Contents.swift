import UIKit

/*
    DispatchWorkItem: Its a block of code. The DispatchQueue will execute the that code and we can aslo cancel the block of code.
*/

func doWork() {
    
    
    let workItem = DispatchWorkItem {
        
        print("I'm doing some heavy operation")
    }
    
    let queue = DispatchQueue.global(qos: .utility)
    queue.asyncAfter(deadline: .now() + .seconds(5), execute: workItem)
    
    workItem.notify(queue: .main) {
        
        print("I'm done with my heavy opration")
    }
    
    workItem.cancel()
    
    if workItem.isCancelled {
        
        print("The task is cancelled now.")
    }
}

doWork()
