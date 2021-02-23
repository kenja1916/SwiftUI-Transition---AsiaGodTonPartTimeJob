//
//  Shake.swift
//  AsiaGodTonPartTime
//
//  Created by Ken Lee on 2021/2/22.
//  
//


import Foundation
import SwiftUI

struct ShakeModifier: AnimatableModifier {
    let degree: Double
    var shakes: Int
    var pct: Double

    var animatableData: Double {
        get { pct }
        set { pct = newValue }
    }

    var shakeDegree: Double {
        let pctPerShake = 100 / Double(shakes)
        let progressPerShake = pct.truncatingRemainder(dividingBy: pctPerShake) / pctPerShake
        return degree*sin(Double.pi*2*progressPerShake)
    }

    func body(content: Content) -> some View {
        content.rotationEffect(Angle(degrees: shakeDegree), anchor: .center)
    }
}

struct ShakeEffect: GeometryEffect {
    let degree: Double
    var shakes: Int
    var pct: Double

    var animatableData: Double {
        get { pct }
        set { pct = newValue }
    }

    var shakeDegree: Double {
        let pctPerShake = 100 / Double(shakes)
        let progressPerShake = pct.truncatingRemainder(dividingBy: pctPerShake) / pctPerShake
        return degree*sin(Double.pi*2*progressPerShake)
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(
            CGAffineTransform(translationX: -size.width/2, y: -size.height/2)
                .concatenating( CGAffineTransform(rotationAngle: CGFloat(shakeDegree).toAngle()))
                .concatenating(CGAffineTransform(translationX: size.width/2, y: size.height/2))
        )
    }
}

