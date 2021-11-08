//
//  RootViewController.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 23/10/2021.
//

import RIBs
import RxSwift
import UIKit
import SwiftUI

protocol RootPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RootViewController: UITabBarController, RootPresentable, RootViewControllable {

    weak var listener: RootPresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func make<ViewModel: ListViewModel>(withListViewModel viewModel: ViewModel) -> RootViewController {
        let rootVC = RootViewController()
        if #available(iOS 13, *) {
            let rootTabView = RootTabView {
                ArticlesListView(viewModel: viewModel as! ArticlesListViewModelObject)
            } detail: {
                ArticleDetailView(article: Article.fake)
            }
          let hostVC = UIHostingController(rootView: rootTabView)
            rootVC.addChild(hostVC)
            rootVC.view.addSubview(hostVC.view)
            hostVC.view?.frame = rootVC.view.frame
            hostVC.didMove(toParent: rootVC)
            return rootVC
        }
        return rootVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    func setViewControllers(_ viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
    }
}

