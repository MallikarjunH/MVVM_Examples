//
//  PostTableViewCell.swift
//  Example1
//
//  Created by Mallikarjun H on 02/02/24.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainBGView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.mainBGView.layer.cornerRadius = 5
        self.mainBGView.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(with post: Post) {
        titleLabel.text = post.title
        bodyLabel.text = post.body
    }
}
