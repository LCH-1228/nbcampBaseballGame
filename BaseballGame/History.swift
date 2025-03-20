//
//  History.swift
//  BaseballGame
//
//  Created by Chanho Lee on 3/18/25.
//

class History {
    
    static let instence = History()
    
    private var countData: [Int] = []
    private var historyData: [String] = []
    private var trycount: Int = 1
    private var StrikAndBallHistory = ""
    var isSeeing = true
    
    private init() {}
    
    func excute() {
        var isSeeing = true
        while isSeeing {
            do {
                try showHistory()
                let userInput = try getUserInput()
                if userInput == 0 {
                    print("\n>>처음으로 돌아갑니다.\n")
                    isSeeing = false
                }
                showDetailHistory(index: userInput)
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

extension History {
    
    func getUserInput() throws -> Int {
        print("\n>>상세보기를 원하시면 게임 번호를 입력해주세요\n>>뒤로가기를 원하시면 0을 입력해주세요.")
        if let userInput = readLine(), let inputNumber = Int(userInput) {
            return inputNumber
        } else {
            throw CustomError.HistoryError.invaildInput
        }
    }
    
    func showHistory() throws {
        if countData.isEmpty { //배열이 비어있을경우 예외처리
            throw CustomError.HistoryError.historyIsEmpty
        } else {
            if countData.count == 1 { //배열이 1개만 있을경우 동작
                print("\n>>1번 게임 : 시도횟수 - \(countData[0])\n")
            } else { //배열이 2개 이상일 경우 동작
                print("")
                for round in 0...countData.count - 1 {
                    print(">>\(round + 1)번 게임 : 시도횟수 - \(countData[round])")
                }
            }
        }
    }
    
    func showDetailHistory(index: Int) {
        if index == 0 {
            isSeeing = false
        } else if index >= 1 && index <= historyData.count {
            print("\n\n<\(index)번 게임 기록> \(historyData[index - 1])")
        } else {
            print("\n>>해당 게임번호가 없습니다.")
        }
    }
    
    func addCount() {
        trycount += 1
    }
    
    func setCount() {
        countData.append(trycount)
        trycount = 1
    }
    
    func addHistory(type: JugementCase, value1: Int = 0, value2: Int = 0) {
        switch type {
        case .answer:
            StrikAndBallHistory += "\n정답: \(value1)\n"
        case .userInput:
            StrikAndBallHistory += "\(value1)\n"
        case .onlyStrike:
            StrikAndBallHistory += ">>\(value1)스트라이크!!\n"
        case .onlyBall:
            StrikAndBallHistory += ">>\(value1)볼!!\n"
        case .strikeAndBall:
            StrikAndBallHistory += ">>\(value1)스트라이크!! \(value2)볼!!\n"
        case .threeStike:
            StrikAndBallHistory += ">>3스트라이크!\n"
        case .nothing:
            StrikAndBallHistory += ">>Nothing\n"
        }
    }
    
    func setHistory() {
        historyData.append(StrikAndBallHistory)
        StrikAndBallHistory = ""
    }
}
