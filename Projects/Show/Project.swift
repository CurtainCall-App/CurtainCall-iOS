//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 김민석 on 2/22/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Show",
    product: .staticFramework,
    dependencies: [
        .xcframework(path: .relativeToRoot("Frameworks/NMapsMap.xcframework")),
        .project(
            target: "Common",
            path: .relativeToRoot("Projects/Common")
        )
    ]
)
