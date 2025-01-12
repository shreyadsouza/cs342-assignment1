//
//  cs342_assignment1Tests.swift
//  cs342-assignment1Tests
//
//  Created by Shreya D'Souza on 1/11/25.
//

import Testing
@testable import cs342_assignment1
import Foundation

struct cs342_assignment1Tests {
    
    // Defines a patient to be used in all Unit tests
    var patient: Patient = {
        // Defines patient allergy to penecillin
        let patientAllergy = Allergy(allergen: "Penicillin", reaction: "Skin rash", severity: Allergy.AllergySeverityEnum.mild)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return Patient(
            medicalRecordNumber: 12345,
            firstName: "Jane",
            lastName: "Doe",
            dob: dateFormatter.date(from: "11/21/1999")!,
            height: 156,
            weight: 100,
            allergies: [patientAllergy]
        )
    }()
    
    // These five medications define example prescritions for the patient to test error throwing and ordering of prescriptions.
    let medication1: Medication = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return Medication(datePrescribed: dateFormatter.date(from: "01/02/2025")!, name: "Metoprolol", dose: "25 mg", route: "by mouth", frequency: 1, duration: 90)
    }()
    
    let medication2: Medication = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return Medication(datePrescribed: dateFormatter.date(from: "01/01/2025")!, name: "Aspirin", dose: "81 mg", route: "by mouth", frequency: 1, duration: 90)
    }()
    
    
    let medication3: Medication = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return Medication(datePrescribed: dateFormatter.date(from: "01/03/2025")!, name: "Metoprolol", dose: "25 mg", route: "by mouth", frequency: 1, duration: 90)
    }()
    
    // Medication is completed and should not show up in lists
    let medication4: Medication = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return Medication(datePrescribed: dateFormatter.date(from: "01/03/2024")!, name: "Metoprolol", dose: "25 mg", route: "by mouth", frequency: 1, duration: 90)
    }()
    
    // Used to test allergy to penicillin
    let medication5: Medication = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return Medication(datePrescribed: dateFormatter.date(from: "01/04/2024")!, name: "Penicillin", dose: "25 mg", route: "by mouth", frequency: 1, duration: 7)
    }()
    
   
    
    // TESTS BEGIN HERE
    
    // Checks that the default value for blood type is being initialized correctly.
    @Test func testBloodTypeDefault() async throws {
        let bloodtype = BloodType()
        #expect(bloodtype.bloodType == BloodType.BloodTypeEnum.unknown)
    }
    
    // Checks values after patient intialization
    @Test func testPatientInitialization() async throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        #expect(patient.medicalRecordNumber == 12345)
        #expect(patient.firstName == "Jane")
        #expect(patient.lastName == "Doe")
        #expect(patient.dob == dateFormatter.date(from: "11/21/1999")!)
        #expect(patient.height == 156)
        #expect(patient.weight == 100)
        // Blood type initially unknown
        #expect(patient.bloodType == BloodType.BloodTypeEnum.unknown)
        // No medications assigned to patient at initialization
        #expect(patient.medications.count == 0)
    }
    
    // Checks assignment of blood type from unknown to O+
    @Test func testBloodTypeAssignment() async throws {
        patient.bloodType = BloodType.BloodTypeEnum.oPositive
        #expect(patient.bloodType == BloodType.BloodTypeEnum.oPositive)
    }
    
    // Tests function to get patient's full name and age
    @Test func testPatientInformation() async throws {
        let info = patient.getPatientInformation()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        #expect(patient.dob == dateFormatter.date(from: "11/21/1999")!)
        #expect(info=="Doe, Jane (25)")
    }
    
    // Tests simply adding a valid medication for the patient
    @Test func testAddMedication() async throws {
        patient.medications.append(medication1)
        print(medication1.endDate)
        print(patient.getCurrentMedications())
        #expect(patient.getCurrentMedications().count==1)
    }
    
    // Tests adding a second medication that has an earlier start date
    @Test func testAdditionalValidMedication() async throws {
        try patient.prescribeMedication(medication: medication1)
        try patient.prescribeMedication(medication: medication2)
        // Medication 2 should be listed before medication 1, since it was prescribed at an earlier date
        print(patient.getCurrentMedications())
        #expect(patient.getCurrentMedications()[0].name=="Aspirin")
        #expect(patient.getCurrentMedications().count==2)
    }
    
    // Even though medication 1 and 4 are the same, medication 4 was completed before medication 1 and should not be listed
    @Test func testCompletedMedication() async throws {
        try patient.prescribeMedication(medication: medication4)
        try patient.prescribeMedication(medication: medication1)
        #expect(medication4.isCompleted)
        // Check that only one medication is in list
        #expect(patient.getCurrentMedications().count==1)
    }
    
    // Tests if the approriate error is thrown when a duplicate medication is prescribed
    // Resource: https://developer.apple.com/documentation/testing/testing-for-errors-in-swift-code
    // Generated by ChatGPT: https://chatgpt.com/share/678416af-ab84-800d-91d0-f2801851b49b
    @Test func testDuplicateMedication() async throws {
        #expect(throws: Never.self) {
            try patient.prescribeMedication(medication: medication1)
        }
        // Test error throwing
        do {
            try patient.prescribeMedication(medication: medication3)
            print("Test failed: Expected an error, but no error was thrown.")
        } catch let error as Patient.PrescriptionError {
            switch error {
            case .duplicateMedication(let message):
                #expect(message == "Medication Metoprolol is already prescribed", "Test failed: Unexpected error message: \(message)")
                print("Test passed: Correct error thrown with message: \(message)")
            case .allergicMedication(let message):
                print("Test failed: Incorrect error thrown with message: \(message)")
            }
        } catch {
            print("Test failed: Unexpected error type: \(error)")
        }
    }
    
    //
    @Test func testAllergicMedication() async throws {
        #expect(throws: Never.self) {
            try patient.prescribeMedication(medication: medication1)
        }
           do {
               try patient.prescribeMedication(medication: medication5)
               print("Test failed: Expected an error, but no error was thrown.")
           } catch let error as Patient.PrescriptionError {
               switch error {
               case .duplicateMedication(let message):
                   print("Test failed: Incorrect error thrown with message: \(message)")
               case .allergicMedication(let message):
                   #expect(message == "Patient is allergic to medication Penecillin", "Test failed: Unexpected error message: \(message)")
                   print("Test passed: Correct error thrown with message: \(message)")               }
           } catch {
               print("Test failed: Unexpected error type: \(error)")
           }
    }
    
    @Test func testDonnorTypes() async throws {
        #expect(patient.getDonorBloodTypes().count==0)
        patient.bloodType = BloodType.BloodTypeEnum.oNegative
        #expect(patient.getDonorBloodTypes().count==1)
    }
}
 
