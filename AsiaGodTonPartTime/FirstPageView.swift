//
//  FirstPageView.swift
//  AsiaGodTonPartTime
//
//  Created by Ken Lee on 2021/2/22.
//  
//


import SwiftUI


struct FirstPageView: View {
    @State var isStart: Bool = false

    var body: some View {
        ZStack {
            Button(action: { isStart.toggle()}, label: {
                Text("Present").font(.title).fontWeight(.semibold)
            })
            
            if isStart {
                SecondPageView(isPresent: $isStart)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(UIColor.cyan))
                    .transition(AnyTransition.asiaGodTon.animation(.linear(duration: 2)))
            }
        }
    }
}

struct FirstPageView_Previews: PreviewProvider {
    static var previews: some View {
        FirstPageView()
    }
}
