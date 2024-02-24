//
//  MainFeature.swift
//  Main
//
//  Created by 김민석 on 2/22/24.
//

import Foundation
import Home
import Show
import Party
import MyPage


import ComposableArchitecture


@Reducer
public struct MainFeature {
    public init() { }
    
    public enum TabbarType {
        case home
        case show
        case party
        case myPage
    }
    
    public struct State: Equatable {
        public init() { }
        var selectedTabbarType: TabbarType = .home
        var home = HomeFeature.State()
        var show = ShowFeature.State()
        var party = PartyFeature.State()
        var myPage = MyPageFeature.State()
    }
    
    public enum Action {
        case home(HomeFeature.Action)
        case show(ShowFeature.Action)
        case party(PartyFeature.Action)
        case myPage(MyPageFeature.Action)
        case didTappedTabbar(TabbarType)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .home: return .none
            case .show: return .none
            case .party: return .none
            case .myPage: return .none
            case .didTappedTabbar(let type):
                state.selectedTabbarType = type
                return .none
            }
        }
    }
}
