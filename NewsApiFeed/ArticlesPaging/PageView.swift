//
//  PageView.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 08/11/2021.
//

import SwiftUI

@available(iOS 13, *)
struct ArticlesPageView: View {
    var body: some View {
        Text("Hello World!")
    }
}

@available(iOS 13, *)
struct ArticlesPageView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesPageView()
    }
}


@available(iOS 13, *)
struct ArticlesPageViewController<PageView: View>: UIViewControllerRepresentable {
    
    let pageView: [PageView]
    
    func makeUIViewController(context: Context) -> some UIPageViewController {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        return pageViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
