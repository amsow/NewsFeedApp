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
    
    @available(iOS 13, *)
    static func make<ListViewContent: View, DetailViewContent: View>(withChildViews articleListView: () -> ListViewContent,
                                                                     articleDetailView: () -> DetailViewContent) -> RootViewController {
        let rootVC = RootViewController()
        let rootTabView = RootTabView(list: articleListView, detail: articleListView)
        let hostVC = rootTabView.viewController
        rootVC.addChild(hostVC)
        rootVC.view.addSubview(hostVC.view)
        hostVC.view?.frame = rootVC.view.frame
        hostVC.didMove(toParent: rootVC)
        
        return rootVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    // MARK: - RootViewControllable
    func setViewControllers(_ viewControllers: [ViewControllable]) {
        self.viewControllers = viewControllers.map { $0.uiviewController }
    }
}

