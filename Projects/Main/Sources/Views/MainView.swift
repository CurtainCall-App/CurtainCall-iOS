//
//  MainView.swift
//  ProjectDescriptionHelpers
//
//  Created by 김민석 on 2/22/24.
//

import SwiftUI

import Home
import Show
import Party
import MyPage
import Common

import ComposableArchitecture

public struct MainView: View {
    private let store: StoreOf<MainFeature>
    
    public init(store: StoreOf<MainFeature>) {
        self.store = store
    }
    
    public var body: some View {
        TabView {
            HomeView(store: self.store.scope(state: \.home, action: \.home))
                .tabItem {
                    Image(asset: store.selectedTabbarType == .home ? CommonAsset.tabbarHomeSelected : CommonAsset.tabbarHomeDeselected)
                    Text("홈")
                }
                .onAppear {
                    store.send(.didTappedTabbar(.home))
                }
            
            ShowView(store: self.store.scope(state: \.show, action: \.show))
                .tabItem {
                    Image(asset: store.selectedTabbarType == .show ? CommonAsset.tabbarShowSelected : CommonAsset.tabbarShowDeselected)
                    Text("작품")
                }
                .onAppear {
                    store.send(.didTappedTabbar(.show))
                }
            PartyView(store: self.store.scope(state: \.party, action: \.party))
                .tabItem {
                    Image(asset: store.selectedTabbarType == .party ? CommonAsset.tabbarPartySelected : CommonAsset.tabbarPartyDeselected)
                    Text("파티")
                }
                .onAppear {
                    store.send(.didTappedTabbar(.party))
                }
            MyPageView(store: self.store.scope(state: \.myPage, action: \.myPage))
                .tabItem {
                    Image(asset: store.selectedTabbarType == .myPage ? CommonAsset.tabbarMySelected : CommonAsset.tabbarMyDeselected)
                    Text("MY")
                }
                .onAppear {
                    store.send(.didTappedTabbar(.myPage))
                }
        }
        .tint(Color(asset: CommonAsset.hex0D1327))
        
    }
}
