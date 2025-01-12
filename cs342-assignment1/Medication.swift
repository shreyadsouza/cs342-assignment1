//
//  Medication.swift
//  cs342-assignment1
//
//  Created by Shreya D'Souza on 1/11/25.
//

import Foundation

// This defines the Medication type
struct Medication {
    let datePrescribed: Date
    let name: String
    let dose: String
    let route: String
    let frequency: Int // Number of times the medication is taken per day
    let duration: Int
    
    // No default values used for initialization - each of these should be defined when presecribing a medication
    init(datePrescribed: Date, name: String, dose: String , route: String, frequency: Int, duration: Int) {
        self.datePrescribed = datePrescribed
        self.name = name
        self.dose = dose
        self.route = route
        self.frequency = frequency
        self.duration = duration
    }
    
    // Docs: https://developer.apple.com/documentation/foundation/nscalendar/1409577-date
    // ChatGPT: https://chatgpt.com/share/678417f4-7034-800d-a3d2-0813d846b18f
    var endDate: Date {
        Calendar.current.date(byAdding: .day, value: duration, to: datePrescribed)!
    }
    
    // Used to keep track of whether a prescribed medication has been comleted for filtering
    var isCompleted: Bool {
        Date() > endDate
    }
}
