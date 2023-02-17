//
//  AppNavigationController.swift
//  vkProjects
//
//  Created by Ahtem Sitjalilov on 05.11.2022.
//

import UIKit

final class AppNavigationController: UINavigationController {
    
    let headerView = UIView()
    
    enum Screens {
        case main
        
        var viewController: UIViewController {
            switch self {
            case .main:
                return ProjectListViewController()
            }
        }
    }
    
    // MARK: - Lifecicle functions
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        pushViewController(Screens.main.viewController, animated: false)
    }
}

// MARK: - Private functions
extension AppNavigationController {
    private func setupNavigationBar() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        headerView.pinToSuperview(edges: [.top, .left, .right])
        headerView.pin(height: UIApplication.shared.statusBarFrame.height)
        headerView.backgroundColor = AppColor.System.backColor
        navigationBar.backgroundColor = AppColor.System.backColor
    }
}
