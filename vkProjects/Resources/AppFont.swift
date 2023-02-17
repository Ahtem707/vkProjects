//
//  AppFont.swift
//  vkProjects
//
//  Created by Ahtem Sitjalilov on 05.11.2022.
//

import Foundation

import UIKit

enum FontStyle: String {
    case ultraLight = "UIFontWeightUltraLight"
    case thin = "UIFontWeightThin"
    case light = "UIFontWeightLight"
    case regular = "UIFontWeightRegular"
    case medium = "UIFontWeightMedium"
    case semibold = "UIFontWeightSemibold"
    case bold = "UIFontWeightBold"
    case heavy = "UIFontWeightHeavy"
}

class AppFont: UIFont {
    
    static func font(style: FontStyle, size: CGFloat) -> UIFont {
        UIFont(name: style.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
