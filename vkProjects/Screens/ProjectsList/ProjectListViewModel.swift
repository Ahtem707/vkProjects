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
    
    // MARK: - Private variables
    
    private var dataSource: [ProjectCellModel] = []
    private var isDataSourceUpdated: Bool = false
    
    func initialize() {
        
    }
}

// MARK: - Private functions
extension ProjectListViewModel {
    
    /// Выполнение запроса на получение проектов
    private func fetchProjectsRequest() {
        isDataSourceUpdated = false
        API.Project.getProjects.request(ProjectsResponse.self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.isDataSourceUpdated = true
                if let items = data.items, !items.isEmpty {
                    AppStorage.share.projects = items
                    self?.updateDataSource()
                } else {
                    AppLogger.log(.storage, AppError.contentError)
                    self?.delegate?.showError()
                }
            case .failure(let error):
                self?.isDataSourceUpdated = true
                AppLogger.log(.storage, error.localizedDescription)
                self?.delegate?.showError()
            }
        }
    }
    
    /// Обновление данных
    private func updateDataSource() {
        guard isDataSourceUpdated else { return }
        dataSource = AppStorage.share.projects.map { ProjectCellModel(iconUrl: $0.iconUrl, title: $0.name) }
        delegate?.updateTable()
    }
}

// MARK: - ProjectListViewModelProtocol
extension ProjectListViewModel: ProjectListViewModelProtocol {
    func fetchProjects() {
        fetchProjectsRequest()
    }
    
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
