//
//  SplashView.swift
//  CurtainCall
//
//  Created by 김민석 on 12/28/23.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack(alignment: .center) {
            Color.pointColor1
            VStack {
                Spacer()
                Image(ImageNamespace.splashLogo)
                Spacer()
            }
        }
        .ignoresSafeArea()
    }
}
