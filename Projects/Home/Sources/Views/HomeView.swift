//
//  HomeView.swift
//  Home
//
//  Created by 김민석 on 2/22/24.
//

import SwiftUI

import ComposableArchitecture

public struct HomeView: View {
    private let store: StoreOf<HomeFeature>
    
    public init(store: StoreOf<HomeFeature>) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            Text("Home")
        }
    }
}
