import UIKit

/*
    Operation Dependency : One task is depedent on another task.
*/

struct Employee {
    
    func syncOfflineEmployeeRecords() {
        
        print("Employee : Sync Started")
        
        Thread.sleep(forTimeInterval: 2)
        
        print("Employee : Sync Completed")
    }
}

struct Department {
    
    func syncOfflineDepartmentRecords() {
        
        print("Department : Sync Started")
        
        Thread.sleep(forTimeInterval: 2)
        
        print("Department : Sync Completed")
    }
}

struct sycnRecords {
    
    func syncOfflineRecordsWithServer() {
        
        //MARK: Employee Block Operation
        let employeeBlockOperation = BlockOperation()
        
        employeeBlockOperation.addExecutionBlock {
            
            let objEmployee = Employee()
            objEmployee.syncOfflineEmployeeRecords()
        }
        
        //MARK: Department Block Operation
        let departmentBlockOperation = BlockOperation()
        
        departmentBlockOperation.addExecutionBlock {
            
            let objDepartment = Department()
            objDepartment.syncOfflineDepartmentRecords()
        }
        
        //MARK: Another Block Operation
        let anotherBlockOperation = BlockOperation()
        
        anotherBlockOperation.addExecutionBlock {
            
            let objDepartment = Department()
            objDepartment.syncOfflineDepartmentRecords()
        }
        
        
        // Added Dependency : Department is depended on employee. Employee Oprtion finishes first then Department start executing
        departmentBlockOperation.addDependency(employeeBlockOperation)
        
        
        let operationQueue = OperationQueue()
        operationQueue.addOperation(employeeBlockOperation)
        operationQueue.addOperation(departmentBlockOperation)
        
        
        // Invokes a block when the queue finishes all enqueued operations, and prevents subsequent operations from starting until the block has completed.
        operationQueue.addBarrierBlock {
            print("Completed All Operation")
        }
        
        // This will execute after the all the above operation finishes
        operationQueue.addOperation(anotherBlockOperation)
        
    }
}

let objSyncRecord = sycnRecords()
objSyncRecord.syncOfflineRecordsWithServer()
