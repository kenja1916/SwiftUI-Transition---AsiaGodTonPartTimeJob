//
//  SecondPageView.swift
//  AsiaGodTonPartTime
//
//  Created by Ken Lee on 2021/2/23.
//  
//


import Foundation
import SwiftUI

struct SecondPageView: View {
    @Binding var isPresent: Bool
    var body: some View {
        VStack {
            Spacer()
            Text("SwiftUI")
                .fontWeight(.bold)
                .font(.system(size: 50))
            Spacer()
            Text("Custom")
                .fontWeight(.bold)
                .font(.system(size: 50))
            Spacer()
            Text("Animating")
                .fontWeight(.bold)
                .font(.system(size: 50))
            Spacer()
            Text("Transition")
                .fontWeight(.bold)
                .font(.system(size: 50))
            Spacer()
            Button(action: {
                withAnimation {
                    isPresent.toggle()
//                    progress = progress == 100 ? 0 : 100
                }

            }, label: {
                Text("Dismiss").font(.title).fontWeight(.semibold)
            })
            
        }
    }
}
