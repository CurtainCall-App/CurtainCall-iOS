//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 김민석 on 1/20/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Signup",
    product: .staticFramework,
    dependencies: [
        .project(
            target: "Common",
            path: .relativeToRoot("Projects/Common")
        )
    ]
)
