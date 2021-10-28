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
    
     let vcs = [UIViewController](repeating: UIViewController(), count: 40)
    
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
        view.backgroundColor = .blue
        setViewControllers([vcs.first!], direction: .forward, animated: true)
        vcs.forEach { vc in
            let randomNumber = CGFloat(Int.random(in: 0...10))
            vc.view.backgroundColor = UIColor(red: 100 * randomNumber / 255, green: 200 * randomNumber / 255, blue: 150 * randomNumber, alpha: 1)
            vc.title = "Title ===> \(randomNumber)"
        }
        
        dataSource = self
    }
    
}

extension ArticlesPagingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = vcs.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        let before = index - 1
        return vcs[before]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = vcs.firstIndex(of: viewController), index < (vcs.count - 1) else {
            return nil
        }
        let after = index + 1
        return vcs[after]
    }
    
}
