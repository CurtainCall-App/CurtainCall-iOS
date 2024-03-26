//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 김민석 on 3/16/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Review",
    product: .staticFramework,
    dependencies: [
        .project(
            target: "Common",
            path: .relativeToRoot("Projects/Common")
        ),
    ]
)
