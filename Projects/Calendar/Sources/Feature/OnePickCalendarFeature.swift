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
        public init(month: Date) {
            self.month = month
            
            let daysInMonth = Calendar.current.range(of: .day, in: .month, for: month)?.count ?? 0
            self.daysInMonth = daysInMonth
            
            let components = Calendar.current.dateComponents([.year, .month], from: month)
            let firstDayOfMonth = Calendar.current.date(from: components) ?? Date()
            let firstWeekDay = Calendar.current.component(.weekday, from: firstDayOfMonth)
            self.firstWeekDay = firstWeekDay - 1
        }
        
        var month: Date
        var daysInMonth: Int
        var firstWeekDay: Int
        var currentSelectedDate: Date?
        var selectedDate: Date?
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
                state.month = Calendar.current.date(byAdding: .month, value: i, to: state.month) ?? Date()
                let daysInMonth = Calendar.current.range(of: .day, in: .month, for: state.month)?.count ?? 0
                state.daysInMonth = daysInMonth
                let components = Calendar.current.dateComponents([.year, .month], from: state.month)
                let firstDayOfMonth = Calendar.current.date(from: components) ?? Date()
                let firstWeekDay = Calendar.current.component(.weekday, from: firstDayOfMonth)
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

