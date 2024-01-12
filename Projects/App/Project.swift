//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 김민석 on 1/12/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "App",
    destinations: .iOS,
    product: .app,
    dependencies: [
        .project(
            target: "Common",
            path: .relativeToRoot("Projects/Common")
        )
    ],
    resources: ["Resources/**"],
    infoPlist: .file(path: "Support/Info.plist")
)
