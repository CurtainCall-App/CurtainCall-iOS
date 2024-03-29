//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 김민석 on 1/12/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Common",
    product: .staticFramework,
    dependencies: [
        .external(name: "ComposableArchitecture"),
        .external(name: "Moya")
    ],
    sources: ["Sources/**", "Secret/**"],
    resources: ["Resources/**"]
)
