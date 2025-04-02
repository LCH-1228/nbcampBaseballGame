//
//  main.swift
//  BaseballGame
//
//  Created by Chanho Lee on 3/17/25.
//
import Foundation

//게임 시작을 위한 함수
func startGame() {
    var exitGame: Bool = false
    let history = History()
    let game = PlayGame(historyIntence: history) // 야구게임 실행을 위한 인스턴스 생성. 동인한 인스턴스 유지를 위해서 의존성 주입을 통하여 History class를 참조하여 사용
    while !exitGame {
        print("""
                >>환영합니다! 원하시는 번호를 입력해주세요
                >>1. 게임 시작하기 2. 게임 기록 보기 3. 설명보기 4.게임설정 5. 종료하기
                """)
        if let userInput = readLine(), let userInputNumber = Int(userInput) {
            switch userInputNumber { //사용자 입력에 따라 다른 동작 실행
            case 1:
                game.excute() // 야구게임 실행
            case 2:
                history.excute() //게임 기록 보기 실행
            case 3: //게일 설명
                print("""
                        
                        [숫자야구게임]
                        랜덤한 숫자 3자리를 맞춰보세요
                        
                        [Rule]
                        사용자는 0~9까지 \(game.guesslength)자리 숫자를 입력할 수 있습니다.
                        숫자는 중복될수 없으며, 맨앞의 숫자는 0이 될수 없습니다.
                        
                        랜덤한 숫자와 입력한 숫자의 자리가 같으면 Strike
                        랜덤한 숫자와 입력한 숫자의 자리가 다르면 ball
                        랜덤한 숫자에 입력한 숫자가 포함되어 있지 않다면 Nothing
                        
                        랜덤한 숫자를 맞춰보세요.
                        
                        """)
            case 4: //야구게임 자리수 설정
                print(">>현재 야구게임 자리수 : \(game.guesslength)")
                print(">>변경할 야구게임의 자리수(1~9)를 입력해주세요.\n>>뒤로 돌아가시려면 엔터를 입력하세요.")
                if let userInput = readLine(), let userInputNumber = Int(userInput) {
                    guard userInputNumber >= 1 && userInputNumber <= 9 else { //사용자 입력 예외처리
                        print(">>잘못된 입력으로 뒤로 돌아갑니다.\n")
                        continue
                    }
                    game.guesslength = userInputNumber //입력값으로 guesslength 업데이트
                    history.setGuesslength(value: userInputNumber) // 스트라이크 볼 판단 게임 기록을 위해 history 인스턴스의 guesslength도 없데이트
                }
            case 5:
                print(">>숫자 야구 게임을 종료합니다.")
                exitGame = true // 전체 반복문 종료
            default:
                continue // 기타 입력시 동작
            }
        } else {
            print(">>잘못된 입력입니다.\n")
        }
    }
}

startGame()
