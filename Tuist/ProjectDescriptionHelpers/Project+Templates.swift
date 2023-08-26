import ProjectDescription

extension Project {
    public static func makeModul(
        name: String,
        orgainzationName: String = "TuistPractice",
        platform: Platform,
        deploymentTarget: DeploymentTarget = .iOS(targetVersion: "16.0", devices: [.iphone, .ipad]),
        product: Product,
        pakages: [Package] = [],
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements = [],
        dependencies: [TargetDependency] = [],
        infoPlist: InfoPlist = .default
    ) -> Project {
        let settings: Settings = .settings(
            base: [:],
            configurations: [
                .debug(name: .debug),
                .release(name: .release)
            ],
            defaultSettings: .recommended
        )

        let appTargat = Target(
            name: name,
            platform: platform,
            product: product,
            bundleId: "\(orgainzationName).\(name)",
            deploymentTarget: deploymentTarget,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            dependencies: dependencies,
            settings: settings
        )

        let targets = [appTargat]
        let schemes: [Scheme] = [.makeScheme(name: name, configurationName: .release)]

        return .init(
            name: name,
            organizationName: orgainzationName,
            packages: pakages,
            targets: targets,
            schemes: schemes,
            fileHeaderTemplate: nil
        )
    }
}

extension Scheme {
    public static func makeScheme(
        name: String,
        configurationName: ConfigurationName
    ) -> Scheme {
        return Scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            runAction: .runAction(configuration: configurationName),
            archiveAction: .archiveAction(configuration: configurationName),
            profileAction: .profileAction(configuration: configurationName),
            analyzeAction: .analyzeAction(configuration: configurationName)
        )
    }
}
