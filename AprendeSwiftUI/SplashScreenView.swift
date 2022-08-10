//
//  SplashScreenView.swift
//  AprendeSwiftUI
//
//  Created by alp1 on 25/7/22.
//

import SwiftUI

struct SplashScreenView: View {
    @State var isActive : Bool = false
    var body: some View {
        if isActive {
            ContentView()
        } else {
            VStack {
                VStack {
                    Image(systemName: "curlybraces")
                        .font(.system(size: 60))
                        .foregroundColor(.red)
                        .padding()
                    
                    Text("Aprende SwiftUI")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black.opacity(0.80))
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
