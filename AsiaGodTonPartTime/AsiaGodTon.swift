//
//  AsiaGodTonTransition.swift
//  AsiaGodTonPartTime
//
//  Created by Ken Lee on 2021/2/23.
//  
//


import Foundation
import SwiftUI

struct ManEffect: AnimatableModifier {

    var progress: Double // 0-100

    let walkRatio: Double = 80

    let fallRatio: Double = 20

    let xLength: CGFloat
    let yLength: CGFloat

    var animatableData: Double {
        get { return progress }
        set { progress = newValue }
    }

    func body(content: Content) -> some View {
        return content
            .modifier(ShakeEffect(degree: 10, shakes: 3, pct: progress.focused(between: 0...walkRatio, defaultValue: walkRatio)*100/walkRatio))
            .rotationEffect(Angle(degrees: 80*(progress.focused(between: walkRatio...100, operation: { $0 - walkRatio }, defaultValue: 0)/fallRatio)), anchor: .center)
            .transformEffect(CGAffineTransform(translationX: -xLength*CGFloat(progress.focused(between: 0...walkRatio, defaultValue: walkRatio)/walkRatio), y: -yLength*CGFloat(progress.focused(between: 0...walkRatio, defaultValue: walkRatio)/walkRatio))
                                .concatenating(CGAffineTransform(translationX: xLength/2, y: yLength/2)))
            .transformEffect(
                CGAffineTransform(translationX: (xLength/2)*CGFloat(progress.focused(between: walkRatio...100, operation: { (value) -> Double in
                    value - walkRatio
                }, defaultValue: 0)/fallRatio),
                y: (yLength/2)*CGFloat(progress.focused(between: walkRatio...100, operation: { (value) -> Double in
                    value - walkRatio
                }, defaultValue: 0)/fallRatio))
                .concatenating(CGAffineTransform(translationX: xLength/2, y: yLength/2)))

    }
}

struct TonEffect: AnimatableModifier {

    var progress: Double // 0-100

    let walkRatio: Double = 80

    let fallRatio: Double = 20

    let xLength: CGFloat
    let yLength: CGFloat

    var xDis: CGFloat { xLength/2 }

    var yDis: CGFloat { yLength/2 }

    var animatableData: Double {
        get { return progress }
        set { progress = newValue }
    }

    func body(content: Content) -> some View {
        let x: CGFloat = progress > walkRatio ? xDis - (-(xLength) +  xDis)*CGFloat((progress-walkRatio)/fallRatio) : xDis
        let y: CGFloat = progress > walkRatio ? yDis - yDis*CGFloat((progress-walkRatio)/fallRatio): yDis
        return content
            .scaleEffect(progress > walkRatio ? 0.3+0.7*CGFloat(progress-80)/20 : 0.3)
            .modifier(ShakeEffect(degree: 10, shakes: 3, pct: progress.focused(between: 0...walkRatio, defaultValue: walkRatio)*100/walkRatio))
            .rotationEffect(Angle(degrees: 360*(progress.focused(between: walkRatio...100, operation: { (value) -> Double in
                value - walkRatio
            }, defaultValue: 0)/fallRatio)), anchor: .center)

            .transformEffect(
                CGAffineTransform(translationX: -xLength*CGFloat(progress.focused(between: 0...walkRatio, defaultValue: walkRatio)/walkRatio),
                                  y: -yLength*CGFloat(progress.focused(between: 0...walkRatio, defaultValue: walkRatio)/walkRatio))
                    .concatenating(CGAffineTransform(translationX: x,
                                                     y: y)))
            .transformEffect(
                CGAffineTransform(translationX: -(xLength)*CGFloat(progress.focused(between: walkRatio...100, operation: { (value) -> Double in
                    value - walkRatio
                }, defaultValue: 0)/fallRatio),
                y: (yLength)*CGFloat(progress.focused(between: walkRatio...100, operation: { (value) -> Double in
                    value - walkRatio
                }, defaultValue: 0)/fallRatio))
                .concatenating(CGAffineTransform(translationX: x,
                                                 y: y)))
    }
}

struct AsiaGodTonView: View {
    @Binding var progress: Double

    var body: some View {
        ZStack {
            Image("ton")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .modifier(TonEffect(progress: progress, xLength: 150, yLength: 150))
                .animation(.linear(duration: 1))


            Image("man")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .modifier(ManEffect(progress: progress, xLength: 150, yLength: 150))
                .animation(.linear(duration: 1))
        }

    }
}

struct AsiaGodTonModifier: AnimatableModifier {
    var progress: Double

    var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }

    func body(content: Content) -> some View {
        GeometryReader { proxy in

            ZStack {
                content
                    .modifier(TonEffect(progress: progress.focused(between: 0...70, defaultValue: 70)*100/70, xLength: proxy.size.width/2, yLength: proxy.size.height/2))
                    .zIndex(progress >= 80 ? 3 : 1)
                    .animation(.default)

                Image("man")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .modifier(ManEffect(progress: progress.focused(between: 0...70, defaultValue: 70)*100/70, xLength: proxy.size.width/2, yLength: proxy.size.height/2))
                    .zIndex(2)
                    .animation(.default)
                    .opacity(progress == 100 ? 0 : 1)
                    .animation(nil)
            }
        }
    }
}

extension AnyTransition {
    static var asiaGodTon: AnyTransition {
        get {
            AnyTransition.modifier(active: AsiaGodTonModifier(progress: 0),
                                   identity: AsiaGodTonModifier(progress: 100))
        }
    }

}
