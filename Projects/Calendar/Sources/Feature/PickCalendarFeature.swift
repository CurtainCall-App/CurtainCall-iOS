//
//  PickerCalendarFeature.swift
//  Calendar
//
//  Created by 김민석 on 4/2/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct PickCalendarFeature {
    public init() { }
    
    public struct State: Equatable {
        public init(month: Date) {
            self.month = month
            
            let daysInMonth = Calendar.current.range(of: .day, in: .month, for: month)?.count ?? 0
            self.daysInMonth = daysInMonth
            
            let components = Calendar.current.dateComponents([.year, .month], from: month)
            let firstDayOfMonth = Calendar.current.date(from: components)!
            let firstWeekDay = Calendar.current.component(.weekday, from: firstDayOfMonth)
            self.firstWeekDay = firstWeekDay - 1
        }
        
        var month: Date
        var daysInMonth: Int
        var firstWeekDay: Int
        var clickedDates: Set<Date> = []
    }
    
    public enum Action {
        case didTappedMoveMonthButton(Int)
        case didTappedDate(date: Date)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTappedMoveMonthButton(let i):
                state.month = Calendar.current.date(byAdding: .month, value: i, to: state.month) ?? Date()
                return .none
            case .didTappedDate(let date):
                state.clickedDates.insert(date)
                return .none
            }
        }
    }
    
    
}
