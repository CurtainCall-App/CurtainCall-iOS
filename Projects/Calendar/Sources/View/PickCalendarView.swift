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
        VStack(spacing: 0) {
            topView
            Color.gray8.frame(height: 1)
            HStack {
                ForEach(Utils.weekdaySymbols, id: \.self) { symbol in
                    Text(symbol)
                        .font(.body2_SB)
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.top, 18)
            .padding(.bottom, 16)
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 32, maximum: .infinity), spacing: 0), count: 7), spacing: 12) {
                ForEach(0..<store.daysInMonth + store.firstWeekDay, id: \.self) { index in
                    if index < store.firstWeekDay {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundStyle(.clear)
                    } else {
                        let day = index - store.firstWeekDay + 1
                        let date = getDate(for: index, to: store.month)
                        
                        PickCalendarCellView(
                            store: .init(
                                initialState: PickCalendarCellFeature.State(
                                    day: day,
                                    isClicked: store.startDate == date || store.endDate == date,
                                    isSunday: index % 7 == 0,
                                    isSaturday: index % 7 == 6,
                                    date: date
                                )) { PickCalendarCellFeature() }
                        )
                        .onTapGestureRectangle {
                            store.send(.didTappedDate(date: date))
                        }
                        .padding(.vertical, 6)
                        .background {
                            if store.clickedDates.contains(date) && store.startDate != nil && store.endDate != nil {
                                if date == store.startDate {
                                    HStack {
                                        Color.clear.frame(height: 32)
                                        Color.primary2.frame(height: 32)
                                            .opacity(0.4)
                                    }
                                } else if date != store.startDate && date != store.endDate {
                                    Color.primary2.frame(height: 32)
                                        .opacity(0.4)
                                } else if date == store.endDate {
                                    HStack {
                                        Color.primary2.frame(height: 32)
                                            .opacity(0.4)
                                        Color.clear.frame(height: 32)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private var topView: some View {
        HStack(spacing: 10) {
            Spacer()
            Image(asset: CommonAsset.calendarBackIcon16px)
                .onTapGestureRectangle {
                    store.send(.didTappedMoveMonthButton(-1))
                }
            Text(store.month, formatter: Utils.yearMonthDateFormatter)
                .font(.subTitle4)
                .foregroundStyle(Color.gray1)
            Image(asset: CommonAsset.calendarNextIcon16px)
                .onTapGestureRectangle {
                    store.send(.didTappedMoveMonthButton(1))
                }
            Spacer()
        }
        .frame(height: 62)
        
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
