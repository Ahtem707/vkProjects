//
//  ProjectsResponse.swift
//  vkProjects
//
//  Created by Ahtem Sitjalilov on 17.02.2023.
//

import Foundation

struct ProjectsResponse: Codable {
    
    enum CodingKeys: String, CodingKey {
        case items
    }
    
    let items: [ProjectsItem]?
}

extension ProjectsResponse {
    struct ProjectsItem: Codable {
        enum CodingKeys: String, CodingKey {
            case name
            case description
            case iconUrl = "icon_url"
            case serviceUrl = "service_url"
        }
        
        let name: String
        let description: String
        let iconUrl: String
        let serviceUrl: String
    }
}
