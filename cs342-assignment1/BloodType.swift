//
//  BloodType.swift
//  cs342-assignment1
//
//  Created by Shreya D'Souza on 1/11/25.
//

// This defines the BloodType type, which is cateogrical.
struct BloodType {
    let bloodType: BloodTypeEnum
    
    
    // Here we use an enum to define the possible categories for blood type: A+, A-, B+, B-, O+, O-, AB+ or AB-.
    enum BloodTypeEnum: String {
        case aPositive = "A+"
        case aNegative = "A-"
        case bPositive = "B+"
        case bNegative = "B-"
        case oPositive = "O+"
        case oNegative = "O-"
        case abPositive = "AB+"
        case abNegative = "AB-"
        case unknown = "Unknown" // default value for blood type - it might not be immediately known but should still be explicitly stated
    }
    
    // Initializer for blood type with defualt value unkonwn
    init(bloodType: BloodTypeEnum = BloodTypeEnum.unknown) {
        self.bloodType = bloodType
    }
}



