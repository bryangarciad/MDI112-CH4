import Foundation
import Combine
import HealthKit

class HealthKitManager {
    static let shared = HealthKitManager()
    private init() {}

    let healthStore = HKHealthStore() // health store -> samples (calories, heart rate)

    let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
    let heartRateUnit = HKUnit(from: "count") // BPMs


    var isHealthKitIsAvailable: Bool {
        HKHealthStore.isHealthKitIsAvailable()
    }

    // MARK: - Deal with Authorization
    func requestAuthorization() async throws {
        let typesToRead: Set<HKObjectType> = [heartRateType]
        let typesToWrite: Set<HKSampleType> = []

        try await healthStore.requestAuthorization(toShare: typesToWrite, read: typesToRead)
    }

    func checkAuthorizationStatus() -> HKAuthorizationStatus {
        healthStore.authorizationStatus(for: heartRateType)
    }

    // Query
    func fetchLatestHeartRate() async throws -> HeartRateSample? {
        return try await withCheckedThrowingContinuation { continuation in 
            // Order For the Data
            let sortDescriptorForStartDate = NSSortDescriptor(
                key: HKSampleSortIdentifierStartDate, // start date for the measurement to be taken
                ascending: false
            )

            let query = HKSampleQuery(
                sampleType: heartRateType,
                predicate: nil,
                limit: 1,
                sortDescriptor: [sortDescriptor]
            ) { query, samples, error in
                if let error = error {
                    continuation.resume(throwing: error)
                }

                guard let sample = samples?.first as? HKQuantitySample else {
                    continuation.resume(returning: nil)
                    return
                }

                let bpm = sample.quantity.doubleValue(for: self.heartRateUnit)
                continuation.resume(returning: bpm)
            }

            healthStore.execute(query)

        }
    }

}