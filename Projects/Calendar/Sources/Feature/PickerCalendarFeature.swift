//
//  PickerCalendarFeature.swift
//  Calendar
//
//  Created by 김민석 on 4/2/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct PickerCalendarFeature {
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
        
    }
    
    public enum Action {
        
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
    
    private func getDate(for day: Int, to month: Date) -> Date {
        return Calendar.current.date(byAdding: .day, value: day, to: startOfMonth(month: month))!
    }
    
    private func startOfMonth(month: Date) -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: month)
        return Calendar.current.date(from: components)!
    }
}
