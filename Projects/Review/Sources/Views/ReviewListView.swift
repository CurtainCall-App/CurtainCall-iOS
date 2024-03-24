//
//  ReviewListView.swift
//  Review
//
//  Created by 김민석 on 3/24/24.
//

import SwiftUI

import Common
import ComposableArchitecture

struct ReviewListView: View {
    
    private let store: StoreOf<ReviewListFeature>
    
    public init(store: StoreOf<ReviewListFeature>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Text("리뷰리스트")
        }

    }
}


