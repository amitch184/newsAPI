//
//  NewsViewController.swift
//  newsApi
//
//  Created by Amit Choudhary on 19/06/24.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, NewsCellDelegate {
    
    @IBOutlet weak var tvNewsListing: UITableView!
    @IBOutlet weak var sbCategory: UISearchBar!
    @IBOutlet weak var scCategory: UISegmentedControl! // Add this outlet

    private let viewModel = NewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvNewsListing.delegate = self
        tvNewsListing.dataSource = self
        sbCategory.delegate = self

        tvNewsListing.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        bindViewModel()
        viewModel.fetchNews(category: "general")
    }
    
    private func bindViewModel() {
        viewModel.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tvNewsListing.reloadData()
            }
        }
    }

    @IBAction func categoryChanged(_ sender: UISegmentedControl) {
        let selectedCategory = sender.titleForSegment(at: sender.selectedSegmentIndex)?.lowercased() ?? "general"
        viewModel.fetchNews(category: selectedCategory)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 101.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfArticles()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell else {
            return UITableViewCell()
        }
        let article = viewModel.getArticle(at: indexPath.row)
        let isBookmarked = viewModel.isBookmarked(article: article)
        cell.configure(with: article, isBookmarked: isBookmarked)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = viewModel.getArticle(at: indexPath.row)
        if let url = URL(string: article.url) {
            UIApplication.shared.open(url)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let category = searchBar.text else { return }
        viewModel.fetchNews(category: category.lowercased())
    }
    
    @IBAction func viewBookmarkedArticles(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let bookmarkedVC = storyboard.instantiateViewController(withIdentifier: "BookmarkedViewController") as? BookmarkedViewController {
                bookmarkedVC.bookmarkedArticles = viewModel.bookmarkedArticles // Pass bookmarked articles
                navigationController?.pushViewController(bookmarkedVC, animated: true)
            }
    }
    
    func didTapBookmarkButton(in cell: NewsCell) {
        if let indexPath = tvNewsListing.indexPath(for: cell) {
            viewModel.bookmarkArticle(at: indexPath.row)
            tvNewsListing.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}
