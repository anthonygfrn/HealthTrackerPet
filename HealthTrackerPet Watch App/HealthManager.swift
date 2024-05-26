import Foundation
import HealthKit

class HealthManager: ObservableObject {
    private var healthStore: HKHealthStore?
    
    @Published var steps: Double = 0
    @Published var calories: Double = 0
    @Published var manualCalories: Double = 0 // Manually inputted calories
    @Published var healthKitCaloriesTaken: Double = 0 // Calories taken from HealthKit
    @Published var workoutMinutes: Double = 0 // Workout time in minutes
    @Published var calorieLog: [CalorieLog] = [] // Log of manually inputted calories
    
    @Published var caloriesBurnedHistory: [Double] = Array(repeating: 0.0, count: 7)
    @Published var caloriesTakenHistory: [Double] = Array(repeating: 0.0, count: 7)

    var totalCaloriesTaken: Double {
        return manualCalories + healthKitCaloriesTaken
    }

    var caloriesBurned: Double {
        return calories
    }

    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()

            let typesToShare: Set<HKSampleType> = [] // We're not sharing data
            let typesToRead: Set<HKQuantityType> = [
                HKObjectType.quantityType(forIdentifier: .stepCount)!,
                HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
                HKObjectType.quantityType(forIdentifier: .dietaryEnergyConsumed)!, // Calories taken
                HKObjectType.quantityType(forIdentifier: .appleExerciseTime)! // Workout time
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
        let calendar = Calendar.current

        for dayOffset in 0..<7 {
            let startOfDay = calendar.startOfDay(for: Date().addingTimeInterval(TimeInterval(-dayOffset * 86400)))
            let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!

            let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay, options: .strictStartDate)

            fetchQuantityData(type: HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!, predicate: predicate) { statistics in
                DispatchQueue.main.async {
                    let burned = statistics?.sumQuantity()?.doubleValue(for: HKUnit.kilocalorie()) ?? 0
                    self.caloriesBurnedHistory[6 - dayOffset] = burned
                    if dayOffset == 0 {
                        self.calories = burned
                    }
                }
            }

            fetchQuantityData(type: HKObjectType.quantityType(forIdentifier: .dietaryEnergyConsumed)!, predicate: predicate) { statistics in
                DispatchQueue.main.async {
                    let taken = statistics?.sumQuantity()?.doubleValue(for: HKUnit.kilocalorie()) ?? 0
                    self.caloriesTakenHistory[6 - dayOffset] = taken
                    if dayOffset == 0 {
                        self.healthKitCaloriesTaken = taken
                    }
                }
            }

            fetchQuantityData(type: HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!, predicate: predicate) { statistics in
                DispatchQueue.main.async {
                    if dayOffset == 0 {
                        self.workoutMinutes = statistics?.sumQuantity()?.doubleValue(for: HKUnit.minute()) ?? 0
                    }
                }
            }
        }
    }

    private func fetchQuantityData(type: HKQuantityType, predicate: NSPredicate, completion: @escaping (HKStatistics?) -> Void) {
        let query = HKStatisticsQuery(quantityType: type,
                                      quantitySamplePredicate: predicate,
                                      options: .cumulativeSum) { _, statistics, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
            }
            completion(statistics)
        }
        healthStore?.execute(query)
    }

    func updateManualCaloriesTaken(calories: Double) {
        DispatchQueue.main.async {
            self.manualCalories += calories
            self.calorieLog.append(CalorieLog(date: Date(), calories: calories))
        }
    }

    func startJumpRopeSession() {
        // Placeholder for starting a jump rope session
    }

    func stopJumpRopeSession() {
        // Placeholder for stopping a jump rope session
    }

    func updateCaloriesBurned(calories: Double) {
        DispatchQueue.main.async {
            self.calories += calories
        }
    }

    func getCaloriesBurned(for day: Int) -> Double {
        return caloriesBurnedHistory[day]
    }

    func getCaloriesTaken(for day: Int) -> Double {
        return caloriesTakenHistory[day]
    }

    func getCalorieDifference(for day: Int) -> Double {
        return getCaloriesBurned(for: day) - getCaloriesTaken(for: day)
    }
}

struct CalorieLog: Identifiable {
    let id = UUID()
    let date: Date
    let calories: Double
}
