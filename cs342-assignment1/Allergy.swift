//
//  Allergy.swift
//  cs342-assignment1
//
//  Created by Shreya D'Souza on 1/12/25.
//

// This class adds additional functionality to keep track of patient allergies
struct Allergy{
    let allergen:String
    var reaction:String
    var severity: AllergySeverityEnum
    
    // Resource: https://chatgpt.com/share/67841781-0660-800d-9a81-00dede6d995c
    enum AllergySeverityEnum: String {
        case mild = "Mild"          // Localized, minimal symptoms
        case moderate = "Moderate"  // Noticeable, manageable symptoms
        case severe = "Severe"      // Significant symptoms, may require medical attention
        case anaphylaxis = "Anaphylaxis" // Life-threatening emergency
    }
    
    init(allergen: String, reaction: String, severity: AllergySeverityEnum) {
        self.allergen = allergen
        self.reaction = reaction
        self.severity = severity
    }
}
