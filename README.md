
# Swift로 야구게임 만들기

## 1. Project Overview(프로젝트 개요)
- 내일배움캠프 iOS스타터 과정 3주차 프로그래밍 기초 주차의 과제인 Swift 언어 학습 결과물입니다.

- 숫자 야구 게임은 두 명이 즐길 수 있는 추리 게임으로, 상대방이 설정한 3자리의 숫자를 맞히는 것이 목표입니다. 각 자리의 숫자와 위치가 모두 맞으면 '스트라이크', 숫자만 맞고 위치가 다르면 '볼'로 판정됩니다. 예를 들어, 상대방의 숫자가 123일 때 132를 추리하면 1스트라이크 2볼이 됩니다. 이러한 힌트를 활용하여 상대방의 숫자를 추리해 나가는 게임입니다.

## 2. Key Features (주요 학습내용 및 기능)
- Lv1
	- Game class 선언으로 코드의 기본 뼈대 생성
- Lv2
	- 1부터 9까지 서로 다른 숫자 3개 입력 구현(extension Int로 isFit 메서드 정의)숫자와 위치가 맞으면 스트라이크, 숫자만 맞고 위치가 다르면 볼 판정 구현(determineStrikeAndBall 메서드 정의)
- Lv3
	- 배열을 이용한 1부터 9까지 중 서로 다른 숫자 3개 선택 기능 구현(makeRandomAnswer 메서드 정의)


## 3. Language
- swift ( Xcode 16 )

## 4. Project Structure (프로젝트 구조)
```plaintext
nbcBaseballGame/
├── BaseballGame
│   ├── Game.swift
│   ├── IntExtension.swift
│   └── main.swift
├── BaseballGame.xcodeproj
│   ├── project.pbxproj
│   └── project.xcworkspace
│       ├── contents.xcworkspacedata
│       └── xcshareddata
│           └── swiftpm
│               └── configuration
└── README.md
```