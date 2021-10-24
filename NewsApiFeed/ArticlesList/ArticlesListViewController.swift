//
//  ArticlesListViewController.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 23/10/2021.
//

import RIBs
import RxSwift
import UIKit

protocol ArticlesListPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class ArticlesListViewController: UIViewController, ArticlesListPresentable, ArticlesListViewControllable {

    weak var listener: ArticlesListPresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TableView"
        view.backgroundColor = .yellow
    }
    
    
    // MARK: - ArticlesListPresentable
    func setCell(atRow row: Int, withArtcile article: Article) {
        
    }
}
