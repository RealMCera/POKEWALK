import SwiftUI

struct WatchDashboardView: View {
    @EnvironmentObject private var pedometer: WatchPedometerService

    private let goal = 5_000

    private var progress: Double {
        min(Double(pedometer.steps) / Double(goal), 1)
    }

    private var miles: Double {
        pedometer.distanceMeters / 1609.344
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ZStack {
                    Circle()
                        .stroke(.secondary.opacity(0.2), lineWidth: 10)

                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(.primary, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                        .rotationEffect(.degrees(-90))

                    VStack(spacing: 2) {
                        Image(systemName: "figure.walk")
                            .font(.title3)
                        Text(pedometer.steps.formatted())
                            .font(.headline.monospacedDigit())
                        Text("steps")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                }
                .frame(width: 112, height: 112)

                VStack(spacing: 3) {
                    Text("Meadow Trail")
                        .font(.headline)
                    Text("\(Int(progress * 100))% complete")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                HStack {
                    Label(
                        miles.formatted(.number.precision(.fractionLength(2))),
                        systemImage: "map"
                    )
                    .font(.caption)

                    Spacer()

                    Label(
                        "\(max(goal - pedometer.steps, 0))",
                        systemImage: "flag.checkered"
                    )
                    .font(.caption)
                }

                if progress >= 1 {
                    Label("Trail complete!", systemImage: "checkmark.seal.fill")
                        .font(.caption.bold())
                }

                if let error = pedometer.errorMessage {
                    Text(error)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.horizontal, 4)
        }
        .navigationTitle("PokeWalk")
    }
}

#Preview {
    WatchDashboardView()
        .environmentObject(WatchPedometerService())
}
