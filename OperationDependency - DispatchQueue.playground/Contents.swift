import UIKit

/*

    Serial Dispatch Queue: One task is depedent on another task.
 
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
        
        let serialQueue = DispatchQueue(label: "Records")
        
        serialQueue.async {
            
            let objEmployee = Employee()
            objEmployee.syncOfflineEmployeeRecords()
        }
        
        serialQueue.async {
            
            let objDepartment = Department()
            objDepartment.syncOfflineDepartmentRecords()
        }
    }
}

let objSyncRecord = sycnRecords()
objSyncRecord.syncOfflineRecordsWithServer()
