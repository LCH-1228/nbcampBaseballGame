//
//  History.swift
//  BaseballGame
//
//  Created by Chanho Lee on 3/18/25.
//

class History {
    
    private var countData: [Int] = [] //전체 게임에서 라운드당 시도횟수가 저장된 변수
    private var historyData: [String] = [] // 전체 게임에서 라운드당 게임기록이 저장된 변수
    private var trycount: Int = 1 // 라운드당 시도횟수 변수
    private var strikAndBallHistory = "" // 라운드당 게임기록 변수
    var isSeeing = true //게임 기록 확인 중 true
    var guesslength = 3 //게임 자릿수 설정 변수
    
    //실행 메서드
    func excute() {
        var isSeeing = true
        while isSeeing {
            do {
                try showHistory() //게임 기록 보기 메서드 호출
                let userInput = try getUserInput()
                if userInput == 0 {
                    print("\n>>처음으로 돌아갑니다.\n")
                    isSeeing = false
                }
                showDetailHistory(index: userInput) //게임 상세기록 보기 메서드 호출
            } catch(let error) {
                switch error as! CustomError.HistoryError {
                case .historyIsEmpty:
                    print("\n>> 게임 이력이 없습니다.\n")
                    isSeeing = false
                case .invaildInput:
                    print("\n허용되지 않는 입력입니다.")
                }
            }
        }
    }
}

// 코드 가독성을 위해 extension으로 분리
extension History {
    
    //게임이력 상세보기시 사용자 입력 요청 메서드
    func getUserInput() throws -> Int {
        print("\n>>상세보기를 원하시면 게임 번호를 입력해주세요\n>>뒤로가기를 원하시면 0을 입력해주세요.")
        if let userInput = readLine(), let inputNumber = Int(userInput) {
            return inputNumber
        } else {
            throw CustomError.HistoryError.invaildInput
        }
    }
    
    //게임기록 보기 메서드
    func showHistory() throws {
        if countData.isEmpty { //배열이 비어있을경우 예외처리
            throw CustomError.HistoryError.historyIsEmpty
        } else {
            if countData.count == 1 { //게임 한판 실행 후 배열이 1개만 있을경우 출력
                print("\n>>1번 게임 : 시도횟수 - \(countData[0])\n")
            } else { //배열이 2개 이상일 경우 동작
                print("") //줄 구분을 위한 print() 사용
                for round in 0...countData.count - 1 { //게임 여러판 실행 후 배열에 여러 값이 있을 경우에 출력
                    print(">>\(round + 1)번 게임 : 시도횟수 - \(countData[round])")
                }
            }
        }
    }
    
    //게임기록 상세보기 메서드
    func showDetailHistory(index: Int) {
        if index == 0 { // 0입력시 게임기록 보기 종료
            isSeeing = false
        } else if index >= 1 && index <= historyData.count { //저장된 게임 기록 내의 숫자 입력시 처리
            print("\n--------------------")
            print("\n<\(index)번 게임 기록> \(historyData[index - 1])")
            print("--------------------")
        } else { //저장된 게임 기록 이외의 숫자 입력시 처리
            print("--------------------")
            print("\n>>해당 게임번호가 없습니다.")
            print("--------------------")
        }
    }
    
    //한 다운드의 게임에서 시도횟수 count를 증가시키는 메서드
    func addCount() {
        trycount += 1
    }
    
    //addCount로 누적된 시도횟수를 배열에 저장
    func setCount() {
        countData.append(trycount)
        trycount = 1 //배열에 값 저장 후 초기화
    }
    
    //StrikAndBallHistory에 한라운드 정답을 String으로 저장하는 메서드
    func collectAnswer(answer: [Int]) {
        strikAndBallHistory += "\n정답: \(answer.reduce(""){String($0) + String($1)})\n"
    }
    
    //StrikAndBallHistory에 한라운드 사용자 입력을 String으로 저장하는 메서드
    func collectUserInput(userInput: [Int]) {
        strikAndBallHistory += "\(userInput.reduce(""){String($0) + String($1)})\n"
    }
    
    //StrikAndBallHistory에 한라운드 스트라이크 볼 상세 이력을 String으로 저장하는 메서드
    func collectDetermineStrikeAndBall(resultOfDetermination: (strike: Int, ball: Int)) {
        switch resultOfDetermination {
        case(0, 1...guesslength):
            strikAndBallHistory += ">>\(resultOfDetermination.1)볼!!\n"
            trycount += 1
        case(1..<guesslength, 0):
            strikAndBallHistory += ">>\(resultOfDetermination.0)스트라이크!!\n"
            trycount += 1
        case(1..<guesslength, 1..<guesslength):
            strikAndBallHistory += ">>\(resultOfDetermination.0)스트라이크!! \(resultOfDetermination.1)볼!!\n"
            trycount += 1
        case(guesslength, 0):
            strikAndBallHistory += ">>3스트라이크!\n"
        case(0,0):
            strikAndBallHistory += ">>Nothing\n"
            trycount += 1
        default:
            return
        }
    }
    
    //상세이력을 배열에 저장하는 메서드
    func setHistory() {
        historyData.append(strikAndBallHistory) // 스트라이크 볼 이력을 historyData에 저장
        strikAndBallHistory = "" //배열에 값 저장 후 초기화
    }
    
    //게임 자릿수 변경 메서드
    func setGuesslength(value: Int) {
        guesslength = value
    }
}
