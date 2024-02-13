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
    
    func fetchPosts(completion: @escaping () -> Void) {
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
    }
}
