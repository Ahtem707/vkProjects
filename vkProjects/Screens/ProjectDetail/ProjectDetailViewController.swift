//
//  ProjectDetailViewController.swift
//  vkProjects
//
//  Created by Ahtem Sitjalilov on 17.02.2023.
//

import UIKit
import SDWebImage

struct ProjectDetailViewControllerLayouts {
    let iconViewSize = CGSize(width: 100, height: 100)
    let iconViewEdges = UIEdgeInsets(all: 40)
    let titleLabelEdgges = UIEdgeInsets(all: 20)
    let descriptionLabelEdgges = UIEdgeInsets(all: 20)
    let linkLabelEdgges = UIEdgeInsets(all: 20)
}

struct ProjectDetailViewControllerAppearance {
    let titleLabelFont = AppFont.font(style: .regular, size: 22)
    let titleLabelColor = AppColor.Text.primary
    let descriptionLabelFont = AppFont.font(style: .regular, size: 16)
    let descriptionLabelColor = AppColor.Text.secondary
    let linkLabelFont = AppFont.font(style: .regular, size: 16)
    let linkLabelColor = AppColor.Text.link
}

final class ProjectDetailViewController: BaseViewController {
    
    // MARK: - Public variables
    
    var viewModel: ProjectDetailViewModelProtocol!
    var projectData: ProjectsResponse.ProjectsItem?
    
    // MARK: - Private variables
    
    private let layouts = ProjectDetailViewControllerLayouts()
    private let appearance = ProjectDetailViewControllerAppearance()
    
    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let linkLabel = UnderlinedLabel()
    
    // MARK: - Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setupSubviews()
        setupLayouts()
        setupAppearance()
        setupContent()
    }
}

// MARK: - Setup functions
extension ProjectDetailViewController {
    private func configure() {
        viewModel = ProjectDetailViewModel()
        (viewModel as? ProjectDetailViewModel)?.delegate = self
    }
    
    private func setupSubviews() {
        iconView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        linkLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(iconView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(linkLabel)
        
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = .byWordWrapping
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didSelectLink))
        linkLabel.addGestureRecognizer(tap)
    }
    
    private func setupLayouts() {
        iconView.pin(size: layouts.iconViewSize)
        iconView.pinCenterToSuperview(of: .horizontal)
        iconView.pinToSuperview(edges: [.top], insets: layouts.iconViewEdges, safeArea: true)
        iconView.pinBottom(toTop: titleLabel, spacing: layouts.titleLabelEdgges.top)
        titleLabel.pinToSuperview(edges: [.left, .right], insets: layouts.titleLabelEdgges)
        titleLabel.pinBottom(toTop: descriptionLabel, spacing: layouts.descriptionLabelEdgges.top)
        descriptionLabel.pinToSuperview(edges: [.left, .right], insets: layouts.descriptionLabelEdgges)
        descriptionLabel.pinBottom(toTop: linkLabel, spacing: layouts.linkLabelEdgges.top)
        linkLabel.pinToSuperview(edges: [.left, .right], insets: layouts.linkLabelEdgges)
    }
    
    private func setupAppearance() {
        titleLabel.font = appearance.titleLabelFont
        titleLabel.textColor = appearance.titleLabelColor
        descriptionLabel.font = appearance.descriptionLabelFont
        descriptionLabel.textColor = appearance.descriptionLabelColor
        linkLabel.font = appearance.linkLabelFont
        linkLabel.textColor = appearance.linkLabelColor
    }
    
    private func setupContent() {
        guard let projectData = projectData else { return }
        title = projectData.name
        iconView.sd_setImage(
            with: URL(string: projectData.iconUrl),
            placeholderImage: AppImage.emptyApp,
            options: [.highPriority]
        )
        titleLabel.text = projectData.name
        descriptionLabel.text = projectData.description
        linkLabel.text = projectData.serviceUrl
    }
    
    @objc private func didSelectLink(_ selector: UILabel) {
        guard let projectData = projectData else { return }
        let url = URL(string: projectData.serviceUrl)
        viewModel.didSelectLink(url: url)
    }
}

// MARK: - ProjectDetailViewControllerDelegate
extension ProjectDetailViewController: ProjectDetailViewControllerDelegate {
    func presentViewController(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}
