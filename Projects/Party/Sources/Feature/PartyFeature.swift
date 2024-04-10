//
//  PartyFeature.swift
//  Party
//
//  Created by 김민석 on 2/22/24.
//

import Foundation

import Calendar

import ComposableArchitecture

@Reducer
public struct PartyFeature {
    public init() { }
    
    @ObservableState
    public struct State: Equatable {
        public init() { }
        var calendar: PickCalendarFeature.State?
        var selectedDates: [Date] = []
    }
    
    public enum Action {
        case didTappedDurationButton
        case calendar(PickCalendarFeature.Action)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .calendar(.didTappedConfirmButton):
                state.selectedDates = state.calendar?.selectedDates ?? []
                state.calendar = nil
                return .none
            case .didTappedDurationButton:
                state.calendar = .init(month: Date())
                return .none
            case .calendar:
                return .none
            }
        }
        .ifLet(\.calendar, action: \.calendar) {
            PickCalendarFeature()
        }
    }
    
    static public func convertDateToString(dates: [Date]) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        if dates.count == 1, let date = dates.first {
            return formatter.string(from: date)
        } else {
            return "\(formatter.string(from: dates[0])) ~ \(formatter.string(from: dates[1]))"
        }
    }
}

