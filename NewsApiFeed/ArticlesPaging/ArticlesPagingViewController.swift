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

final class ArticlesPagingViewController: UIViewController, ArticlesPagingPresentable, ArticlesPagingViewControllable {

    weak var listener: ArticlesPagingPresentableListener?
}
