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
        public var clickedDates: Set<Date> = []
        var startDate: Date?
        var endDate: Date?
        public var selectedDates: [Date] = []
    }
    
    public enum Action {
        case didTappedMoveMonthButton(Int)
        case didTappedDate(date: Date)
        case didTappedResetbutton
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
                if state.startDate == nil && state.endDate == nil {
                    state.startDate = date
                    state.clickedDates.insert(date)
                } else if state.startDate != nil, state.endDate == nil {
                    state.endDate = date
                    if state.startDate ?? Date() > state.endDate ?? Date() {
                        let temp = state.startDate ?? Date()
                        state.startDate = state.endDate
                        state.endDate = temp
                    }
                    
                    let components = Calendar.current.dateComponents([.day], from: state.startDate ?? Date(), to: state.endDate ?? Date())
                    if let days = components.day {
                        for day in 0..<days {
                            if let date = Calendar.current.date(byAdding: .day, value: day, to: state.startDate ?? Date()) {
                                state.clickedDates.insert(date)
                            }
                            state.clickedDates.insert(date)
                        }
                    }
                    
                } else {
                    state.startDate = date
                    state.endDate = nil
                    state.clickedDates = [date]
                }
                return .none
            case .didTappedResetbutton:
                state.startDate = nil
                state.endDate = nil
                state.clickedDates = []
                state.selectedDates = []
                return .none
            case .didTappedConfirmButton:
                state.selectedDates = state.clickedDates.sorted { $0 < $1 }
                return .none
            }
        }
    }
    
    
}
