//
//  ArticlesListBuilder.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 23/10/2021.
//

import RIBs
import UIKit
import SwiftUI

protocol ArticlesListDependency: ArticleDetailDependency {
    var articleListViewController: ArticlesListViewControllable { get }
    var viewModel: ViewModel { get }
    var articlesFetcher: ArticleFetcher { get }
}

final class ArticlesListComponent: Component<ArticlesListDependency> {
    
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    fileprivate var articlesListViewController: ArticlesListViewControllable {
        return dependency.articleListViewController
    }
}

// MARK: - Builder

protocol ArticlesListBuildable: Buildable {
    func build(withListener listener: ArticlesListListener) -> ArticlesListRouting
}

final class ArticlesListBuilder: Builder<ArticlesListDependency>, ArticlesListBuildable {
    
    override init(dependency: ArticlesListDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: ArticlesListListener) -> ArticlesListRouting {
        let component = ArticlesListComponent(dependency: dependency)
        let interactor = getArticlesListInteractor()
        let articleDetailBuilder = ArticleDetailBuilder(dependency: dependency)
        interactor.listener = listener
        return ArticlesListRouter(interactor: interactor,
                                  viewController: component.articlesListViewController,
                                  articleDetailBuilder: articleDetailBuilder)
    }
    
    private func getArticlesListInteractor() -> ArticlesListInteractor {
        
        if #available(iOS 13, *) {
            
            let interactor = ArticlesListInteractor(presenter: dependency.articleListViewController as! ListPresentable,
                                                    articlesFetcher: dependency.articlesFetcher)
            interactor.viewModelObject = dependency.viewModel as! ArticlesListViewModelObject
            print("ViewModel object ===> \(interactor.viewModelObject)")
            return interactor
            
        } else {
            let viewController = dependency.articleListViewController
            let interactor = ArticlesListInteractor(presenter: viewController as! ListPresentable,
                                                    articlesFetcher: dependency.articlesFetcher)
            interactor.viewModel = dependency.viewModel as! ArticlesListViewModel
            
            return interactor
        }
    }
    
}
