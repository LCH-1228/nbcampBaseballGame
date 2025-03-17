//
//  Game.swift
//  BaseballGame
//
//  Created by Chanho Lee on 3/17/25.
//
import Foundation

class Game {
    
    /*
     함수명 : start
     기능 : 게임 시작
     */
    func start() {
        let answer = makeRandomAnswer()
    }
    
    /*
     함수명 : makeRandomAnswer
     기능 : 1~9 중 서로 다른 3개의 임의 숫자 생성
     */
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
}
