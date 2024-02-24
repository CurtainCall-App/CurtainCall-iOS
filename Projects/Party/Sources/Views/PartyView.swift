//
//  PartyView.swift
//  Party
//
//  Created by 김민석 on 2/22/24.
//

import SwiftUI

import ComposableArchitecture

public struct PartyView: View {
    private let store: StoreOf<PartyFeature>
    
    public init(store: StoreOf<PartyFeature>) { 
        self.store = store
    }
    
    public var body: some View {
        VStack {
            Text("Party")
        }
    }
}
