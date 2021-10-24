//
//  ArticlesListBuilder.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 23/10/2021.
//

import RIBs
import UIKit

protocol ArticlesListDependency: Dependency {
    var articleListViewController: ArticlesListViewControllable { get }
}

final class ArticlesListComponent: Component<ArticlesListDependency> {
    
    let navigationController: UINavigationController
    
    init(dependency: ArticlesListDependency, navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init(dependency: dependency)
    }

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
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
        let viewController = ArticlesListViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        let component = ArticlesListComponent(dependency: dependency, navigationController: navigationController)
       
        let interactor = ArticlesListInteractor(presenter: viewController)
        interactor.listener = listener
        return ArticlesListRouter(interactor: interactor, viewController: viewController)
    }
}
