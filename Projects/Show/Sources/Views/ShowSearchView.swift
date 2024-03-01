//
//  ShowSearchView.swift
//  Show
//
//  Created by 김민석 on 3/1/24.
//

import SwiftUI

import ComposableArchitecture

public struct ShowSearchView: View {
    private let store: StoreOf<ShowSearchFeature>
    
    public init(store: StoreOf<ShowSearchFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Text("하이")
        }
    }
}
