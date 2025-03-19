//
//  PlayGame.swift
//  BaseballGame
//
//  Created by Chanho Lee on 3/17/25.
//
import Foundation

class PlayGame {
    
    func excute() {
        print("\n>>0부터 9까지 중에 서로 다른 3자리 숫자를 입력하세요")
        var isPlaying = true
        var trycount = 1 //게임 기록 확인을 위한 trycount
        let answer = makeRandomAnswer()
        var history = "\n\n<기록>\n정답: \(answer)\n"
        while isPlaying {
            let userInput = getUerIntput()
            if userInput > 0 {
                history += "\(userInput)\n"
            }
            let strikeAndBallCount = determineStrikeAndBall(answer, userInput)
            switch strikeAndBallCount {
            case(0, 1...3): //범위연산자로 case 지정
                print(">>\(strikeAndBallCount.1)볼!!\n")
                history += ">>\(strikeAndBallCount.1)볼!!\n"
                trycount += 1
            case(1...2, 0):
                print(">>\(strikeAndBallCount.0)스트라이크!!\n")
                history += ">>\(strikeAndBallCount.0)스트라이크!!\n"
                trycount += 1
            case(1...2, 1...2):
                print(">>\(strikeAndBallCount.0)스트라이크!! \(strikeAndBallCount.1)볼!!\n")
                history += ">>\(strikeAndBallCount.0)스트라이크!! \(strikeAndBallCount.1)볼!!\n"
                trycount += 1
            case(3, 0):
                print("\n>>정답입니다.\n>>처음화면으로 돌아갑니다.\n")
                History.setHistory(history)
                History.setCount(trycount)
                isPlaying = false
            case(0,0):
                print(">>Nothing\n")
                history += ">>Nothing\n"
                trycount += 1
            default:
                isPlaying = true
            }
        }
    }
}

extension PlayGame { // 코드 가독성을 위해 extension으로 분리
    func makeRandomAnswer() -> Int {
        var answerArray: [Int] = [0, 1, 2, 3, 4, 5, 6 ,7 ,8 ,9] //숫자 선택을 위한 배열
        var answer: Float = 0 // for문에서 pow 연산을 위해 Float로 지정
        for i in 0...2 {
            if let pickedNumber = answerArray.randomElement() { //랜덤한 배열값 1개 선택
                if i == 2 && pickedNumber == 0 { //선택된 숫자 3자리중 맨앞에 0일 경우 실행
                    answerArray.remove(at: answerArray.firstIndex(of: pickedNumber)!) //배열에서 0을 제거
                    if let pickedNumber = answerArray.randomElement() { //0이 제거된 배열에서 랜덤한 배열 값 선택
                        answer += pow(10.0, Float(i)) * Float(pickedNumber) //제곱연산인 pow를 이용하여 10^0, 10^1, 10^2를 자리값으로 사용하고 각각 선택된 숫자를 곱해서 3자리수 생성
                    }
                } else {
                    answerArray.remove(at: answerArray.firstIndex(of: pickedNumber)!) //선택택된 랜덤한 배열 값 삭제
                    answer += pow(10.0, Float(i)) * Float(pickedNumber) //제곱연산인 pow를 이용하여 10^0, 10^1, 10^2를 자리값으로 사용하고 각각 선택된 숫자를 곱해서 3자리수 생성
                }
            } else {
                return -101 //에러코드 기능 구현을 위한 음수 반환
            }
        }
        return Int(answer)
    }
    

    func getUerIntput() -> Int {
        if let userInput = readLine(), let userInputNumber = Int(userInput) {
            guard userInputNumber.isFit() else {
                print("\n>>조건에 맞지 않는 입력입니다.\n>>0부터 9까지 중에 서로 다른 3자리 숫자를 입력하세요\n>>숫자는 0으로 시작할 수 없습니다.")
                return -202 //추후 에러코드 기능 구현을 위한 음수 반환
            }
            return userInputNumber
        } else {
            print(">>숫자가 아닌 다른 문자를 입력하셨거나, 입력이 없습니다.")
            return -201 //추후 에러코드 기능 구현을 위한 음수 반환
        }
    }
    
    func determineStrikeAndBall(_ answer: Int, _ userInput: Int) -> (strike: Int, ball: Int) {
        if userInput < 0{ //추후 반환값이 음수일 경우 에러코드 기능 구현을 위한 조건문
            return (-1, -1) //추후 에러코드 기능 구현을 위한 음수 반환
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
