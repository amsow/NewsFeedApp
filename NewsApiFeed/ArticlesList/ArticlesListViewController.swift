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
import SwiftUI

protocol ArticlesListPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func didRefresh()
    func didSelectArticle(at indexPath: IndexPath)
}

final class ArticlesListViewController: UIViewController, ArticlesListPresentable, ArticlesListViewControllable {
    
    private(set) var viewModel: ArticlesListViewModel!
    
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
    
    private init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Use this method factory for version under iOS 13
    static func make<ListViewModel>(with viewModel: ListViewModel) -> ArticlesListViewController {
        let vc = ArticlesListViewController()
        
        if #available(iOS 13, *) {
            let articlesListView = ArticlesListView(viewModel: viewModel as! ArticlesListViewModelObject)
            let hostVC = articlesListView.viewController
            vc.addChild(hostVC)
            vc.view.addSubview(hostVC.view)
            hostVC.view.frame = vc.view.frame
            //hostVC.didMove(toParent: vc)
            return vc
        }
        vc.viewModel = viewModel as? ArticlesListViewModel
        return vc
    }
    
    
    static func make(with viewModel: ArticlesListViewModel) -> ArticlesListViewController {
        let vc = ArticlesListViewController()
         vc.viewModel = viewModel
        return vc
    }
    
    /// Use this method factory for iOS 13 and later target
    @available(iOS 13, *)
    static func make(with viewModel: ArticlesListViewModelObject) -> ArticlesListView {
        
        let articlesListView = ArticlesListView(viewModel: viewModel)
        return articlesListView
    }
    
    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TableView"
        navigationItem.title = "New list"
        view.backgroundColor = .white
        if #available(iOS 13, *) {
            
        } else {
            setupView()
        }
    }
    
    private func setupView() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        
        tableView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { maker in
            maker.center.equalTo(self.tableView)
        }
    }
    
    @objc private func didPullRefresh(_ sender: UIRefreshControl) {
        listener?.didRefresh()
    }
    
    // MARK: - ArticlesListPresentable
    
    func configure<ViewModel>(viewModel: ViewModel) where ViewModel : ListViewModel {
        self.viewModel = viewModel as? ArticlesListViewModel
    }
    
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
    
    func showError(message: String) { }
    
    func reloadListView() {
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

@available(iOS 13, *)
extension ArticlesListViewController: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> ArticlesListViewController {
        return self
    }
    
    func updateUIViewController(_ uiViewController: ArticlesListViewController, context: Context) {
        
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

@available(iOS 13, *)
extension ArticleItemCell: UIViewRepresentable {
    
    //typealias UIViewType = UITableViewCell
    
    convenience init(title: String, description: String) {
        self.init(style: .subtitle, reuseIdentifier: nil)
        self.textLabel?.text = title
        self.detailTextLabel?.text = description
    }
    
    func makeUIView(context: Context) -> UITableViewCell {
        return self
    }
    
    func updateUIView(_ uiView: UITableViewCell, context: Context) { }
    
}
