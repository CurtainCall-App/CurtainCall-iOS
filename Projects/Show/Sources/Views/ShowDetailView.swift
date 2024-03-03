//
//  ShowDetailView.swift
//  Show
//
//  Created by 김민석 on 3/3/24.
//

import SwiftUI

import ComposableArchitecture

public struct ShowDetailView: View {
    private let store: StoreOf<ShowDetailFeature>
    
    public init(store: StoreOf<ShowDetailFeature>) {
        self.store = store
    }
    
    public var body: some View {
        Text("디테일 화면")
    }
}

