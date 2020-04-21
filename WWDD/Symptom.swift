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
        case cardiovascular
        case genitourinary
        case gastrointestinal
        case neurological
    }
}

extension Symptom.System: CaseIterable { }

extension Symptom.System: RawRepresentable {
    typealias RawValue = String
    
    init?(rawValue: RawValue) {
        switch rawValue {
        case "All":
            self = .all
        case "Cardiovascular":
            self = .cardiovascular
        case "Genitourinary":
            self = .genitourinary
        case "Gastrointestinal":
            self = .gastrointestinal
        case "Neurological":
            self = .neurological
        default:
            return nil
        }
    }
    
    var rawValue: RawValue {
        switch self {
        case .all:
            return "All"
        case .cardiovascular:
            return "Cardiovascular"
        case .genitourinary:
            return "Genitourinary"
        case .gastrointestinal:
            return "Gastrointestinal"
        case .neurological:
            return "Neurological"
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
}
