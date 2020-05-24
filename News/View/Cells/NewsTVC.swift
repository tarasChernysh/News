//
//  NewsTVC.swift
//  News
//
//  Created by Taras Chernysh on 10/12/19.
//  Copyright © 2019 Taras Chernysh. All rights reserved.
//

import UIKit
import AlamofireImage
import Rswift

class NewsTVC: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pictureImageView: NewsImageView!
    @IBOutlet weak var dateLabel: UILabel!

    func configure(with news: News) {
        titleLabel.text = news.title
        
        if let author = news.author {
            sourceLabel.text = "\(news.source), \(author)"
        } else {
            sourceLabel.text = news.source
        }
        descriptionLabel.text = news.description
        dateLabel.text = news.publishedDate
        pictureImageView.layer.cornerRadius = 10
        pictureImageView.layer.masksToBounds = true
        if let path = news.imageURLString {
            pictureImageView.loadImage(withPath: path)
            return
        }
        pictureImageView.image = R.image.unknowFormatImage()
    }
}
