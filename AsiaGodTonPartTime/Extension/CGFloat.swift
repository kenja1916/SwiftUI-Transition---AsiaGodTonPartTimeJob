//
//  CGFloat.swift
//  AsiaGodTonPartTime
//
//  Created by Ken Lee on 2021/2/23.
//  
//


import Foundation
import UIKit

enum Limitation {
    case upward
    case downward
}

extension CGFloat {
    func toAngle() -> CGFloat {
        return self*2*CGFloat.pi/360
    }

    func limited(_ limitation: Limitation, to value: Self) -> Self {
        if limitation == .upward {
            return self > value ? value : self
        } else {
            return self < value ? value : self
        }
    }

    func focused(between range: ClosedRange<Self>, operation: ((Self) -> Self)? = nil, defaultValue: Self) -> Self {
        return range ~= self ? operation?(self) ?? self : defaultValue
    }

}
