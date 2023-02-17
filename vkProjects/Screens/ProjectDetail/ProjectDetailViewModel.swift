//
//  ProjectDetailViewModel.swift
//  vkProjects
//
//  Created by Ahtem Sitjalilov on 17.02.2023.
//

import Foundation

final class ProjectDetailViewModel: BaseViewModel {
    
    // MARK: - Public variables
    
    weak var delegate: ProjectDetailViewControllerDelegate?
    
    func initialize() {
        
    }
}

// MARK: - Private functions
extension ProjectDetailViewModel {
    
}

// MARK: - ProjectDetailViewModelProtocol
extension ProjectDetailViewModel: ProjectDetailViewModelProtocol {
    func didSelectLink(url: URL?) {
        let webVC = WebViewLoaderViewController()
        webVC.url = url
        delegate?.presentViewController(webVC)
    }
}
