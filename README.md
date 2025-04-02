
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
    - 게임 자릿수 설정 기능 추가(기본값: 3)

## 3. 게임방법
1. 게임메뉴에서 원하는 기능 선택

![게임메뉴](https://github.com/LCH-1228/nbcampBaseballGame/blob/develop/SampleImage/메뉴.png?raw=true)

---

2. 게임 진행

![게임 화면](https://github.com/LCH-1228/nbcampBaseballGame/blob/develop/SampleImage/%EA%B2%8C%EC%9E%84%EC%8B%9C%EC%9E%91.png?raw=true)

---

3. 숫자를 입력하여 정답 맞혀보기

---

#### 추가 기능
- 게임 설명 보기(게임 메뉴에서 1입력)

![게임설명](https://github.com/LCH-1228/nbcampBaseballGame/blob/develop/SampleImage/%EA%B2%8C%EC%9E%84%20%EC%84%A4%EB%AA%85.png?raw=true)

---

- 게임 기록보기(게임 메뉴에서 2입력)

![게임기록](https://github.com/LCH-1228/nbcampBaseballGame/blob/develop/SampleImage/%EA%B2%8C%EC%9E%84%EA%B8%B0%EB%A1%9D%EB%B3%B4%EA%B8%B0.png?raw=true)

---

- 게임기록 상세보기(게임 기록보기에서 확인할 게임 번호 입력)

![게임기록 상세보기](https://github.com/LCH-1228/nbcampBaseballGame/blob/develop/SampleImage/%EA%B2%8C%EC%9E%84%EA%B8%B0%EB%A1%9D%20%EC%83%81%EC%84%B8%EB%B3%B4%EA%B8%B0.png?raw=true)

---

- 게임 난이도 설정(게임 메뉴에서 4 입력)

![게임 난이도 설정](https://github.com/LCH-1228/nbcampBaseballGame/blob/develop/SampleImage/%EA%B2%8C%EC%9E%84%20%EB%82%9C%EC%9D%B4%EB%8F%84%20%EC%84%A4%EC%A0%95.png?raw=true)

---

- 게임 난이도 설정 후 게임 플레이시

![게임 난이도 설정 후 플레이](https://github.com/LCH-1228/nbcampBaseballGame/blob/develop/SampleImage/%EA%B2%8C%EC%9E%84%20%EB%82%9C%EC%9D%B4%EB%8F%84%20%EB%B3%80%EA%B2%BD%EC%8B%9C%20%EA%B2%8C%EC%9E%84%20%ED%94%8C%EB%A0%88%EC%9D%B4.png?raw=true)

---

## 4. Language
- Swift5 ( Xcode 16 )

## 5. Project Structure (프로젝트 구조)
```plaintext
nbcampBaseballGame/
nbcampBaseballGame/
├── BaseballGame
│   ├── CustomError.swift
│   ├── History.swift
│   ├── main.swift
│   └── PlayGame.swift
├── BaseballGame.xcodeproj
│   ├── project.pbxproj
│   └── project.xcworkspace
│       ├── contents.xcworkspacedata
│       └── xcshareddata
│           └── swiftpm
│               └── configuration
├── README.md
└── SampleImage
    ├── 게임 난이도 변경시 게임 플레이.png
    ├── 게임 난이도 설정.png
    ├── 게임 설명.png
    ├── 게임기록 상세보기.png
    ├── 게임기록보기.png
    ├── 게임시작.png
    └── 메뉴.png
```