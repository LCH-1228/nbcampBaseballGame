//
//  PlayGame.swift
//  BaseballGame
//
//  Created by Chanho Lee on 3/17/25.
//
import Foundation

class PlayGame {
    
    var historyIntence: History
    
    init(historyIntence: History) {
        self.historyIntence = historyIntence
    }
    
    func excute() {
        print("\n<게임을 시작합니다.>\n>>숫자를 입력하세요")
        var isPlaying = true
        let answer = try! makeRandomAnswer()
        print("테스트를 위한 정답 표시 : \(answer)") // 테스트를 위한 정답 보기
        historyIntence.addHistory(type: .answer, value1: answer)
        while isPlaying {
            do {
                let userInput = try getUerIntput()
                historyIntence.addHistory(type: .userInput, value1: userInput)
                let strikeAndBallCount = try determineStrikeAndBall(answer, userInput)
                switch strikeAndBallCount {
                case(0, 1...3): //범위연산자로 case 지정
                    printMessage(type: .onlyBall, value1: strikeAndBallCount.1)
                    historyIntence.addHistory(type: .onlyBall, value1: strikeAndBallCount.1)
                    historyIntence.addCount()
                case(1...2, 0):
                    printMessage(type: .onlyStrike, value1: strikeAndBallCount.0)
                    historyIntence.addHistory(type: .onlyStrike, value1: strikeAndBallCount.0)
                    historyIntence.addCount()
                case(1...2, 1...2):
                    printMessage(type: .strikeAndBall, value1: strikeAndBallCount.0, value2: strikeAndBallCount.1)
                    historyIntence.addHistory(type: .strikeAndBall, value1: strikeAndBallCount.0, value2: strikeAndBallCount.1)
                    historyIntence.addCount()
                case(3, 0):
                    printMessage(type: .threeStike)
                    historyIntence.addHistory(type: .threeStike)
                    historyIntence.setHistory()
                    historyIntence.setCount()
                    isPlaying = false
                case(0,0):
                    printMessage(type: .nothing)
                    historyIntence.addHistory(type: .nothing)
                    historyIntence.addCount()
                default:
                    isPlaying = true
                }
            } catch(let error) {
                switch error as! CustomError.PlayGameError {
                case .randomNumberGenerationError:
                    print(">>랜덤숫자 생성에 실패했습니다.")
                case .invaildInput:
                    print(">>숫자가 아닌 다른 문자를 입력하셨거나, 입력이 없습니다.\n")
                case .inputValueNotMatchRule:
                    print(">>조건에 맞지 않는 입력입니다.\n>>0부터 9까지 중에 서로 다른 3자리 숫자를 입력하세요\n>>숫자는 0으로 시작할 수 없습니다.\n")
                case .determineStrikeAndBallInputError:
                    print("판단실패")
                }
            }
        }
    }
}

extension PlayGame { // 코드 가독성을 위해 extension으로 분리
    func makeRandomAnswer() throws -> Int {
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
                throw CustomError.PlayGameError.randomNumberGenerationError //에러코드 기능 구현을 위한 음수 반환
            }
        }
        return Int(answer)
    }
    

    func getUerIntput() throws -> Int {
        if let userInput = readLine(), let userInputNumber = Int(userInput) {
            guard userInputNumber.isFit() else {
                throw CustomError.PlayGameError.inputValueNotMatchRule //추후 에러코드 기능 구현을 위한 음수 반환
            }
            return userInputNumber
        } else {
            throw CustomError.PlayGameError.invaildInput //추후 에러코드 기능 구현을 위한 음수 반환
        }
    }
    
    func determineStrikeAndBall(_ answer: Int, _ userInput: Int) throws -> (strike: Int, ball: Int) {
        if userInput < 0{ //추후 반환값이 음수일 경우 에러코드 기능 구현을 위한 조건문
            throw CustomError.PlayGameError.determineStrikeAndBallInputError
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
    
    func printMessage(type: InputOutValue, value1: Int = 0, value2: Int = 0) {
        switch type {
        case .answer:
            print("\n정답: \(value1)\n")
        case .userInput:
            print("\(value1)\n")
        case .onlyStrike:
            print(">>\(value1)스트라이크!!\n")
        case .onlyBall:
            print(">>\(value1)볼!!\n")
        case .strikeAndBall:
            print(">>\(value1)스트라이크!! \(value2)볼!!\n")
        case .threeStike:
            print("\n>>정답입니다.\n>>처음화면으로 돌아갑니다.\n")
        case .nothing:
            print(">>Nothing\n")
        }
    }
}
