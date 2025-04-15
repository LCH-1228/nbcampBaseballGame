//
//  PlayGame.swift
//  BaseballGame
//
//  Created by Chanho Lee on 3/17/25.
//
import Foundation

class PlayGame {
    
    var historyIntence: History //의존성 주입을 받기 위한 변수선언과 init
    var guesslength = 3 //게임 자리수 설정 변수
    
    init(historyIntence: History) {
        self.historyIntence = historyIntence
    }
    
    //PlayGame의 실행 메서드
    func excute() {
        print("\n<\(guesslength)자리 숫자야구 게임을 시작합니다.>\n>>\(guesslength) 숫자를 입력하세요")
        var isPlaying = true
        let answer = makeRandomAnswer() //랜덤 숫자 생성
        print("테스트를 위한 정답 표시 : \(answer)") // 테스트를 위한 정답 표시
        historyIntence.collectAnswer(answer: answer) // 정답을 history인스턴스의 StrikAndBallHistory 문자열에 임시 저장
        while isPlaying {
            do {
                let userInput = try getUerIntput()
                historyIntence.collectUserInput(userInput: userInput) // 사용자 입력을 게임기록에 저장
                
                let strikeAndBallCount = try determineStrikeAndBall(answer, userInput) // 스트라이크 볼 판단
                
                //스트라이크 볼 판단을 history인스턴스의 strikAndBallHistory 문자열에 임시 저장
                historyIntence.collectDetermineStrikeAndBall(resultOfDetermination: strikeAndBallCount)
                printMessage(resultOfDetermination: strikeAndBallCount) // 스트라이크 볼 판단 메세지 출력
                
                if strikeAndBallCount.0 == guesslength { //스트라이크 갯수가 설정한 guesslenght와 일치하면 정답 처리
                    historyIntence.setHistory() //history인스턴스의 strikAndBallHistory 문자열을 historyData에 String 배열로 저장
                    historyIntence.setCount() //history인스턴스의 trycount Int를 countData에 Int 배열로 저장
                    isPlaying = false
                }
            } catch(let error) {
                switch error as! CustomError.PlayGameError {
                case .randomNumberGenerationError:
                    print(">>랜덤숫자 생성에 실패했습니다.")
                case .invaildInput:
                    print(">>숫자가 아닌 다른 문자를 입력하셨거나, 입력이 없습니다.\n")
                case .inputNumbersStartedNotMatchRule:
                    print(">>조건에 맞지 않는 입력입니다.\n>>숫자는 0으로 시작할 수 없습니다.\n")
                case .inputNumbersCountNotMatchRule:
                    print(">>조건에 맞지 않는 입력입니다.\n>>0부터 9까지 \(guesslength)자리 숫자를 입력하세요\n")
                case .inputNumberDuplicationNotMatchRule:
                    print(">>조건에 맞지 않는 입력입니다.\n>>0부터 9까지 중에 서로 다른 숫자를 입력하세요\n")
                case .determineStrikeAndBallInputError:
                    print(">>스트라이크 볼 판단을 실패했습니다.\n")
                }
            }
        }
    }
}

// 코드 가독성을 위해 extension으로 분리
extension PlayGame {
    func makeRandomAnswer() -> [Int] {
        let answerArray: [Int] = [0, 1, 2, 3, 4, 5, 6 ,7 ,8 ,9] //숫자 선택을 위한 배열
        let answer = answerArray.shuffled() //배열을 섞어 랜덤한 순서로 정렬
        guard answer[0] != 0 else { // 배열의 첫번째 값이 0일 경우 예외처리
            return [Int](answer[1...guesslength])
        }
        return [Int](answer[0..<guesslength])
    }
    
    //사용자 입력 요청 메서드
    func getUerIntput() throws -> [Int] {
        let userInput = readLine() ?? ""
        let numberArray = userInput.map { String($0) }.compactMap { Int($0) } // 사용자 입력을 Int 배열로 변환
        guard !numberArray.isEmpty else { throw CustomError.PlayGameError.invaildInput } //사용자 입력이 올바르지 않을때 예외 처리
        guard numberArray[0] != 0 else { throw CustomError.PlayGameError.inputNumbersStartedNotMatchRule } //사용자 입력이 0으로 시작할때 예외 처리
        guard numberArray.count == guesslength else { throw CustomError.PlayGameError.inputNumbersCountNotMatchRule } //사용자 입력 숫자가 3개가 아닐때 예외 처리
        guard numberArray.count == Set(numberArray).count else { throw CustomError.PlayGameError.inputNumberDuplicationNotMatchRule } //사용자 입력에 중복된 숫자가 있을때 예외 처리
        return numberArray
    }
    
    //스트라이크 볼 판단 메서드
    func determineStrikeAndBall(_ answer: [Int], _ userInput: [Int]) throws -> (strike: Int, ball: Int) {
        var strike = 0
        let answerSet: Set<Int> = Set(answer)
        let userInputSet: Set<Int> = Set(userInput)
        var ball = answerSet.intersection(userInputSet).count // answerSet과 UserSet을 비교하여 중복값 확인
        
        for i in 0..<guesslength { //게임 자릿수 guesslength 만큼 변경
            if answer[i] == userInput[i] {
                strike += 1
            }
            
        }
        ball -= strike // 중복값중에 스트라이크 개수만큼 빼기
        guard strike >= 0 else { throw CustomError.PlayGameError.determineStrikeAndBallInputError }
        guard ball >= 0 else { throw CustomError.PlayGameError.determineStrikeAndBallInputError }
        return (strike, ball)
    }
    
    //메세지 출력을 위한 메서드
    func printMessage(resultOfDetermination: (strike: Int, ball: Int)) {
        switch resultOfDetermination {
        case(0, 1...guesslength):
            print(">>\(resultOfDetermination.1)볼!!\n")
        case(1..<guesslength, 0):
            print(">>\(resultOfDetermination.0)스트라이크!!\n")
        case(1..<guesslength, 1..<guesslength):
            print(">>\(resultOfDetermination.0)스트라이크!! \(resultOfDetermination.1)볼!!\n")
        case(guesslength, 0):
            print(">>3스트라이크!\n")
            print("\n>>정답입니다.\n>>처음화면으로 돌아갑니다.\n")
        case(0,0):
            print(">>Nothing\n")
        default:
            return
        }
    }
}
