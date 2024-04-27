//
//  PartyDetailView.swift
//  Party
//
//  Created by 김민석 on 4/27/24.
//

import SwiftUI

import ComposableArchitecture

struct PartyDetailView: View {
    private let store: StoreOf<PartyDetailFeature>
    
    public init(store: StoreOf<PartyDetailFeature>) {
        self.store = store
    }
    
    public var body: some View {
        Text("Detail")
    }
}


