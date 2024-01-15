import UIKit

/*
 
    Serial API Call : Call one API once we got response of it then call second API.
                      Using Dispatch Group we can handle this dependency
 
*/

struct HTTPUtility {
    
    func getData(from url: URL, completion: @escaping(Data?) -> Void ) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            completion(data)
        }.resume()
    }
}

let httpUtility = HTTPUtility()

struct Employee {
    
    func getEmployeeData(completion: @escaping(Data?) -> Void) {
        
        print("Employee: API Called")
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        
        httpUtility.getData(from: url) { data in
            completion(data)
        }
    }
}

struct Project {
    
    func getProjectData(completion: @escaping(Data?) -> Void) {
        
        print("Project: API Called")
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/comments")!
        
        httpUtility.getData(from: url) { data in
            
            completion(data)
        }
    }
}

struct APIUtility {
    
    func callAPI() {
        
        let dispatchGroup = DispatchGroup()
        
        let employeeBlockOperation = BlockOperation()
        
        employeeBlockOperation.addExecutionBlock {
            
            let objEmployee = Employee()
            objEmployee.getEmployeeData() { data in
                print("Employee: Got data")
            }
        }
        
        
        let projectBlockOperation = BlockOperation()
        
        projectBlockOperation.addExecutionBlock {
            
            dispatchGroup.enter()
            
            let objProject = Project()
            objProject.getProjectData() { data in
                print("Project: Got Data")
                
                dispatchGroup.leave()
            }
            
            dispatchGroup.wait() // Here the magic happen
        }
        
        
        employeeBlockOperation.addDependency(projectBlockOperation)
        
        let operationQueue = OperationQueue()
        operationQueue.addOperation(employeeBlockOperation)
        operationQueue.addOperation(projectBlockOperation)
    }
}

let obj = APIUtility()
obj.callAPI()
