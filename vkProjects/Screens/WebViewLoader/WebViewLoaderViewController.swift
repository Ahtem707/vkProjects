//
//  WebViewLoaderViewController.swift
//  vkProjects
//
//  Created by Ahtem Sitjalilov on 17.02.2023.
//

import UIKit
import WebKit

final class WebViewLoaderViewController: UIViewController {
    
    // MARK: - Public variables
    
    var url: URL?
    
    // MARK: - Private variables
    
    private let webView = WKWebView()
    private let loaderView = StrokeCircleAnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        setupLoader()
        setupContent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loaderView.start()
    }
}

// MARK: - Setup functions
extension WebViewLoaderViewController {
    private func setupWebView() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.pinToSuperview(edges: [.top], safeArea: true)
        webView.pinToSuperview(edges: [.left, .right, .bottom])
    }
    
    private func setupLoader() {
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loaderView)
        loaderView.pin(size: CGSize(width: 100, height: 100))
        loaderView.pinCenterToSuperview(of: .vertical)
        loaderView.pinCenterToSuperview(of: .horizontal)
    }
    
    private func setupContent() {
        if let url = url {
            webView.load(URLRequest(url: url))
        } else {
            AppLogger.log(.logic, "Ошибка открытия ссылки")
        }
    }
}

extension WebViewLoaderViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loaderView.stop()
    }
}
