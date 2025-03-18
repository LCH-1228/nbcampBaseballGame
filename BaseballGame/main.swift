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
                switch userInputNumber { //사용자 입력에 따라 다른 동작 실행
                case 1:
                    let select = PlayGame() // 야구게임 실행을 위한 인스턴스 생성
                    select.excute() // 야구게임 실행
                    isSelected = true
                case 2:
                    History.showHistory() // 야구게임 기록을 보기위한 History class static 메서드 실행
                    isSelected = true
                case 3:
                    print(">>숫자 야구 게임을 종료합니다.")
                    isSelected = true //압력에 따른 동작 반복문 종료
                    exitGame = true // 전체 반복문 종료
                default:
                    print("""
                            >>잘못된 입력입니다.

                            >>원하시는 번호를 입력해주세요
                            >>1. 게임 시작하기 2. 게임 기록 보기 3. 종료하기
                            """)
                }
            }
        }
    }
}

startGame()
