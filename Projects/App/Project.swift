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
        ),
        .project(
            target: "Login",
            path: .relativeToRoot("Projects/Login")
        )
    ],
    resources: ["Resources/**"],
    entitlements: .file(path: .relativeToRoot("Projects/App/Resources/App.entitlements")),
    infoPlist: .file(path: "Support/Info.plist")
)
