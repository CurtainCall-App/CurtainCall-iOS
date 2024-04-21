//
//  PickCalendarCellFeature.swift
//  Calendar
//
//  Created by 김민석 on 4/3/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct PickCalendarCellFeature {
    public init() { }
    
    @ObservableState
    public struct State: Equatable {
        public init(
            day: Int,
            isClicked: Bool,
            isSunday: Bool,
            isSaturday: Bool,
            date: Date,
            enableClickAction: Bool
        ) {
            self.day = day
            self.isClicked = isClicked
            self.isSunday = isSunday
            self.isSaturday = isSaturday
            self.date = date
            self.enableClickAction = enableClickAction
        }
        
        var day: Int
        var isSunday: Bool
        var isSaturday: Bool
        var isClicked: Bool
        var date: Date
        var enableClickAction: Bool
    }
    
    public enum Action {
        case didTappedDate(date: Date)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}
