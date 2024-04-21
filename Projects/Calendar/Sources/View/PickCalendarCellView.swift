//
//  PickCalendarCellView.swift
//  Calendar
//
//  Created by 김민석 on 4/2/24.
//

import SwiftUI

import Common

import ComposableArchitecture

public struct PickCalendarCellView: View {
    
    private let store: StoreOf<PickCalendarCellFeature>
    
    public init(store: StoreOf<PickCalendarCellFeature>) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            Text(String(store.day))
                .foregroundColor(
                    store.isSunday ? Color.red : store.isSaturday ? Color.blue : Color.gray1
                )
                .font(.body2_M)
                .opacity(store.enableClickAction ? 1 : 0.5)
                .background(
                    Circle()
                        .foregroundStyle(store.isClicked ? Color.primary2 : .clear)
                        .frame(width: 32, height: 32)
                    )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        
        
    }
}
