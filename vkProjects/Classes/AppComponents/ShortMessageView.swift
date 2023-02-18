//
//  ShortMessageView.swift
//  vkProjects
//
//  Created by Ahtem Sitjalilov on 17.02.2023.
//

import UIKit

final class ShortMessageViewFactory {
    private let shortMessage = ShortMessageView()
    private let animateDuration: Double = 1
    private let showDuration: Int = 3
    private var offset: CGFloat = 100
    
    weak var viewController: UIViewController?
    var message: String = "" {
        didSet {
            shortMessage.messageLabel.text = message
        }
    }
    var status: ShortMessageStatus = .success {
        didSet {
            shortMessage.backgroundColor = status.color
        }
    }
    
    func initialize() {
        guard let view = viewController?.view else { return }
        let viewWidth = view.bounds.size.width
        let horizontalPadding = CGFloat(10)
        let width = viewWidth - horizontalPadding * 2
        let size = CGSize(width: width, height: 50)
        let point = CGPoint(x: horizontalPadding, y: -offset)
        shortMessage.frame = CGRect(origin: point, size: size)
        shortMessage.layer.zPosition = 10
        shortMessage.layer.cornerRadius = 5
        view.addSubview(shortMessage)
        
        if let navBarHeight = viewController?.navigationController?.navigationBar.frame.height {
            offset = UIApplication.shared.statusBarFrame.height + navBarHeight + 10
        }
    }
    
    /// Короткий показ уведомления
    func show() {
        self.showView {
            self.duration {
                self.hideView()
            }
        }
    }
    
    /// Отобразить
    private func showView(completion: @escaping ()->Void) {
        UIView.animate(
            withDuration: animateDuration,
            animations: {
                self.shortMessage.frame.origin.y = self.offset
            },
            completion: { _ in
                completion()
            }
        )
    }
    
    /// Скрыть
    private func hideView(completion: (()->Void)? = nil) {
        UIView.animate(
            withDuration: animateDuration,
            animations: {
                self.shortMessage.frame.origin.y = -self.offset
            },
            completion: { _ in
                completion?()
            }
        )
    }
    
    /// Задержка
    private func duration(completion: @escaping ()->Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(showDuration)) {
            completion()
        }
    }
}

enum ShortMessageStatus {
    case error
    case success
    
    var color: UIColor {
        switch self {
        case .error: return AppColor.View.error
        case .success: return AppColor.View.success
        }
    }
}

final class ShortMessageView: UIView {
    
    fileprivate let messageLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubview()
        setupLayous()
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubview()
        setupLayous()
        setupAppearance()
    }
}

// MARK: - Setup functions
extension ShortMessageView {
    private func setupSubview() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(messageLabel)
    }
    
    private func setupLayous() {
        messageLabel.pinToSuperview(edges: .all, insets: UIEdgeInsets(all: 10))
    }
    
    private func setupAppearance() {
        messageLabel.font = AppFont.font(style: .regular, size: 18)
        messageLabel.textColor = AppColor.Text.white
    }
}
