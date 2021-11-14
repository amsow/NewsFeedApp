//
//  PageView.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 08/11/2021.
//

import SwiftUI

@available(iOS 13, *)
struct ArticlesPageView<ArticleDetailView: HostableView>: View {
    
    let pageViews: [ArticleDetailView]
    
    var body: some View {
        ArticlesPageViewController(pages: pageViews)
    }
}

@available(iOS 13, *)
struct ArticlesPageView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesPageView(pageViews: [ArticleDetailView(article: Article.fake), ArticleDetailView(article: Article.fake), ArticleDetailView(article: Article.fake)])
    }
}


@available(iOS 13, *)
struct ArticlesPageViewController<PageView: HostableView>: UIViewControllerRepresentable {
    
    let pages: [PageView]
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageViewController.dataSource = context.coordinator
        return pageViewController
    }
    
    func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) {
        guard let firstController = context.coordinator.controllers.first else { return }
        uiViewController.setViewControllers([firstController], direction: .forward, animated: true)
    }
}

@available(iOS 13, *)
extension ArticlesPageViewController {
    
    // MARK: - Coordinator - DataSource
    class Coordinator: NSObject, UIPageViewControllerDataSource {
        let parent: ArticlesPageViewController
        var controllers = [UIViewController]()
        
        init(_ pageViewController: ArticlesPageViewController) {
            parent = pageViewController
            controllers = parent.pages.map { $0.viewController }
        }
        
        // MARK: - UIPageViewControllerDataSource
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController), index > 0 else {
                return nil
            }
            let previousIndex = index - 1
            let vc = controllers[previousIndex]
           // navigationTitle = viewController.navigationItem.title
            return vc
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController), index < (controllers.count - 1) else {
                return nil
            }
            let nextIndex = index + 1
            let vc = controllers[nextIndex]
          //  navigationTitle = viewController.navigationItem.title
            return vc
        }
    }
}
