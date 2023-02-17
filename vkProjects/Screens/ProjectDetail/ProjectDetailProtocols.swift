//
//  ProjectDetailProtocols.swift
//  vkProjects
//
//  Created by Ahtem Sitjalilov on 17.02.2023.
//

import UIKit

protocol ProjectDetailViewControllerDelegate: AnyObject {
    /// Переход на указанный viewController
    /// - Parameter viewController: viewController на который будем переходить
    func presentViewController(_ viewController: UIViewController)
}

protocol ProjectDetailViewModelProtocol: AnyObject {
    /// Нажатие на ссылку
    func didSelectLink(url: URL?)
}
