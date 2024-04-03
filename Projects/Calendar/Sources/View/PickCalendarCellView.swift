//
//  PickCalendarCellView.swift
//  Calendar
//
//  Created by 김민석 on 4/2/24.
//

import SwiftUI

import ComposableArchitecture

public struct PickCalendarCellView: View {
    
    private let store: StoreOf<PickCalendarCellFeature>
    
    public init(store: StoreOf<PickCalendarCellFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                RoundedRectangle(cornerRadius: 5)
                    .opacity(0)
                    .overlay(Text(String(viewStore.day)))
                    .foregroundColor(.blue)
                    .background(viewStore.isClicked ? .yellow : .clear)
                if viewStore.isClicked {
                    
                }
            }
//            .onTapGesture {
//                viewStore.send(.didTappedDate(date: Date()))
//            }
        }
        
    }
}
