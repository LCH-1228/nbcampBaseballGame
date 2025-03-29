//
//  PlayGame.swift
//  BaseballGame
//
//  Created by Chanho Lee on 3/17/25.
//
import Foundation

class PlayGame {
    
    var historyIntence: History //의존성 주입을 받기 위한 변수선언과 init
    
    init(historyIntence: History) {
        self.historyIntence = historyIntence
    }
    
    //PlayGame의 실행 메서드
    func excute() {
        print("\n<게임을 시작합니다.>\n>>숫자를 입력하세요")
        var isPlaying = true
        //여기서 do를 지정하면 에러 처리시 while루프를 빠져나가 catch로 넘어가기에 try! 사용
        //try? 사용으로 nil 반환시에 대한 예외처리 필요.
        let testAnswer = try! makeRandomAnswer()
        let answer = testAnswer[0] * 100 + testAnswer[1] * 10 + testAnswer[2]
        print("테스트를 위한 정답 표시 : \(answer)") // 테스트를 위한 정답 표시
        historyIntence.addHistory(type: .answer, value1: answer)
        while isPlaying {
            do {
                let userInput = try getUerIntput()
                historyIntence.addHistory(type: .userInput, value1: userInput)
                let strikeAndBallCount = try determineStrikeAndBall(answer, userInput)
                switch strikeAndBallCount { //strikeAndBallCount 반환값은 튜플 (strike: Int, ball: Int)
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
                    continue
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

// 코드 가독성을 위해 extension으로 분리
extension PlayGame {
    func makeRandomAnswer() throws -> [Int] {
        var answerArray: [Int] = [0, 1, 2, 3, 4, 5, 6 ,7 ,8 ,9] //숫자 선택을 위한 배열
        let answer = answerArray.shuffled()
        guard answer[0] != 0 else {
            return [Int](answer[1...3])
        }
        return [Int](answer[0...2])
    }
    
    //사용자 입력 요청 메서드
    func getUerIntput() throws -> Int {
        if let userInput = readLine(), let userInputNumber = Int(userInput) {
            guard userInputNumber.isFit() else {
                throw CustomError.PlayGameError.inputValueNotMatchRule //사용자 입력이 규칙에 맞지 않을때 예외 처리
            }
            return userInputNumber
        } else {
            throw CustomError.PlayGameError.invaildInput //사용자 입력이 올바르지 않을때 예외 처리
        }
    }
    
    //스트라이크 볼 판단 메서드
    func determineStrikeAndBall(_ answer: Int, _ userInput: Int) throws -> (strike: Int, ball: Int) {
        if userInput < 0 { //입력값이 음수라면 잘못된 입력으로 예외처리
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
    
    //메세지 출력을 위한 메서드
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
