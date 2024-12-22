//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 김민석 on 12/8/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "FavoriteShow",
    product: .staticFramework,
    dependencies: [
        .project(
            target: "Common",
            path: .relativeToRoot("Projects/Common")
        )
    ]
)

