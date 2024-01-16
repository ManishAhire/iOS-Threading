import UIKit

enum httpError : Error {
    case nonSuccessStatusCode
}

final class HTTPUtility {
    
    static let shared : HTTPUtility = HTTPUtility()
    private init () { }
    
    func getData<T: Decodable>(from url: URL, completion: @escaping([T]) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if error == nil, let httpResponse = response as? HTTPURLResponse?, let httpStatusCode = httpResponse?.statusCode, (200...299).contains(httpStatusCode) {
                
                do {
                    let decodedResponse = try JSONDecoder().decode([T].self, from: data!)
                    completion(decodedResponse)
                    
                } catch let error {
                    dump(error.localizedDescription)
                }
                
                
            } else {
                dump(error?.localizedDescription)
            }
        }.resume()
    }
    
    func getData<T: Decodable>(from url: URL, responseType: T.Type) async throws ->  [T] {
        
        do {
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse?, let httpStatusCode = httpResponse?.statusCode, (200...299).contains(httpStatusCode) else {
                throw  httpError.nonSuccessStatusCode
            }
            
            return try JSONDecoder().decode([T].self, from: data)
            
        } catch {
            throw error
        }
    }
}


struct PostsResponse : Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

struct PostCommentsRespose : Decodable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}

//struct Posts {
//    
//    func getPost(from url: URL, completion: @escaping(([PostsResponse]) -> Void)) {
//
//        HTTPUtility.shared.getData(from: url) { posts in
//            completion(posts)
//        }
//    }
//}

struct Posts {
    
    func getPost(from url: URL) async throws -> [PostsResponse] {
        
        do {
            return try await HTTPUtility.shared.getData(from: url, responseType: PostsResponse.self)
        } catch {
            throw error
        }
        
    }
}

//struct Comments {
//    
//    func getComments(from url: URL, completion: @escaping(([PostCommentsRespose]) -> Void)) {
//        
//        HTTPUtility.shared.getData(from: url) { comments in
//            completion(comments)
//        }
//    }
//}

struct Comments {
    
    func getComments(from url: URL) async throws -> [PostCommentsRespose] {
        
        do {
            return try await HTTPUtility.shared.getData(from: url, responseType: PostCommentsRespose.self)
        } catch {
            throw error
        }
    }
}


//struct GetData {
//    
//    let postURL = URL(string: "https://jsonplaceholder.typicode.com/posts")!
//    let commentURL = URL(string: "https://jsonplaceholder.typicode.com/comments")!
//
//    func getPostsAndThenComments() {
//        
//        let objPosts = Posts()
//        
//        objPosts.getPost(from: postURL) { posts in
//            
//            print("Posts: \(posts)")
//            
//            let objComments = Comments()
//            
//            objComments.getComments(from: commentURL) { comments in
//                print("Comments: \(comments)")
//            }
//        }
//    }
//}


struct GetData {
    
    let postURL = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    let commentURL = URL(string: "https://jsonplaceholder.typicode.com/comments")!

    func getPostsAndThenComments() {
        
        Task {
            
            do {
                
                let objPosts = Posts()
                let posts = try await objPosts.getPost(from: postURL)
                print("Posts: \(posts)")
                
                let objComments = Comments()
                let comments = try await objComments.getComments(from: commentURL)
                print("Comments: \(comments)")
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}


let objGetData = GetData()
objGetData.getPostsAndThenComments()

