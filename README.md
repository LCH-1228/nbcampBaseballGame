# Swift로 야구게임 만들기

## 1. Project Overview(프로젝트 개요)
- 내일배움캠프 iOS스타터 과정 3주차 프로그래밍 기초 주차의 과제인 Swift 언어 학습 결과물입니다.

- 숫자 야구 게임은 두 명이 즐길 수 있는 추리 게임으로, 상대방이 설정한 3자리의 숫자를 맞히는 것이 목표입니다.
각 자리의 숫자와 위치가 모두 맞으면 '스트라이크', 숫자만 맞고 위치가 다르면 '볼'로 판정됩니다.
예를 들어, 상대방의 숫자가 123일 때 132를 추리하면 1스트라이크 2볼이 됩니다.
이러한 힌트를 활용하여 상대방의 숫자를 추리해 나가는 게임입니다.
단, 0부터 9까지의 서로다른 숫자 중 첫번째 숫자는 0이 올수 없습니다.

## 2. Key Features (주요 학습내용 및 기능)
- Lv1
	- PlayGame class 선언으로 코드의 기본 뼈대 생성
- Lv2
	- 1부터 9까지 서로 다른 숫자 3개 입력 구현(extension Int로 isFit 메서드 정의)
    - 숫자와 위치가 맞으면 스트라이크, 숫자만 맞고 위치가 다르면 볼 판정 구현
      (PlayGame class 내 determineStrikeAndBall 메서드 정의)
- Lv3
	- 배열을 이용한 0부터 9까지 중 서로 다른 숫자 3개 선택 기능 구현
	 (PlayGame class 내 makeRandomAnswer 메서드 정의)
	  단, 처음 숫자는 0이 올수 없음
- Lv4
	- 반복문 while과 조건문 switch를 이용한 시작 안내문구 기능 구현
	(startGame 함수에 구현)
    - 안내문구에 표시된 입력에 따라 동작
- Lv5
	- 게임기록 기능 구현(History class에 정의)
   -  프로그램 종료전까지 게임 내역 기록 및 표시기능 구현
- Lv6
	- 게임 종료기능 구현(startGame 함수에 구현)
    - 안내문구에 표시된 입력 외 다른 입력 오류처리

- 번외
	- 게임기록 기능에 상세 이력 표시 기능 추가


## 3. Language
- Swift5 ( Xcode 16 )

## 4. Project Structure (프로젝트 구조)
```plaintext
nbcampBaseballGame/
├── BaseballGame
│   ├── CustomError.swift
│   ├── History.swift
│   ├── InputOutValue.swift
│   ├── IntExtension.swift
│   ├── PlayGame.swift
│   └── main.swift
├── BaseballGame.xcodeproj
│   ├── project.pbxproj
│   └── project.xcworkspace
│       ├── contents.xcworkspacedata
│       └── xcshareddata
│           └── swiftpm
│               └── configuration
└── README.md
```