//
//  vkProjectsTests.swift
//  vkProjectsTests
//
//  Created by Ahtem Sitjalilov on 17.02.2023.
//

import XCTest
@testable import vkProjects

final class vkProjectsTests: XCTestCase {

    func testExample() throws {
        let projectListTests = ProjectsListTests()
        projectListTests.checkDependencies()
    }
}
