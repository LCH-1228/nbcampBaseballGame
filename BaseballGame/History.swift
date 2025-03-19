//
//  History.swift
//  BaseballGame
//
//  Created by Chanho Lee on 3/18/25.
//

class History {
    
    private static var countData: [Int] = []
    private static var historyData: [String] = []
    
    static func showHistory() {
        if countData.isEmpty { //배열이 비어있을경우 예외처리
            print("\n>> 게임 이력이 없습니다.\n")
            return
        } else {
            if countData.count == 1 { //배열이 1개만 있을경우 동작
                print("\n>>1번 게임 : 시도횟수 - \(countData[0])\n")
            } else { //배열이 2개 이상일 경우 동작
                print("")
                for round in 0...countData.count - 1 {
                    print(">>\(round + 1)번 게임 : 시도횟수 - \(countData[round])")
                }
                print("")
            }
            showDetailHistory()
        }
    }
    
    static func showDetailHistory() {
        print(">>상세보기를 원하시면 게임 번호를 입력해주세요\n뒤로가기를 원하시면 0을 입력해주세요.")
        if let userInput = readLine(), let inputNumber = Int(userInput) {
            if inputNumber == 0 {
                return
            } else if inputNumber >= 1 && inputNumber <= historyData.count {
                print(historyData[inputNumber - 1])
            } else {
                print("\n>>해당 게임번호가 없습니다.")
            }
        } else {
            print("\n허용되지 않는 입력입니다.")
        }
        showHistory()
    }
        
    static func setCount(_ value: Int) {
        countData.append(value)
    }
    
    static func setHistory(_ history: String) {
        historyData.append(history)
    }
}
