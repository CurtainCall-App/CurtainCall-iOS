//
//  ShowView.swift
//  Show
//
//  Created by 김민석 on 2/22/24.
//

import SwiftUI

import ComposableArchitecture

public struct ShowView: View {
    private let store: StoreOf<ShowFeature>
    
    public init(store: StoreOf<ShowFeature>) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            Text("Show")
        }
    }
}
