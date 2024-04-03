//
//  PartyView.swift
//  Party
//
//  Created by 김민석 on 2/22/24.
//

import SwiftUI

import Calendar

import ComposableArchitecture

public struct PartyView: View {
    private let store: StoreOf<PartyFeature>
    
    public init(store: StoreOf<PartyFeature>) { 
        self.store = store
    }
    
    public var body: some View {
        VStack {
            PickCalendarView(
                store: .init(
                    initialState: PickCalendarFeature.State(
                        month: Date()
                    )) {
                PickCalendarFeature()
                    ._printChanges()
            })
        }
    }
}
