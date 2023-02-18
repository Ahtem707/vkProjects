//
//  ProjectsListTests.swift
//  vkProjectsTests
//
//  Created by Ahtem Sitjalilov on 18.02.2023.
//

import XCTest
@testable import vkProjects

final class ProjectsListTests: XCTestCase {
    func checkDependencies() {
        var viewController: ProjectListViewController?
        XCTAssertNil(viewController)
        viewController = ProjectListViewController()
        XCTAssertNotNil(viewController)
        XCTAssertNil(viewController?.viewModel)
        viewController?.viewDidLoad()
        XCTAssertNotNil(viewController?.viewModel)
        viewController = nil
        XCTAssertNil(viewController?.viewModel)
        XCTAssertNil(viewController)
    }
}
