//
//  BookmarkedViewController.swift
//  newsApi
//
//  Created by Amit Choudhary on 19/06/24.
//

import UIKit

class BookmarkedViewController: UIViewController,
                                    UITableViewDelegate,
                                    UITableViewDataSource,
                                    BookmarkCellDelegate {
    var bookmarkedArticles: [NewsArticle] = []

    @IBOutlet weak var tbvBookMark: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tbvBookMark.register(UINib(nibName: "BookmarkCell", bundle: nil), forCellReuseIdentifier: "BookmarkCell")
        tbvBookMark.delegate = self
        tbvBookMark.dataSource = self
        tbvBookMark.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear called")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear called")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 274.0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarkedArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkCell", for: indexPath) as? BookmarkCell else {
            return UITableViewCell()
        }
        let article = bookmarkedArticles[indexPath.row]
        cell.configure(with: article)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = bookmarkedArticles[indexPath.row]
        if let url = URL(string: article.url) {
            UIApplication.shared.open(url)
        }
    }
    
    func didTapUnbookmarkButton(in cell: BookmarkCell) {
        if let indexPath = tbvBookMark.indexPath(for: cell) {
            bookmarkedArticles.remove(at: indexPath.row)
            tbvBookMark.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
