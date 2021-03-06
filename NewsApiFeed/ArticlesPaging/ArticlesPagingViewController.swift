//
//  ArticlesPagingViewController.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 23/10/2021.
//

import RIBs
import RxSwift
import UIKit

protocol ArticlesPagingPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class ArticlesPagingViewController: UIPageViewController, ArticlesPagingPresentable, ArticlesPagingViewControllable {
   
    weak var listener: ArticlesPagingPresentableListener?
    
    private var vcs = [UIViewController]()
    
    private var navigationTitle: String? {
        didSet { navigationItem.title = navigationTitle }
    }
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "PageView"
        dataSource = self
        delegate = self
    }
    
    // MARK: - ArticlesPagingViewControllable
    func setViewControllers(_ viewControllers: [ViewControllable]) {
        vcs = viewControllers.map { $0.uiviewController }
        if let firstViewController = vcs.first {
            setViewControllers([firstViewController], direction: .forward, animated: true)
        }
    }
}

// MARK: - UIPageViewControllerDataSource
extension ArticlesPagingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = vcs.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        let previousIndex = index - 1
        let vc = vcs[previousIndex]
        navigationTitle = viewController.navigationItem.title
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = vcs.firstIndex(of: viewController), index < (vcs.count - 1) else {
            return nil
        }
        let nextIndex = index + 1
        let vc = vcs[nextIndex]
        navigationTitle = viewController.navigationItem.title
        return vc
    }
    
}

extension ArticlesPagingViewController: UIPageViewControllerDelegate { }
