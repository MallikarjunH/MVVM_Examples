//
//  PostViewController.swift
//  Example1
//
//  Created by Mallikarjun H on 02/02/24.
//

import UIKit

class PostViewController: UIViewController {
    
    @IBOutlet weak var sampleTableView: UITableView!
    
    var viewModel = PostViewModel()
    
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MVVM Example 1"
        
        // Register the cell class for the "PostCell" identifier
        //sampleTableView.register(UITableViewCell.self, forCellReuseIdentifier: "PostCell") //for default cell, without using custom tableviewcell
        
        sampleTableView.dataSource = self
        
        // set up activity indicator
        activityIndicator.center = CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
        activityIndicator.color = UIColor.black
        self.view.addSubview(activityIndicator)
        self.activityIndicator.startAnimating()
        
        // Fetch posts
        viewModel.fetchPosts {
            self.sampleTableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
}

extension PostViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)  //for default cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        
        let post = viewModel.posts[indexPath.row]
        cell.titleLabel.text = "Title: " + post.title
        cell.bodyLabel.text = "Body: " + post.body
        
        return cell
    }
}


/*
 Explanation:
 
 Model (Post): Represents a post obtained from the API. It conforms to the Codable protocol for easy serialization/deserialization from JSON.
 
 ViewModel (PostViewModel): Contains the business logic for fetching posts from the API. It uses URLSession to make the network request and parses the JSON response into an array of Post objects. It also provides a completion closure to notify the view controller once data is fetched.
 
 View (PostViewController): Displays the posts fetched from the API in a table view. It sets itself as the data source for the table view and reloads the table view once the data is fetched.
 
 Extension (PostViewController: UITableViewDataSource): Implements the table view data source methods to populate the table view with post data.
 
 */

