//
//  main.swift
//  BaseballGame
//
//  Created by Chanho Lee on 3/17/25.
//
import Foundation

func startGame() {
    var exitGame: Bool = false
    while !exitGame {
        var isSelected = false
        print("""
                >>환영합니다! 원하시는 번호를 입력해주세요
                >>1. 게임 시작하기 2. 게임 기록 보기 3. 종료하기
                """)
        while !isSelected {
            if let userInput = readLine(), let userInputNumber = Int(userInput) {
                switch userInputNumber {
                case 1:
                    let select = PlayGame()
                    select.excute()
                    isSelected = true
                case 2:
                    History.showHistory()
                    isSelected = true
                case 3:
                    print(">>숫자 야구 게임을 종료합니다.")
                    isSelected = true
                    exitGame = true
                default:
                    print(">>잘못된 입력입니다.")
                }
            }
        }
    }
}

startGame()
