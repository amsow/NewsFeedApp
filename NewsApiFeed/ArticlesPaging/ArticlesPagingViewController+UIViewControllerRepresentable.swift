//
//  ArticlesPagingViewController+UIViewControllerRepresentable.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 14/11/2021.
//

import SwiftUI

@available(iOS 13, *)
extension ArticlesPagingViewController: UIViewControllerRepresentable {
    
    func makeCoordinator() -> ArticlesPagingViewController {
        return self
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
