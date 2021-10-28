//
//  ArticleDetailViewController.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 28/10/2021.
//

import RIBs
import RxSwift
import SDWebImage

protocol ArticleDetailPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func openArticleInSafariBrowser()
}

final class ArticleDetailViewController: UIViewController, ArticleDetailPresentable, ArticleDetailViewControllable {

    weak var listener: ArticleDetailPresentableListener?
    private let article: Article
    
    private let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let openInSafariButton: UIButton = {
        let button = UIButton(type: .system)
        return button
    }()
    
    init(article: Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setValues()
    }
    
    // MARK: - Setup View
    private func setupView() {
        [imageView, titleLabel, contentLabel].forEach(view.addSubview)
        
        imageView.snp.makeConstraints { maker in
            maker.top.equalTo(self.view).inset(15)
            maker.left.right.equalTo(self.view)
            maker.height.equalTo(300)
        }
        
        titleLabel.snp.makeConstraints { maker in
            maker.top.equalTo(imageView.snp.bottom).offset(20)
            maker.left.right.equalTo(imageView).inset(15)
        }
        
        contentLabel.snp.makeConstraints { maker in
            maker.top.equalTo(titleLabel.snp.bottom).offset(10)
            maker.left.right.equalTo(titleLabel)
        }
    }
    
    private func setValues() {
        imageView.sd_setImage(with: article.imageUrl, placeholderImage: #imageLiteral(resourceName: "news_placeholder"), options: .continueInBackground)
        titleLabel.text = article.title
        contentLabel.text = article.description
    }
}
