This code uses Swift to create Patient, Medication, BloodType, and Allergy types and includes testing to validate this functionality.  

The types are contained in the following files: 
- cs342-assignment1/Allergy.swift
- cs342-assignment1/BloodType.swift
- cs342-assignment1/Medication.swift
- cs342-assignment1/Patient.swift

Tests are included here: 
cs342-assignment1Tests/cs342_assignment1Tests.swift

All tests pass:

<img width="742" alt="Screenshot 2025-01-12 at 2 03 29 PM" src="https://github.com/user-attachments/assets/254a8566-40ff-4f9c-9a93-0ba7fea8b844" />


Design Choices:
- Medication frequency is stored as an int to denote the number of times a day a medication will be taken. This could be changed to "weekly" or "daily" depending on future functionality
- BloodType is stored using an Enum, including the " Unknown " type. This explicitly states when a blood type is not known, preserving the categorical nature of the type.
- I included additional functionality to store patients' emails and allergies.
- Donor blood types are determined using a function within the patient class. This could alternatively be implemented within the blood type itself.

EDIT: After completing some more tutorials, I will be updating the ID for patients to use UUID() instead, guaranteeing uniqueness. 
