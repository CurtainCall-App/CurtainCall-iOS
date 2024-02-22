//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 김민석 on 2/22/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Main",
    product: .staticFramework,
    dependencies: [
        .project(
            target: "Home",
            path: .relativeToRoot("Projects/Home")
        ),
        .project(
            target: "Show",
            path: .relativeToRoot("Projects/Show")
        ),
        .project(
            target: "Party",
            path: .relativeToRoot("Projects/Party")
        ),
        .project(
            target: "MyPage",
            path: .relativeToRoot("Projects/MyPage")
        )
    ]
)
