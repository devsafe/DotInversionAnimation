//
//  Home.swift
//  DotInversionAnimation
//
//  Created by Boris Sobolev on 04.10.2021.
//

import SwiftUI

struct Home: View {
    
    @State var dotState: DotState = .normal
    @State var dotScale: CGFloat = 1
    @State var dotRotation : Double = 0
    
    @State var isAnimating = false
    var body: some View {
        ZStack {
            ZStack {
                (dotState == .normal ? Color("Gold") : Color("Grey"))
                if dotState == .normal {
                    MinimisedView()
                }
                else {
                    ExpandedView()
                }
                
            }
            .animation(.none, value: dotState)
            
            Rectangle()
                .fill(dotState != .normal ? Color("Gold") : Color("Grey"))
                .overlay(
                
                    ZStack {
                        if dotState != .normal {
                            MinimisedView()
                        }
                        else {
                            ExpandedView()
                        }
                    }
                )
                .animation(.none, value: dotState)
                .mask(
                
                    GeometryReader{proxy in
                        Circle()
                            
                            .frame(width: 100, height: 100)
                            .scaleEffect(dotScale)
                            .rotation3DEffect(.init(degrees: dotRotation), axis: (x: 0, y: 1, z: 0), anchorZ: dotState == .flipped ? -10 : 10, perspective: 1)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                            .offset(y: -60)
                        
                    }
                )
            Circle()
                .foregroundColor(Color.black.opacity(0.01))
                .frame(width: 100, height: 100)
                .overlay(
                Image(systemName: "chevron.right")
                    .font(.title)
                    .foregroundColor(.white)
                    .opacity(isAnimating ? 0 : 1)
                    .animation(.easeInOut(duration: 0.4), value: isAnimating)
                     
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)

                .onTapGesture(perform: {
                    if isAnimating{return}
                    isAnimating = true
                    if dotState == .flipped {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.725) {
                            withAnimation(.linear(duration: 0.7)){
                               // dotRotation = -180
                                dotScale = 1
                                dotState = .normal
                            }
                        }
                            withAnimation(.linear(duration: 1.5)){
                                dotRotation = 0
                                dotScale = 8
                            }

                    }
                else{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.725) {
                        withAnimation(.linear(duration: 0.7)){
                           // dotRotation = -180
                            dotScale = 1
                            dotState = .flipped
                        }
                    }
                        withAnimation(.linear(duration: 1.5)){
                            dotRotation = -180
                            dotScale = 8
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
                        isAnimating = false
                    }
                })
                .offset(y: -60)
        }
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    func ExpandedView()->some View {
        VStack(spacing: 10) {
            Image(systemName: "ipad")
                .font(.system(size: 145))
            Text("iPad")
                .font(.system(size: 38).bold())
        }
        .foregroundColor(.white)
    }
    
    @ViewBuilder
    func MinimisedView()->some View {
        VStack(spacing: 10) {
            Image(systemName: "applewatch")
                .font(.system(size: 145))
            Text("Apple Watch")
                .font(.system(size: 38).bold())
        }
        .foregroundColor(.white)
    }
        
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


enum DotState {
    case normal
    case flipped
}
