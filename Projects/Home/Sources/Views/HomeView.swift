//
//  HomeView.swift
//  Home
//
//  Created by 김민석 on 2/22/24.
//

import SwiftUI

import Common

import ComposableArchitecture

public struct HomeView: View {
    private let store: StoreOf<HomeFeature>
    
    public init(store: StoreOf<HomeFeature>) {
        self.store = store
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            topbar
            defaultRecommandView
            Spacer()
        }
    }
    
    private var topbar: some View {
        HStack {
            Image(asset: CommonAsset.homeNavigationTitle)
            Spacer()
        }
        .padding(.leading, 20)
        .frame(height: 44)
    }
    
    private var defaultRecommandView: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                HStack {
                    Image(asset: CommonAsset.homeLogo)
                        .padding([.leading, .top], 30)
                    Spacer()
                }
                Spacer()
                HStack {
                    Text("새롭게 바뀐 커튼콜을 확인해보세요!")
                        .foregroundStyle(.white)
                        .font(.body4)
                        .padding(.leading, 30)
                    Spacer()
                }
                HStack {
                    Text("CURTAIN CALL\nRENEWAL")
                        .foregroundStyle(Color.primary2)
                        .font(.heading2)
                        .padding(.top, 20)
                        .padding([.leading, .bottom], 30)
                    Spacer()
                }
                
            }
            .frame(maxWidth: geometry.size.width)
            .frame(height: geometry.size.width - 40)
            .background(Color.primary1)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .padding(.horizontal, 20)
            .onTapGestureRectangle {
                guard let url = URL(string: "https://www.instagram.com/curtaincall_official_"),
                      UIApplication.shared.canOpenURL(url) else { return }
                UIApplication.shared.open(url)
            }
        }
    }
}
