//
//  ProjectListViewModel.swift
//  vkProjects
//
//  Created by Ahtem Sitjalilov on 17.02.2023.
//

import Foundation

final class ProjectListViewModel: BaseViewModel {
    
    // MARK: - Public variables
    
    weak var delegate: ProjectListViewControllerDelegate?
    private var dataSource: [ProjectCellModel] = []
    private var isDataSourceUpdated: Bool = false
    
    func initialize() {
        
    }
}

// MARK: - Private functions
extension ProjectListViewModel {
    
    func fetchProjects() {
        API.Project.getProjects.request(ProjectsResponse.self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.isDataSourceUpdated = true
                if let items = data.items, !items.isEmpty {
                    AppStorage.share.projects = items
                    self?.makeDataSource()
                } else {
                    AppLogger.log(.storage, AppError.contentError)
                    self?.delegate?.showError(message: AppError.contentError.localizedDescription)
                }
            case .failure(let error):
                self?.isDataSourceUpdated = true
                AppLogger.log(.storage, error.localizedDescription)
                self?.delegate?.showError(message: error.localizedDescription)
            }
        }
    }
    
    private func makeDataSource() {
        dataSource = AppStorage.share.projects.map { ProjectCellModel(iconUrl: $0.iconUrl, title: $0.name) }
        delegate?.updateDataSource()
    }
}

// MARK: - ProjectListViewModelProtocol
extension ProjectListViewModel: ProjectListViewModelProtocol {
    func getViewTitle() -> String {
        return "Проекты VK"
    }
    
    func getTableCount() -> Int {
        return dataSource.count
    }
    
    func getTableItem(_ indexPath: IndexPath) -> ProjectCellModel {
        return dataSource[indexPath.row]
    }
    
    func didSelectItem(_ indexPath: IndexPath) {
        let vc = ProjectDetailViewController()
        let projectTitle = getTableItem(indexPath).title
        let projectData = AppStorage.share.projects.first { $0.name == projectTitle }
        vc.projectData = projectData
        delegate?.pushViewController(vc)
    }
}
