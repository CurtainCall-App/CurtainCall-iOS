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
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            TabView {
                HomeView(store: self.store.scope(state: \.home, action: \.home))
                    .tabItem {
                        Image(asset: viewStore.selectedTabbarType == .home ? CommonAsset.tabbarHomeSelected : CommonAsset.tabbarHomeDeselected)
                        Text("홈")
                    }
                    .onAppear {
                        viewStore.send(.didTappedTabbar(.home))
                    }
                    
                ShowView(store: self.store.scope(state: \.show, action: \.show))
                    .tabItem {
                        Image(asset: viewStore.selectedTabbarType == .show ? CommonAsset.tabbarShowSelected : CommonAsset.tabbarShowDeselected)
                        Text("작품")
                    }
                    .onAppear {
                        viewStore.send(.didTappedTabbar(.show))
                    }
                PartyView(store: self.store.scope(state: \.party, action: \.party))
                    .tabItem {
                        Image(asset: viewStore.selectedTabbarType == .party ? CommonAsset.tabbarPartySelected : CommonAsset.tabbarPartyDeselected)
                        Text("파티")
                    }
                    .onAppear {
                        viewStore.send(.didTappedTabbar(.party))
                    }
                MyPageView(store: self.store.scope(state: \.myPage, action: \.myPage))
                    .tabItem {
                        Image(asset: viewStore.selectedTabbarType == .myPage ? CommonAsset.tabbarMySelected : CommonAsset.tabbarMyDeselected)
                        Text("MY")
                    }
                    .onAppear {
                        viewStore.send(.didTappedTabbar(.myPage))
                    }
            }
            .tint(Color(asset: CommonAsset.hex0D1327))
        }
    }
}
