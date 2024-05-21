//
//  HealthManager.swift
//  HealthTrackerPet Watch App
//
//  Created by Anthony on 20/05/24.
//

import Foundation
import HealthKit

class HealthManager: ObservableObject {
    private var healthStore: HKHealthStore?
    
    @Published var steps: Double = 0
    @Published var calories: Double = 0

    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
            
            let typesToShare: Set<HKSampleType> = [] // We're not sharing data
            let typesToRead: Set<HKQuantityType> = [
                .quantityType(forIdentifier: .stepCount)!,
                .quantityType(forIdentifier: .activeEnergyBurned)!
            ]

            healthStore?.requestAuthorization(toShare: typesToShare, read: typesToRead) { success, error in
                if success {
                    self.fetchHealthData()
                } else if let error = error {
                    print("Error requesting authorization: \(error.localizedDescription)")
                }
            }
        }
    }

    func fetchHealthData() {
        let startOfDay = Calendar.current.startOfDay(for: Date())
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: Date(), options: .strictStartDate)

        fetchQuantityData(type: .quantityType(forIdentifier: .stepCount)!, predicate: predicate) { statistics in
            self.steps = statistics?.sumQuantity()?.doubleValue(for: HKUnit.count()) ?? 0
        }

        fetchQuantityData(type: .quantityType(forIdentifier: .activeEnergyBurned)!, predicate: predicate) { statistics in
            self.calories = statistics?.sumQuantity()?.doubleValue(for: HKUnit.kilocalorie()) ?? 0
        }
    }

    private func fetchQuantityData(type: HKQuantityType, predicate: NSPredicate, completion: @escaping (HKStatistics?) -> Void) {
        let query = HKStatisticsQuery(quantityType: type,
                                      quantitySamplePredicate: predicate,
                                      options: .cumulativeSum,
                                      completionHandler: { _, statistics, error in
                                        if let error = error {
                                        print("Error fetching data: \(error.localizedDescription)")
                                        }
                                        completion(statistics)
        })
        healthStore?.execute(query)
    }
}
