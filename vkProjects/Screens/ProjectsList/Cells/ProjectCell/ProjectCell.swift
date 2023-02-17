//
//  ProjectsCell.swift
//  vkProjects
//
//  Created by Ahtem Sitjalilov on 17.02.2023.
//

import UIKit
import SDWebImage

struct ProjectCellLayouts {
    let horizontalMargingEdge = UIEdgeInsets(all: 16)
    let verticalMargingEdge = UIEdgeInsets(all: 10)
    let iconViewSize = CGSize(width: 40, height: 40)
}

struct ProjectCellAppearance {
    let titleLabelFont = AppFont.font(style: .regular, size: 18)
    let titleLabelColor = AppColor.Text.primary
    let selectedGhostDuration = 1
}

class ProjectCell: UITableViewCell {
    
    // MARK: - Private variables
    
    private let layouts = ProjectCellLayouts()
    private let appearance = ProjectCellAppearance()
    
    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    
    // MARK: - Lifecycle functions
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubview()
        setupLayouts()
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubview()
        setupLayouts()
        setupAppearance()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Небольшая заддержка для визуализации выбора
        selectionStyle = .default
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(appearance.selectedGhostDuration)) { [weak self] in
            self?.selectionStyle = .none
        }
    }
}

// MARK: - Public functions
extension ProjectCell {
    func setupContent(model: ProjectCellModel) {
        iconView.sd_setImage(
            with: URL(string: model.iconUrl),
            placeholderImage: AppImage.emptyApp,
            options: .highPriority
        )
        titleLabel.text = model.title
    }
}

// MARK: - Setup functions
extension ProjectCell {
    private func setupSubview() {
        iconView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)
    }
    
    private func setupLayouts() {
        iconView.pinToSuperview(edges: [.left], insets: layouts.horizontalMargingEdge)
        iconView.pinToSuperview(edges: [.top, .bottom], insets: layouts.verticalMargingEdge)
        iconView.pin(size: layouts.iconViewSize)
        iconView.pinRight(toLeft: titleLabel, spacing: layouts.horizontalMargingEdge.right)
        titleLabel.pinToSuperview(edges: [.right], insets: layouts.horizontalMargingEdge)
        titleLabel.pinCenterToSuperview(of: .vertical)
    }
    
    private func setupAppearance() {
        titleLabel.font = appearance.titleLabelFont
        titleLabel.textColor = appearance.titleLabelColor
    }
}
