//
//  AppAllert.swift
//  vkProjects
//
//  Created by Ahtem Sitjalilov on 18.02.2023.
//

import UIKit

final class AppAlertFactory {
    
    weak var delegate: UIViewController?
    
    init(_ delegate: UIViewController) {
        self.delegate = delegate
    }
    
    func showNetworkError(actionHandler: (()->Void)?) {
        let alert = UIAlertController(
            title: "Ошибка",
            message: "Нет соединения с интернетом",
            preferredStyle: .alert
        )
        let alertAction = UIAlertAction(title: "Повторить", style: .cancel) { _ in
            actionHandler?()
        }
        alert.addAction(alertAction)
        present(alert)
    }
    
    private func present(_ alert: UIViewController) {
        DispatchQueue.main.async {
            self.delegate?.present(alert, animated: true)
        }
    }
}
