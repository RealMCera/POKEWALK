import SwiftUI

@main
struct PokeWalkApp: App {
    @StateObject private var pedometer = PedometerService()

    var body: some Scene {
        WindowGroup {
            DashboardView()
                .environmentObject(pedometer)
        }
    }
}
