import CoreMotion
import Foundation

@MainActor
final class WatchPedometerService: ObservableObject {
    @Published var steps: Int = 0
    @Published var distanceMeters: Double = 0
    @Published var isAvailable = CMPedometer.isStepCountingAvailable()
    @Published var errorMessage: String?

    private let pedometer = CMPedometer()

    init() {
        refreshToday()
        startLiveUpdates()
    }

    func refreshToday() {
        guard CMPedometer.isStepCountingAvailable() else {
            isAvailable = false
            return
        }

        let start = Calendar.current.startOfDay(for: Date())
        pedometer.queryPedometerData(from: start, to: Date()) { [weak self] data, error in
            Task { @MainActor in
                guard let self else { return }

                if let error {
                    self.errorMessage = error.localizedDescription
                    return
                }

                self.apply(data)
            }
        }
    }

    private func startLiveUpdates() {
        guard CMPedometer.isStepCountingAvailable() else { return }

        let start = Calendar.current.startOfDay(for: Date())
        pedometer.startUpdates(from: start) { [weak self] data, error in
            Task { @MainActor in
                guard let self else { return }

                if let error {
                    self.errorMessage = error.localizedDescription
                    return
                }

                self.apply(data)
            }
        }
    }

    private func apply(_ data: CMPedometerData?) {
        guard let data else { return }
        steps = data.numberOfSteps.intValue
        distanceMeters = data.distance?.doubleValue ?? 0
    }
}
