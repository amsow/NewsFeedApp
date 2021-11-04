//
//  ArticlesListController+UIHostViewController.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 02/11/2021.
//

import Foundation
import RIBs
import SwiftUI


@available(iOS 13.0, *)
final class ArticlesListController: UIHostingController<ArticlesListView>, ArticlesListPresentable, ArticlesListViewControllable {
    
    var listener: ArticlesListPresentableListener?
    
    override init(rootView: ArticlesListView) {
        super.init(rootView: rootView)
    }
    
    @MainActor @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TableView"
    }
    
    
    // MARK: - ArticlesListPresentable
    func configure<ViewModel>(viewModel: ViewModel) where ViewModel : ListViewModel {
        rootView.viewModel = viewModel as! ArticlesListViewModelObject
    }
    
    func showError(message: String) { }
    
    func reloadTableView() { }
    
    func showActivityIndicator() { }
    
    func hideActivityIndicator() { }
    
    
    // ArticlesListViewControllable
    func pushViewController(_ viewControllable: ViewControllable, animated: Bool) { }
}


@available(iOS 13.0, *)
protocol UIHostingControllable {
    associatedtype Content: View
    var contentView: Content { get set }
}

@available(iOS 13.0, *)
extension UIHostingControllable where Self: UIHostingController<ArticlesListView> { }
