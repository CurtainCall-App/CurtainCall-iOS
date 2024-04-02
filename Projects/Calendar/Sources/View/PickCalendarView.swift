//
//  PickCalendar.swift
//  Calendar
//
//  Created by 김민석 on 4/2/24.
//

import SwiftUI

import ComposableArchitecture

public struct PickCalendarView: View {
    
    private let store: StoreOf<PickerCalendarFeature>
    
    public init(store: StoreOf<PickerCalendarFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                    ForEach(0..<viewStore.daysInMonth + viewStore.firstWeekDay, id: \.self) { index in
                        if index < viewStore.firstWeekDay {
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundStyle(.clear)
                        } else {
                            let day = index - viewStore.firstWeekDay + 1
                            PickCalendarCellView(day: day, clicked: false)
                        }
                        
                    }
                }
            }
        }
    }
}
