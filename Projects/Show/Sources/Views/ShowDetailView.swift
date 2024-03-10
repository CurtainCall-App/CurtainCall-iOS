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
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Text("디테일 화면")
                .onAppear {
                    viewStore.send(.fetchDetailResponse)
                }
        }
        
            
    }
}

