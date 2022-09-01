//
//  DetailViewController.swift
//  MovieFinder
//
//  Created by Hyoju Son on 2022/09/01.
//

import UIKit
import RxSwift
import WebKit

final class DetailViewController: UIViewController {
    // MARK: - Properties
    private let blogWebView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private var viewModel: DetailViewModel!
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializers
    convenience init(viewModel: DetailViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        configureToolbar()
        configureUI()
    }
    
    // MARK: - Methods
    private func configureToolbar() {
//        navigationController?.isToolbarHidden = false
//        navigationController?.toolbar.backgroundColor = .red
//
//        let backButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(backButtonDidTap))
//
//        navigationController?.toolbar.items = [backButton]
        
//        navigationController?.setToolbarItems(
//            [backButton],
//            animated: true
//        )
//            let backButton = UIBarButtonItem(
//                barButtonSystemItem: .rewind,
//                target: self,
//                action: #selector(backButtonDidTap)
//            )
//        let forwardButton = UIBarButtonItem(
//            barButtonSystemItem: .fastForward,
//            target: self,
//            action: #selector(forwardButtonDidTap)
//        )
//        let refreshButton = UIBarButtonItem(
//            barButtonSystemItem: .refresh,
//            target: self,
//            action: #selector(refreshButtonDidTap)
//        )
//
//        navigationController?.toolbarItems = [backButton, forwardButton, refreshButton]
//        navigationController?.setToolbarItems(
//            [backButton, forwardButton, refreshButton],
//            animated: true
//        )
    }
    
    @objc
    private func backButtonDidTap() {
        blogWebView.goBack()
    }
    @objc
    private func forwardButtonDidTap() {
        blogWebView.goForward()
    }
    @objc
    private func refreshButtonDidTap() {
        blogWebView.reload()
    }
    
    private func configureUI() {
        view.addSubview(blogWebView)
        view.addSubview(activityIndicator)
        blogWebView.navigationDelegate = self
        
        NSLayoutConstraint.activate([
            blogWebView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            blogWebView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            blogWebView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            blogWebView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

// MARK: - Rx Binding Methods
extension DetailViewController {
    private func bind() {
        let input = DetailViewModel.Input(
        )
        
        let output = viewModel.transform(input)
        
        configureMovieItem(with: output.movieItem)
    }
    
    private func configureMovieItem(with outputObservable: Observable<MovieItem>) {
        outputObservable
            .withUnretained(self)
            .subscribe(onNext: { (owner, movieItem) in
                // TODO: API 구현
//                let link = movieItem.link
//                owner.loadWebPage(movieItem.link)
                
                // WebView TEST
                let happyMovieItem = MovieItem(
                    title: "더 해피 워커",
                    link: "https://movie.naver.com/movie/bi/mi/basic.nhn?code=215622",
                    image: "https://ssl.pstatic.net/imgmovie/mdi/mit110/2156/215622_P01_163446.jpg",
                    director: "존 웹스터|",
                    actor: "",
                    userRating: "0.00"
                )
                owner.loadWebPage(with: happyMovieItem.link)
            })
            .disposed(by: disposeBag)
    }
    
    private func loadWebPage(with url: String) {
        guard let url = URL(string: url) else { return }
        let urlRequest = URLRequest(url: url)
        
        blogWebView.load(urlRequest)
    }
    
    // TODO: API 연동?
    private func loadWebPageWithHTML(_ html: String) {
        blogWebView.loadHTMLString(html, baseURL: nil)
    }
}

extension DetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        backButton.isEna
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
}
