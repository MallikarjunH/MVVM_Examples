//
//  PostViewModel.swift
//  Example1
//
//  Created by Mallikarjun H on 02/02/24.
//

import Foundation


// ViewModel
class PostViewModel {
    var posts: [Post] = []
    
    func callAPI(apiUrl: String, params: [String: Any], completion: @escaping (_ statusCode: Int, _ isSuccess: Bool, _ msgValue: String, _ errorValue: Error?, _ result:Data?) -> Void) {
            
            APIManager.shared.getAPICallMethod(apiUrl: apiUrl, params: params) { statusCode, isSuccess, msgValue, error, result in
                
                do {
                    self.posts = try JSONDecoder().decode([Post].self, from: result!)
                } catch {
                    print("Error decoding data: \(error)")
                }
                
                // Handle API response in the completion closure
                completion(statusCode, isSuccess, msgValue, error, result)
            }
        }
    
    //way 1, 2
    /*
    func fetchPosts(completion: @escaping () -> Void) {
        
        //way 2
        APIManager.shared.getAPICallMethod(apiUrl: "https://jsonplaceholder.typicode.com/posts", params: [:]) { statusCode, isSuccess, msgValue, errorValue, result in
        
            do {
                self.posts = try JSONDecoder().decode([Post].self, from: result!)
                DispatchQueue.main.async {
                    completion()
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }
            
        //Way 1
        /*
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching posts: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                self.posts = try JSONDecoder().decode([Post].self, from: data)
                DispatchQueue.main.async {
                    completion()
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
        */
    }
    */
}
