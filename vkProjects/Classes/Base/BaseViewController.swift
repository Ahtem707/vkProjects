//
//  BaseViewController.swift
//  vkProjects
//
//  Created by Ahtem Sitjalilov on 05.11.2022.
//

import UIKit

typealias BaseViewController = ViewControllerProtocol & ViewControllerImplement

protocol ViewControllerProtocol: AnyObject {
    associatedtype ViewModel = NSObjectProtocol
    var viewModel: ViewModel! { get set }
}

class ViewControllerImplement: UIViewController {
    
    let loaderView = StrokeCircleAnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setupLoader()
    }
    
    func showShortMessage(message: String, status: ShortMessageStatus) {
        let messageView = ShortMessageViewFactory()
        messageView.viewController = self
        messageView.message = message
        messageView.status = status
        messageView.initialize()
        messageView.show()
    }
}

// MAKR: - Private functions
extension ViewControllerImplement {
    /// Конфигурируем BaseViewController
    private func configure() {
        navigationController?.view.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        let textAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        navigationItem.backButtonTitle = "Назад"
        view.backgroundColor = .white
    }
    
    /// Инициализируем лоадер
    private func setupLoader() {
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loaderView)
        loaderView.pin(size: CGSize(width: 100, height: 100))
        loaderView.pinCenterToSuperview(of: .vertical)
        loaderView.pinCenterToSuperview(of: .horizontal)
    }
}
