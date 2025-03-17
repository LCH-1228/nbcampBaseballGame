//
//  Game.swift
//  BaseballGame
//
//  Created by Chanho Lee on 3/17/25.
//
import Foundation

class Game {
    
    func start() {
        let answer = makeRandomAnswer()
        let userInput = getUerIntput()
    }
    
    func makeRandomAnswer() -> Int{
        var answerArray: [Int] = [1, 2, 3, 4, 5, 6 ,7 ,8 ,9]
        var answer: Float = 0
        for i in 0...2 {
            if let pickedNumber = answerArray.randomElement() {
                answerArray.remove(at: answerArray.firstIndex(of: pickedNumber)!)
                answer += pow(10.0, Float(i)) * Float(pickedNumber)
            } else {
                return -101
            }
        }
        return Int(answer)
    }
    

    func getUerIntput() -> Int {
        print("1부터 9까지 중에 서로 다른 숫자 3개를 입력하세요")
        if let userInput = readLine(), let userInputNumber = Int(userInput) {
            guard userInputNumber.isFit() else {
                print("조건에 맞지 않는 입력입니다.")
                return -211
            }
            return userInputNumber
        } else {
            print("숫자가 아닌 다른 문자를 입력하셨거나, 입력이 없습니다.")
            return -201
        }
    }
}
