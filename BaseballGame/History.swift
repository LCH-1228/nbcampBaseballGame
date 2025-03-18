//
//  History.swift
//  BaseballGame
//
//  Created by Chanho Lee on 3/18/25.
//

class History {
    
    static var countData: [Int] = []
    
    static func showHistory() {
        if countData.isEmpty { //배열이 비어있을경우 예외처리
            print("\n>> 게임 이력이 없습니다.\n")
            return
        } else {
            if countData.count == 1 { //배열이 1개만 있을경우 동작
                print("\n>>1번 게임 : 시도횟수 - \(countData[0])\n")
            } else { //배열이 2개 이상ㅇ 경우 동작
                print("")
                for round in 0...countData.count - 1 {
                    print(">>\(round + 1)번 게임 : 시도횟수 - \(countData[round])")
                }
                print("")
            }
        }
    }
        
    static func setHistory(_ value: Int) {
        countData.append(value)
    }
}
