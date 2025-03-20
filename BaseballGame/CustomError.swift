//
//  CustomError.swift
//  BaseballGame
//
//  Created by Chanho Lee on 3/20/25.
//

class CustomError {
    
    enum PlayGameError: Error {
        case randomNumberGenerationError
        case invaildInput
        case inputValueNotMatchRule
        case determineStrikeAndBallInputError
    }

    enum HistoryError: Error {
        case historyIsEmpty
        case invaildInput
    }
    
}
