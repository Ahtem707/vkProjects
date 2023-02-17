//
//  Storage.swift
//  vkProjects
//
//  Created by Ahtem Sitjalilov on 07.11.2022.
//

import Foundation

final class AppStorage {
    
    static var share: AppStorage!
    
    static func appStart() {
        AppStorage.share = AppStorage()
    }
    
    /// Проекты компании
    var projects: [ProjectsResponse.ProjectsItem] = []
    
    // User value
    @UserDefault("currentLevelIndex", 1)
    private(set) static var currentLevelIndex: Int
    
    /// Приватный инициализатор
    private init() {}
}
