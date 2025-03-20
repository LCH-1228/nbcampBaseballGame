//
//  IntExtension.swift
//  BaseballGame
//
//  Created by Chanho Lee on 3/17/25.
//

extension Int {
    
    //PlayGame에서 사용자 입력이 규칙에 맞는지 판단하는 메서드
    func isFit() -> Bool {
        let array = String(self).map{$0} //Int를 고차함수 map을 사용하여 array로 변환
        let isPositive = self > 0 ? true : false // Int가 양수인지 판단
        let isLengthThree = array.count == 3 ? true : false //Int가 3자리 수인지 판단
        let isStartZero = array.first == "0" ? false : true // Int의 시작이 0인지 판단
        let isDuplicated = (array.count != Set(array).count) ? false : true // Int에 중복되는 숫자가 있는지 판단
        return isPositive && isLengthThree && isStartZero && isDuplicated
    }
}
