//
//  Dependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by 김민석 on 1/12/24.
//

import ProjectDescription

let dependencies = Dependencies(
    carthage: [],
    swiftPackageManager:
        SwiftPackageManagerDependencies([
            .remote(
                url: "https://github.com/pointfreeco/swift-composable-architecture",
                requirement: .upToNextMajor(from: "1.6.0")
            ),
            .remote(
                url: "https://github.com/Moya/Moya",
                requirement: .upToNextMajor(from: "15.0.0")
            )
            
        ]),
    platforms: [.iOS]
)
