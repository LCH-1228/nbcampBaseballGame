//
//  Game.swift
//  BaseballGame
//
//  Created by Chanho Lee on 3/17/25.
//
import Foundation

class Game {
    
    func start() {
        var isPlaying = true
        
        let answer = makeRandomAnswer()
        while isPlaying {
            let userInput = getUerIntput()
            let strikeAndBallCount = determineStrikeAndBall(answer, userInput)
            switch strikeAndBallCount {
            case(0, 1...3):
                print("\(strikeAndBallCount.1)볼!!\n")
            case(1...2, 0):
                print("\(strikeAndBallCount.0)스트라이크!!\n")
            case(1...2, 1...2):
                print("\(strikeAndBallCount.0)스트라이크!! \(strikeAndBallCount.1)볼!!\n")
            case(3, 0):
                print("정답입니다.\n")
                isPlaying = false
                let select = select()
            case(0,0):
                print("Nothing\n")
            default:
                isPlaying = true
            }
        }
    }
    
    func makeRandomAnswer() -> Int {
        var answerArray: [Int] = [0, 1, 2, 3, 4, 5, 6 ,7 ,8 ,9]
        var answer: Float = 0
        for i in 0...2 {
            if let pickedNumber = answerArray.randomElement() {
                if i == 2 && pickedNumber == 0 {
                    answerArray.remove(at: answerArray.firstIndex(of: pickedNumber)!)
                    if let pickedNumber = answerArray.randomElement() {
                        answer += pow(10.0, Float(i)) * Float(pickedNumber)
                    }
                } else {
                    answerArray.remove(at: answerArray.firstIndex(of: pickedNumber)!)
                    answer += pow(10.0, Float(i)) * Float(pickedNumber)
                }
            } else {
                return -101
            }
        }
        print(Int(answer))
        return Int(answer)
    }
    

    func getUerIntput() -> Int {
        print("0부터 9까지 중에 서로 다른 3자리 숫자를 입력하세요")
        if let userInput = readLine(), let userInputNumber = Int(userInput) {
            guard userInputNumber.isFit() else {
                print("\n조건에 맞지 않는 입력입니다.")
                return -202
            }
            return userInputNumber
        } else {
            print("숫자가 아닌 다른 문자를 입력하셨거나, 입력이 없습니다.")
            return -201
        }
    }
    
    func determineStrikeAndBall(_ answer: Int, _ userInput: Int) -> (strike: Int, ball: Int) {
        if userInput < 0{
            return (-1, -1)
        }
        var strike = 0
        let answerArray = String(answer).map {$0}
        let UserInputArray = String(userInput).map {$0}
        let answerSet: Set<Character> = Set(answerArray)
        let UserInputSet: Set<Character> = Set(UserInputArray)
        var ball = answerSet.intersection(UserInputSet).count
        
        for i in 0...2 {
            if answerArray[i] == UserInputArray[i] {
                strike += 1
            }
            
        }
        ball -= strike
        return (strike, ball)
    }
}

