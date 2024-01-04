//
//  LoginView.swift
//  CurtainCall
//
//  Created by 김민석 on 1/2/24.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Image(ImageNamespace.loginButtonKakao)
                Image(ImageNamespace.loginButtonApple)
            }
            Spacer()
        }
    }
}
