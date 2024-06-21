//
//  NewsCell.swift
//  newsApi
//
//  Created by Amit Choudhary on 19/06/24.
//

import UIKit

import UIKit

protocol NewsCellDelegate: AnyObject {
    func didTapBookmarkButton(in cell: NewsCell)
}

class NewsCell: UITableViewCell {
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnBookmark: UIButton!
    @IBOutlet weak var imgNews: UIImageView!

    weak var delegate: NewsCellDelegate?
    
    @IBAction func bookmarkButtonTapped(_ sender: UIButton) {
        delegate?.didTapBookmarkButton(in: self)
    }
    
    func configure(with article: NewsArticle, isBookmarked: Bool) {
        lbltitle.text = article.title
        lblDescription.text = article.description
        let bookmarkImage = isBookmarked ? UIImage(named: "bookmarked") : UIImage(named: "bookmark")
        btnBookmark.setImage(bookmarkImage, for: .normal)
        
        // Load image asynchronously using GlobalManager
        if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
            GlobalManager.shareInstance.loadImage(from: url) { [weak self] image in
                self?.imgNews.image = image ?? UIImage(named: "")
            }
        }
    }
    
}
