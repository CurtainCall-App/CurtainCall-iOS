//
//  PickCalendar.swift
//  Calendar
//
//  Created by 김민석 on 4/2/24.
//

import SwiftUI

import Common

import ComposableArchitecture

public struct PickCalendarView: View {
    
    private let store: StoreOf<PickCalendarFeature>
    
    public init(store: StoreOf<PickCalendarFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                topView
                LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                    ForEach(0..<viewStore.daysInMonth + viewStore.firstWeekDay, id: \.self) { index in
                        if index < viewStore.firstWeekDay {
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundStyle(.clear)
                        } else {
                            let day = index - viewStore.firstWeekDay + 1
                            let date = getDate(for: index, to: viewStore.month)

                            PickCalendarCellView(
                                store: .init(
                                    initialState: PickCalendarCellFeature.State(
                                        day: day,
                                        isClicked: viewStore.clickedDates.contains(date)
                                    )) { PickCalendarCellFeature() }
                            )
                            .onTapGestureRectangle {
                                viewStore.send(.didTappedDate(date: date))
                            }
                        }
                    }
                }
            }
            
        }
    }
    
    private var topView: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                HStack(spacing: 10) {
                    Spacer()
                    Image(asset: CommonAsset.calendarBackIcon16px)
                        .onTapGestureRectangle {
                            viewStore.send(.didTappedMoveMonthButton(-1))
                        }
                    Text(viewStore.month, formatter: Utils.yearMonthDateFormatter)
                    Image(asset: CommonAsset.calendarNextIcon16px)
                        .onTapGestureRectangle {
                            viewStore.send(.didTappedMoveMonthButton(1))
                        }
                    Spacer()
                }
                .frame(height: 62)
            }
        }
    }
}

private extension PickCalendarView {
    private func getDate(for day: Int, to month: Date) -> Date {
        return Calendar.current.date(byAdding: .day, value: day, to: startOfMonth(month: month)) ?? Date()
    }
    
    private func startOfMonth(month: Date) -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: month)
        return Calendar.current.date(from: components)!
    }
}
