//
//  ArticlesListViewController.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 23/10/2021.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol ArticlesListPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func viewWillAppear()
    func didRefresh()
    func didSelectArticle(at indexPath: IndexPath)
}

final class ArticlesListViewController: UIViewController, ArticlesListPresentable, ArticlesListViewControllable {
   
    
    var viewModel: ArticlesListViewModel!

    weak var listener: ArticlesListPresentableListener?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.rowHeight = 80
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.register(ArticleItemCell.self, forCellReuseIdentifier: ArticleItemCell.description())
        tableView.refreshControl = refreshControl
        return tableView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let aiView = UIActivityIndicatorView(style: .gray)
        aiView.hidesWhenStopped = true
        return aiView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(didPullRefresh(_:)), for: .valueChanged)
        return refresh
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TableView"
        navigationItem.title = "New list"
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listener?.viewWillAppear()
    }
    
    private func setupView() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        
        tableView.snp.makeConstraints { maker in
            maker.edges.equalTo(self.view)
        }
        
        activityIndicator.snp.makeConstraints { maker in
            maker.center.equalTo(self.tableView)
        }
    }
    
    @objc private func didPullRefresh(_ sender: UIRefreshControl) {
        listener?.didRefresh()
    }
    
    // MARK: - ArticlesListPresentable
    
    func showActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    func showError(message: String) {
        
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - ArticlesListViewControllable
    func pushViewController(_ viewControllable: ViewControllable, animated: Bool) {
        navigationController?.pushViewController(viewControllable.uiviewController, animated: animated)
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension ArticlesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleItemCell.description(), for: indexPath) as! ArticleItemCell
        let article = viewModel.item(at: indexPath.row)
        cell.textLabel?.text = article?.title
        cell.detailTextLabel?.text = article?.publishedAt
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listener?.didSelectArticle(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

final class ArticleItemCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .white
        textLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        detailTextLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    }
}


public extension UINavigationController {
    
    func pushViewController(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
}
