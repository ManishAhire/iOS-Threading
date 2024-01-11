import UIKit

/*
    DispatchGroup : It is used to complete group of task.
                    It is also use as an alternative of nested closures.
 */

struct ImageURL {
    let imgURL1 = URL(string: "https://picsum.photos/200")!
    let imgURL2 = URL(string: "https://picsum.photos/400")!
}

let imgURL = ImageURL()

func doMultipleWork() {
    
    let dispatchGroup = DispatchGroup()
    
    // Task 1
    dispatchGroup.enter()
    
    for i in 1...10 {
        print("Value of i: \(i)")
    }
    
    dispatchGroup.leave()
    
    // Task 2
    dispatchGroup.enter()
    downloadImage(from: imgURL.imgURL1) { imgData in
        
        _ = UIImage(data: imgData)
        print("Task 2: Image Downloaded")
        dispatchGroup.leave()
    }
    
    
    // Task 3
    dispatchGroup.enter()
    
    downloadImage(from: imgURL.imgURL2) { imgData in
        _ = UIImage(data: imgData)
        print("Task 3: Image Downloaded")
        dispatchGroup.leave()
    }
    
    dispatchGroup.notify(queue: .main) {
        print("All task completed")
    }
}

func downloadImage(from url: URL, completionHandler: @escaping((Data) -> Void)) {
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        
        if error == nil {
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                
                completionHandler(data!)
            }         
            
        } else {
            print("Got an error \(String(describing: error?.localizedDescription))")
        }
    }.resume()
}

doMultipleWork()
