//
//  Symptom.swift
//  WWDD
//
//  Created by Yajnavalkya on 2020. 04. 21..
//  Copyright © 2020. Yajnavalkya. All rights reserved.
//

import Foundation

struct Symptom: Decodable {
    let name: String
    let system: System
    
    enum System: Decodable {
        case all
        case Behavioral
        case Cardiology
        case Dermatology
        case Emergency
        case Endocrinology
        case Gastroenterology
        case General
        case Geriatrics
        case Gynaecology
        case Hematoncology
        case Infectology
        case Nephrology
        case Neurology
        case Ophthalmology
        case Otorhinolaryngology
        case Pharmacology
        case Pulmonology
        case Rheumatology
        case Urology
    }
}

extension Symptom.System: CaseIterable { }

extension Symptom.System: RawRepresentable {
    typealias RawValue = String
    
    init?(rawValue: RawValue) {
        switch rawValue {
        case "All":
            self = .all
        case "Behavioral Medicine":
            self = .Behavioral
        case "Cardiology":
            self = .Cardiology
        case "Dermatology":
            self = .Dermatology
        case "Emergency Medicine":
            self = .Emergency
        case "Endocrinology":
            self = .Endocrinology
        case "Gastroenterology":
            self = .Gastroenterology
        case "General Medicine":
            self = .General
        case "Geriatrics":
            self = .Geriatrics
        case "Gynaecology":
            self = .Gynaecology
        case "Hematoncology":
            self = .Hematoncology
        case "Infectology":
            self = .Infectology
        case "Nephrology":
            self = .Nephrology
        case "Neurology":
            self = .Neurology
        case "Ophthalmology":
            self = .Ophthalmology
        case "Otorhinolaryngology":
            self = .Otorhinolaryngology
        case "Pharmacology":
            self = .Pharmacology
        case "Pulmonology":
            self = .Pulmonology
        case "Rheumatology":
            self = .Rheumatology
        case "Urology":
            self = .Urology
        default:
            return nil
        }
    }
    
    var rawValue: RawValue {
        switch self {
        case .all:
            return "All"
        case .Behavioral:
            return "Behavioral Medicine"
        case .Cardiology:
            return "Cardiology"
        case .Dermatology:
            return "Dermatology"
        case .Emergency:
            return "Emergency Medicine"
        case .Endocrinology:
            return "Endocrinology"
        case .Gastroenterology:
            return "Gastroenterology"
        case .General:
            return "General Medicine"
        case .Geriatrics:
            return "Geriatrics"
        case .Gynaecology:
            return "Gynaecology"
        case .Hematoncology:
            return "Hematoncology"
        case .Infectology:
            return "Infectology"
        case .Nephrology:
            return "Nephrology"
        case .Neurology:
            return "Neurology"
        case .Ophthalmology:
            return "Ophthalmology"
        case .Otorhinolaryngology:
            return "Otorhinolaryngology"
        case .Pharmacology:
            return "Pharmacology"
        case .Pulmonology:
            return "Pulmonology"
        case .Rheumatology:
            return "Rheumatology"
        case .Urology:
            return "Urology"
        }
    }
}

extension Symptom {
    static func symptoms() -> [Symptom] {
        guard
        let url = Bundle.main.url(forResource: "symptoms", withExtension: "json"),
            let data = try? Data(contentsOf: url)
            else {
                return []
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([Symptom].self, from: data)
        } catch {
            return []
        }
    }
    
    static func systems() -> [System] {
        guard
            let url = Bundle.main.url(forResource: "symptoms", withExtension: "json"),
            let data = try? Data(contentsOf: url)
            else {
                return []
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([System].self, from: data)
        } catch {
            return []
        }
    }
}
