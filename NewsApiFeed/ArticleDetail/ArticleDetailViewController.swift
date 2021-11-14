//
//  ArticleDetailViewController.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 28/10/2021.
//

import RIBs
import RxSwift
import SDWebImage
import SafariServices

protocol ArticleDetailPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func didOpenArticleInSafariBrowser()
}

final class ArticleDetailViewController: UIViewController, ArticleDetailPresentable, ArticleDetailViewControllable {

    weak var listener: ArticleDetailPresentableListener?
    private let disposeBag = DisposeBag()
    
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
    
    private lazy var openInSafariButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Open in Safari", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(openSafariButtonOnTap), for: .touchUpInside)
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @available(iOS 13, *)
    static func make(withArticle article: Article) -> ArticleDetailViewController {
        let hostArticleDetailVC = ArticleDetailViewController()
        let articleDetailView = ArticleDetailView(article: article)
        let hostableArticleDetailController = articleDetailView.viewController
        hostArticleDetailVC.addChild(hostableArticleDetailController)
        hostArticleDetailVC.view.addSubview(hostableArticleDetailController.view)
        hostableArticleDetailController.view.frame = hostArticleDetailVC.view.frame
        hostableArticleDetailController.didMove(toParent: hostArticleDetailVC)
        
        return hostArticleDetailVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if #available(iOS 13, *) {
            // Stuff for iOS 13 and later target
        } else {
            setupView()
        }
    }
    
    // MARK: - Setup View
    private func setupView() {
        [imageView, titleLabel, contentLabel, openInSafariButton].forEach(view.addSubview)
        
        imageView.snp.makeConstraints { maker in
            maker.top.equalTo(self.view.snp.topMargin)
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
        
        openInSafariButton.snp.makeConstraints { maker in
            maker.top.equalTo(contentLabel.snp.bottom).offset(25)
            maker.width.equalTo(150)
            maker.height.equalTo(40)
            maker.centerX.equalTo(view)
        }
    }
    
    // MARK: - ArticleDetailPresentable
    
    func setViews(with article: Article) {
        navigationItem.title = article.source?.name
        imageView.sd_setImage(with: article.imageUrl,
                              placeholderImage: #imageLiteral(resourceName: "news_placeholder"),
                              options: .continueInBackground)
        titleLabel.text = article.title
        contentLabel.text = article.description
    }
    
    // MARK: - Events
    @objc private func openSafariButtonOnTap(_ sender: UIButton) {
            listener?.didOpenArticleInSafariBrowser()
    }

    // MARK: - ArticleDetailViewControllable
    func showArticleInBrowser(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
}
