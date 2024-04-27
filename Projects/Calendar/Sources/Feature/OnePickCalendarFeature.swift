//
//  OnePickCalendarFeature.swift
//  Calendar
//
//  Created by 김민석 on 4/20/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct OnePickCalendarFeature {
    public init() { }
    
    @ObservableState
    public struct State: Equatable {
        public init(month: Date, duringDate: Set<Date>) {
            var calendar = Calendar.current
            calendar.locale = Locale(identifier: "ko-KR")
            
            self.month = month
            
            let daysInMonth = calendar.range(of: .day, in: .month, for: month)?.count ?? 0
            self.daysInMonth = daysInMonth
            
            let components = calendar.dateComponents([.year, .month], from: month)
            let firstDayOfMonth = calendar.date(from: components) ?? Date()
            let firstWeekDay = calendar.component(.weekday, from: firstDayOfMonth)
            self.firstWeekDay = firstWeekDay - 1
            
            self.duringDate = duringDate
        }
        
        var month: Date
        var duringDate: Set<Date>
        var daysInMonth: Int
        var firstWeekDay: Int
        var currentSelectedDate: Date?
        public var selectedDate: Date?
    }
    
    public enum Action {
        case didTappedMoveMonthButton(Int)
        case didTappedDate(date: Date)
        case didTappedConfirmButton
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTappedMoveMonthButton(let i):
                var calendar = Calendar.current
                calendar.locale = Locale(identifier: "ko-KR")
                state.month = calendar.date(byAdding: .month, value: i, to: state.month) ?? Date()
                let daysInMonth = calendar.range(of: .day, in: .month, for: state.month)?.count ?? 0
                state.daysInMonth = daysInMonth
                let components = calendar.dateComponents([.year, .month], from: state.month)
                let firstDayOfMonth = calendar.date(from: components) ?? Date()
                let firstWeekDay = calendar.component(.weekday, from: firstDayOfMonth)
                state.firstWeekDay = firstWeekDay - 1
                return .none
            case .didTappedDate(let date):
                state.currentSelectedDate = nil
                state.currentSelectedDate = date
                return .none
            case .didTappedConfirmButton:
                state.selectedDate = state.currentSelectedDate
                state.currentSelectedDate = nil
                return .none
            }
        }
    }
    
    
}

