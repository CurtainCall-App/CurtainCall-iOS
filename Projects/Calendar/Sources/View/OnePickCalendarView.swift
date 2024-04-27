//
//  OnePickCalendarView.swift
//  Calendar
//
//  Created by 김민석 on 4/20/24.
//

import SwiftUI

import Common

import ComposableArchitecture

public struct OnePickCalendarView: View {
    
    private let store: StoreOf<OnePickCalendarFeature>
    
    public init(store: StoreOf<OnePickCalendarFeature>) {
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
            .padding(.horizontal, 20)
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
                                    isClicked: store.currentSelectedDate == date,
                                    isSunday: index % 7 == 0,
                                    isSaturday: index % 7 == 6,
                                    date: date,
                                    enableClickAction: store.duringDate.contains(date)
                                )) { PickCalendarCellFeature() }
                        )
                        .onTapGestureRectangle {
                            print("##", date)
                            if store.duringDate.contains(date) {
                                store.send(.didTappedDate(date: date))
                            }
                        }
                        .padding(.vertical, 6)
                    }
                }
            }
            .padding(.horizontal, 20)
            
            bottomView
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
    
    private var bottomView: some View {
        Text("선택완료")
            .font(.subTitle4)
            .foregroundStyle(.black)
            .frame(height: 46)
            .frame(maxWidth: .infinity)
            .background(Color.primary2)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .onTapGestureRectangle {
                store.send(.didTappedConfirmButton)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
    }
}

private extension OnePickCalendarView {
    private func getDate(for day: Int, to month: Date) -> Date {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ko-KR")
        return calendar.date(byAdding: .day, value: day, to: startOfMonth(month: month)) ?? Date()
    }
    
    private func startOfMonth(month: Date) -> Date {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ko-KR")
        let components = calendar.dateComponents([.year, .month], from: month)
        return calendar.date(from: components) ?? Date()
    }
}
