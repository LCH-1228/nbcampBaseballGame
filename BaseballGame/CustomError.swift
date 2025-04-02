//
//  CustomError.swift
//  BaseballGame
//
//  Created by Chanho Lee on 3/20/25.
//

//에러처리 클래스
class CustomError {
    
    //게임플레이 에러 열거형
    enum PlayGameError: Error {
        case randomNumberGenerationError
        case invaildInput
        case inputNumbersStartedNotMatchRule
        case inputNumbersCountNotMatchRule
        case inputNumberDuplicationNotMatchRule
        case determineStrikeAndBallInputError
    }
    
    //히스토리 에러 열거형
    enum HistoryError: Error {
        case historyIsEmpty
        case invaildInput
    }
    
}
