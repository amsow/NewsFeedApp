//
//  ArticleDetailViewController.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 28/10/2021.
//

import RIBs
import RxSwift
import UIKit

protocol ArticleDetailPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class ArticleDetailViewController: UIViewController, ArticleDetailPresentable, ArticleDetailViewControllable {

    weak var listener: ArticleDetailPresentableListener?
}
