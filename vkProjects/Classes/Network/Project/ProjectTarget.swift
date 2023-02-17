//
//  ServiceTarget.swift
//  vkProjects
//
//  Created by Ahtem Sitjalilov on 17.02.2023.
//

import Foundation

extension API {
    enum Project: Target {
        
        case getProjects
        
        // MARK: - Internal
        
        var path: String {
            switch self {
            case .getProjects:
                return "https://mobile-olympiad-trajectory.hb.bizmrg.com/semi-final-data.json"
            }
        }
        
        var method: HTTPMethod {
            return .get
        }
        
        var headers: [String : Any] {
            return [:]
        }
        
        var query: [String : Any] {
            return [:]
        }
        
        var body: Data {
            return Data()
        }
        
        var sampleData: Data {
            switch self {
            case .getProjects:
                return Data.json(fileName: "projects", with: .json)
            }
        }
    }
}
