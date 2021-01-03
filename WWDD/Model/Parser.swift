//
//  Parser.swift
//  WWDD
//
//  Created by Yajnavalkya on 2020. 04. 21..
//  Copyright © 2020. Yajnavalkya. All rights reserved.
//
// WHAT DOES THIS DO? : How to check if text contains only numbers?

import Foundation

extension String {
    
    
  //  CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: yourString))
    
    
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
}
