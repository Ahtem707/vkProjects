//
//  BuildConfig.swift
//  vkProjects
//
//  Created by Ahtem Sitjalilov on 07.11.2022.
//

import Foundation

struct BuildConfig {
    
    static let baseUrl: String = {
        return ""
    }()
    
    static let loggingEnabled: Bool = {
        #if PRODUCTION
            return false
        #elseif DEBUG
            return true
        #else
            return true
        #endif
    }()
}
