import SwiftUI

struct DashboardView: View {
    @EnvironmentObject private var pedometer: PedometerService
    private let route = RouteProgress.starterRoute

    private var miles: Double {
        pedometer.distanceMeters / 1609.344
    }

    private var progress: Double {
        RouteProgress.fraction(steps: pedometer.steps, route: route)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    headerCard
                    statsCard
                    routeCard

                    if let error = pedometer.errorMessage {
                        Text(error)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding()
            }
            .navigationTitle("PokeWalk")
            .refreshable {
                pedometer.refreshToday()
            }
        }
    }

    private var headerCard: some View {
        VStack(spacing: 10) {
            Image(systemName: "figure.walk.circle.fill")
                .font(.system(size: 64))
                .symbolRenderingMode(.hierarchical)

            Text("Today's Walk")
                .font(.title2.bold())

            Text(pedometer.isAvailable
                 ? "Your iPhone is counting steps automatically."
                 : "Step counting isn't available on this device.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(24)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 24))
    }

    private var statsCard: some View {
        HStack(spacing: 12) {
            stat(title: "Steps", value: pedometer.steps.formatted(), icon: "shoeprints.fill")
            stat(title: "Miles", value: miles.formatted(.number.precision(.fractionLength(2))), icon: "map.fill")
        }
    }

    private func stat(title: String, value: String, icon: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
            Text(value)
                .font(.title2.bold())
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 18))
    }

    private var routeCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(route.name)
                        .font(.headline)
                    Text("\(pedometer.steps.formatted()) / \(route.targetSteps.formatted()) steps")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: progress >= 1 ? "checkmark.seal.fill" : "flag.checkered")
                    .font(.title2)
            }

            ProgressView(value: progress)

            Text(progress >= 1
                 ? "Route complete — you earned the \(route.rewardName)."
                 : "Keep walking to finish today's route.")
                .font(.subheadline)
        }
        .padding()
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 18))
    }
}

#Preview {
    DashboardView()
        .environmentObject(PedometerService())
}
