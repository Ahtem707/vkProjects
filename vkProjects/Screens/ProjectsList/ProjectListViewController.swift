//
//  ProjectListViewController.swift
//  vkProjects
//
//  Created by Ahtem Sitjalilov on 17.02.2023.
//

import UIKit

final class ProjectListViewController: BaseViewController {
    
    // MARK: - Public variables
    var viewModel: ProjectListViewModelProtocol!
    
    // MARK: - Private variables
    let tableView = UITableView()
    
    // MARK: - Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setupSubviews()
        setupLayouts()
        setupContent()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        tableView.reloadData()
//    }
}

// MARK: - Setup functions
extension ProjectListViewController {
    private func configure() {
        let viewModel = ProjectListViewModel()
        viewModel.delegate = self
        viewModel.fetchProjects()
        self.viewModel = viewModel
    }
    
    private func setupSubviews() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.registerCellClass(ProjectCell.self)
    }
    
    private func setupLayouts() {
        tableView.pinToSuperview(safeArea: true)
    }
    
    private func setupContent() {
        title = viewModel.getViewTitle()
    }
}

// MARK: - ProjectListViewControllerDelegate
extension ProjectListViewController: ProjectListViewControllerDelegate {
    func updateDataSource() {
        tableView.reloadData()
    }
    
    func pushViewController(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showError(message: String) {
        showShortMessage(message: message, status: .error)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ProjectListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getTableCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProjectCell = tableView.dequeue(cellForRowAt: indexPath)
        cell.setupContent(model: viewModel.getTableItem(indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem(indexPath)
    }
}
