//
//  Patient.swift
//  cs342-assignment1
//
//  Created by Shreya D'Souza on 1/11/25.
//


import Foundation

// This class defines a Patient and includes functions to get patient information
class Patient {
    let medicalRecordNumber:Int // ID must stay consistent
    var firstName: String // legal name might change over time
    var lastName: String
    let dob: Date // date of birth cannot change
    var height: Double // height can change over time
    var weight: Double // weight can change over time
    var bloodType: BloodType.BloodTypeEnum // blood type can go from unknown to a defined type
    var medications: [Medication] // medications can change over time
    var email: String? // Optional
    var allergies: [Allergy]
    
    init(medicalRecordNumber: Int, firstName: String, lastName: String, dob: Date, height: Double, weight: Double, bloodType: BloodType.BloodTypeEnum = BloodType.BloodTypeEnum.unknown, medications: [Medication] = [], email: String? = nil, allergies: [Allergy] = []) {
        self.medicalRecordNumber = medicalRecordNumber
        self.firstName = firstName
        self.lastName = lastName
        self.dob = dob
        self.height = height
        self.weight = weight
        self.bloodType = bloodType
        self.medications = medications
        self.email = email
        self.allergies = allergies
    }
    
    // Get patient information to add to a list
    func getPatientInformation() -> String {
        let age = Calendar.current.dateComponents([.year], from: dob, to: Date()).year
        return "\(lastName), \(firstName) (\(age!))"
    }
    
    // Filters medications based on them not being complete and sorts by date prescribed
    func getCurrentMedications() -> [Medication] {
        medications.filter({!$0.isCompleted}).sorted(by:{ $0.datePrescribed<$1.datePrescribed })
    }
    
    // Defines errors
    enum PrescriptionError: Error {
        case duplicateMedication(String)
        case allergicMedication(String)
    }
    
    // Prescribes a new medication to a patient, checking whether there are not any duplicate medications and allergies
    func prescribeMedication(medication: Medication) throws {
        // Checks if the patient is currently taking the medication
       if medications.contains(where: { $0.name == medication.name && !$0.isCompleted }) {
           throw PrescriptionError.duplicateMedication("Medication \(medication.name) is already prescribed")
           // Checks if the patient is allergic to the medication
       } else if allergies.contains(where: { $0.allergen == medication.name}) {
           throw PrescriptionError.allergicMedication("Patient is allergic to medication \(medication.name)")
       }
       medications.append(medication)
   }
    
    // Determines the donor blood types the patient can receive a transfusion from
    func getDonorBloodTypes() -> [BloodType.BloodTypeEnum] {
        switch bloodType {
        case BloodType.BloodTypeEnum.aPositive:
            return [BloodType.BloodTypeEnum.aPositive,
                    BloodType.BloodTypeEnum.aNegative,
                    BloodType.BloodTypeEnum.oPositive,
                    BloodType.BloodTypeEnum.oNegative]
            
        case BloodType.BloodTypeEnum.aNegative:
            return [BloodType.BloodTypeEnum.aNegative,
                    BloodType.BloodTypeEnum.oNegative]
            
        case BloodType.BloodTypeEnum.bPositive:
            return [BloodType.BloodTypeEnum.bPositive,
                    BloodType.BloodTypeEnum.bNegative,
                    BloodType.BloodTypeEnum.oPositive,
                    BloodType.BloodTypeEnum.oNegative]
            
        case BloodType.BloodTypeEnum.bNegative:
            return [BloodType.BloodTypeEnum.bNegative,
                    BloodType.BloodTypeEnum.oNegative]
            
        case BloodType.BloodTypeEnum.abPositive:
            return [BloodType.BloodTypeEnum.aPositive,
                    BloodType.BloodTypeEnum.aNegative,
                    BloodType.BloodTypeEnum.bPositive,
                    BloodType.BloodTypeEnum.bNegative,
                    BloodType.BloodTypeEnum.oPositive,
                    BloodType.BloodTypeEnum.oNegative,
                    BloodType.BloodTypeEnum.abPositive,
                    BloodType.BloodTypeEnum.abNegative]
            
        case BloodType.BloodTypeEnum.abNegative:
            return [BloodType.BloodTypeEnum.aNegative,
                    BloodType.BloodTypeEnum.bNegative,
                    BloodType.BloodTypeEnum.oNegative,
                    BloodType.BloodTypeEnum.abNegative]
            
        case BloodType.BloodTypeEnum.oPositive:
            return [BloodType.BloodTypeEnum.oPositive,
                    BloodType.BloodTypeEnum.oNegative]
            
        case BloodType.BloodTypeEnum.oNegative:
            return [BloodType.BloodTypeEnum.oNegative]
            
        default:
            return []
        }
    }
        
}

