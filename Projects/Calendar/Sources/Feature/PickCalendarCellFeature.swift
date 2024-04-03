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
    
    public struct State: Equatable {
        public init(day: Int, isClicked: Bool) {
            self.day = day
            self.isClicked = isClicked
        }
        
        var day: Int
        var isClicked: Bool
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
