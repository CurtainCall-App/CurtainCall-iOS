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
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Text(String(viewStore.day))
                    .foregroundColor(
                        viewStore.isSunday ? Color.red : viewStore.isSaturday ? Color.blue : Color.gray1
                    )
                    .font(.body2_M)
                    .opacity(viewStore.date < Date() ? 0.5 : 1)
                    .background(
                        Circle()
                            .foregroundStyle(viewStore.isClicked ? Color.primary2 : .clear)
                            .frame(width: 32, height: 32)
                        )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        
    }
}
