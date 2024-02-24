//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 김민석 on 2/22/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Home",
    product: .staticFramework,
    dependencies: [
        .project(
            target: "Common",
            path: .relativeToRoot("Projects/Common")
        )
    ]
)
