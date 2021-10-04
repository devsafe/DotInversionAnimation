//
//  Home.swift
//  DotInversionAnimation
//
//  Created by Boris Sobolev on 04.10.2021.
//

import SwiftUI

struct Home: View {
    var body: some View {
        ZStack {
            Color("Gold")
            
            ExpandedView()
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
