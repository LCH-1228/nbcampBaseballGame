//
//  IntExtension.swift
//  BaseballGame
//
//  Created by Chanho Lee on 3/17/25.
//

extension Int {
    func isFit() -> Bool {
        let array = String(self).map{$0}
        let isPositive = self > 0 ? true : false
        let isLengthThree = array.count == 3 ? true : false
        let isContainZero = array.contains("0") ? false : true
        let isDuplicated = (array.count != Set(array).count) ? false : true
        return isPositive && isLengthThree && isContainZero && isDuplicated
    }
}
