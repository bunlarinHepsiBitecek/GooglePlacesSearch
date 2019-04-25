//
//  PredictionResult.swift
//  GooglePlacesARBasedApp
//
//  Created by Erkut Baş on 4/25/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation

class PredictionResult: Codable {
    let predictions: [Prediction]
    let status: String
    
    init(predictions: [Prediction], status: String) {
        self.predictions = predictions
        self.status = status
    }
}

class Prediction: Codable {
    let description, id: String
    let matchedSubstrings: [MatchedSubstring]
    let placeID, reference: String
    let structuredFormatting: StructuredFormatting
    let terms: [Term]
    let types: [String]
    
    enum CodingKeys: String, CodingKey {
        case description, id
        case matchedSubstrings = "matched_substrings"
        case placeID = "place_id"
        case reference
        case structuredFormatting = "structured_formatting"
        case terms, types
    }
    
    init(description: String, id: String, matchedSubstrings: [MatchedSubstring], placeID: String, reference: String, structuredFormatting: StructuredFormatting, terms: [Term], types: [String]) {
        self.description = description
        self.id = id
        self.matchedSubstrings = matchedSubstrings
        self.placeID = placeID
        self.reference = reference
        self.structuredFormatting = structuredFormatting
        self.terms = terms
        self.types = types
    }
}

class MatchedSubstring: Codable {
    let length, offset: Int
    
    init(length: Int, offset: Int) {
        self.length = length
        self.offset = offset
    }
}

class StructuredFormatting: Codable {
    let mainText: String
    let mainTextMatchedSubstrings: [MatchedSubstring]
    let secondaryText: String
    
    enum CodingKeys: String, CodingKey {
        case mainText = "main_text"
        case mainTextMatchedSubstrings = "main_text_matched_substrings"
        case secondaryText = "secondary_text"
    }
    
    init(mainText: String, mainTextMatchedSubstrings: [MatchedSubstring], secondaryText: String) {
        self.mainText = mainText
        self.mainTextMatchedSubstrings = mainTextMatchedSubstrings
        self.secondaryText = secondaryText
    }
}

class Term: Codable {
    let offset: Int
    let value: String
    
    init(offset: Int, value: String) {
        self.offset = offset
        self.value = value
    }
}
