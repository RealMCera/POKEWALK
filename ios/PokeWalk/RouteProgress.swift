import Foundation

struct WalkingRoute {
    let name: String
    let targetSteps: Int
    let rewardName: String
}

enum RouteProgress {
    static let starterRoute = WalkingRoute(
        name: "Meadow Trail",
        targetSteps: 5_000,
        rewardName: "Trail Badge"
    )

    static func fraction(steps: Int, route: WalkingRoute) -> Double {
        guard route.targetSteps > 0 else { return 0 }
        return min(Double(steps) / Double(route.targetSteps), 1)
    }
}
