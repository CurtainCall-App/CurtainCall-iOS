//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 김민석 on 1/15/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Login",
    product: .staticFramework,
    dependencies: [
        .xcframework(path: .relativeToRoot("Frameworks/NaverThirdPartyLogin.xcframework")),
        .external(name: "KakaoSDKCommon"),
        .external(name: "KakaoSDKAuth"),
        .external(name: "KakaoSDKUser"),
        .project(
            target: "Common",
            path: .relativeToRoot("Projects/Common")
        )
    ]
)
