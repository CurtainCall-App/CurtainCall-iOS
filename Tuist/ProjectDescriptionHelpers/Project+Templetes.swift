import ProjectDescription

public extension Project {
    static func makeModule(
        name: String,
        destinations: Destinations = .iOS,
        product: Product,
        packages: [Package] = [],
        deploymentTargets: DeploymentTargets? = .iOS("17.0"),
        dependencies: [TargetDependency] = [],
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements? = nil,
        entitlements: Entitlements? = nil,
        infoPlist: InfoPlist = .default,
        path: Path? = nil
    ) -> Project {
        let setting: Settings = .settings(
            base: [:],  // Build Setting에 반영
            configurations: [
                .debug(
                    name: .debug,
                    settings: SettingsDictionary()
                        .automaticCodeSigning(devTeam: "H2N9KXXP3M"),
                    xcconfig: path
                ),
                .release(
                    name: .release,
                    settings: SettingsDictionary()
                        .automaticCodeSigning(devTeam: "H2N9KXXP3M"),
                    xcconfig: path
                )
            ], defaultSettings: .recommended)

        let appTarget = Target(
            name: name,
            destinations: destinations,
            product: product,
            bundleId: "com.mandos.curtain.call",
            deploymentTargets: deploymentTargets,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            entitlements: entitlements,
            dependencies: dependencies,
            settings: .settings(
                configurations: [
                    .debug(name: .debug, xcconfig: path),
                    .release(name: .release, xcconfig: path)
                ]
            )
        )

        let schemes: [Scheme] = [.makeScheme(target: .debug, name: name)]
        
        let target: [Target] = [appTarget]
        
        return Project(
            name: name,
            organizationName: nil,
            packages: packages,
            settings: setting,
            targets: target,
            schemes: schemes
        )
    }
}

extension Scheme {
    static func makeScheme(target: ConfigurationName, name: String) -> Scheme {
        return Scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            runAction: .runAction(configuration: target),
            archiveAction: .archiveAction(configuration: target),
            profileAction: .profileAction(configuration: target),
            analyzeAction: .analyzeAction(configuration: target)
        )
    }
}
