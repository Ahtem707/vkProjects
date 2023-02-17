//
//  UnderlinedLabel.swift
//  vkProjects
//
//  Created by Ahtem Sitjalilov on 17.02.2023.
//

import UIKit

final class UnderlinedLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override var text: String? {
        didSet {
            guard let text = text else { return }
            
            let textRange = NSRange(location: 0, length: text.count)
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(
                .underlineStyle,
                value: NSUnderlineStyle.single.rawValue,
                range: textRange
            )
            
            // Add other attributes if needed
            self.attributedText = attributedText
        }
    }
    
    private func configure() {
        isUserInteractionEnabled = true
    }
}
