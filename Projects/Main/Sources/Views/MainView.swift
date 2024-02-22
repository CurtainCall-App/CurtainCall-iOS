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

public struct MainView: View {
    public init() { }
    
    public var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Text("홈")
                }
            ShowView()
                .tabItem {
                    Text("작품")
                }
            PartyView()
                .tabItem {
                    Text("파티")
                }
            MyPageView()
                .tabItem {
                    Text("MY")
                }
        }
    }
}
