//
//  BookmarkCell.swift
//  newsApi
//
//  Created by Amit Choudhary on 19/06/24.
//

import UIKit

import UIKit

protocol BookmarkCellDelegate: AnyObject {
    func didTapUnbookmarkButton(in cell: BookmarkCell)
}

class BookmarkCell: UITableViewCell {
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgNews: UIImageView!
    @IBOutlet weak var lblPublishedAt: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var btnUnbookmarkButton: UIButton!

    weak var delegate: BookmarkCellDelegate?
    
    @IBAction func unbookmarkButtonTapped(_ sender: UIButton) {
        delegate?.didTapUnbookmarkButton(in: self)
    }
    
    func configure(with article: NewsArticle) {
        lbltitle.text = article.title
        lblDescription.text = article.description
        lblPublishedAt.text = article.publishedAt
        lblContent.text = article.content
        // Load image asynchronously using GlobalManager
        if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
            GlobalManager.shareInstance.loadImage(from: url) { [weak self] image in
                self?.imgNews.image = image ?? UIImage(named: "")
            }
        }
    }
}

