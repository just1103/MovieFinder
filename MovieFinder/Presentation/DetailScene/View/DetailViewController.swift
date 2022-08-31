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
    let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
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
        configureUI()
    }
    
    // MARK: - Methods
    private func configureUI() {
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
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
                owner.loadWebPage(happyMovieItem.link)
            })
            .disposed(by: disposeBag)
    }
    
    private func loadWebPage(_ url: String) {
        guard let url = URL(string: url) else { return }
        let urlRequest = URLRequest(url: url)
        
        webView.load(urlRequest)
    }
}
