//
//  ArticlesListInteractor.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 23/10/2021.
//

import Foundation
import RIBs
import RxSwift


protocol ArticlesListRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol ArticlesListPresentable: Presentable {
    var listener: ArticlesListPresentableListener? { get set }
    func setCell(atRow row: Int, withArtcile article: Article)
}

protocol ArticlesListListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class ArticlesListInteractor: PresentableInteractor<ArticlesListPresentable>, ArticlesListInteractable, ArticlesListPresentableListener {

    weak var router: ArticlesListRouting?
    weak var listener: ArticlesListListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: ArticlesListPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}

struct Article: Decodable {
    let title: String?
    let description: String?
    let imageUrl: URL?
}

extension Article {
    static let empty = Self(title: nil, description: nil, imageUrl: nil)
}
