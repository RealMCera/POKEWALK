import SwiftUI

@main
struct PokeWalkWatchApp: App {
    @StateObject private var pedometer = WatchPedometerService()

    var body: some Scene {
        WindowGroup {
            WatchDashboardView()
                .environmentObject(pedometer)
        }
    }
}
