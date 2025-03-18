//
//  History.swift
//  BaseballGame
//
//  Created by Chanho Lee on 3/18/25.
//

class History {
    
    static var countData: [Int] = []
    
    static func showHistory() {
        if countData.isEmpty {
            print("\n>> 게임 이력이 없습니다.\n")
            return
        } else {
            if countData.count == 1 {
                print("\n>>1번 게임 : 시도횟수 - \(countData[0])\n")
            } else {
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
