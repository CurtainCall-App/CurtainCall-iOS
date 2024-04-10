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
    
    public struct State: Equatable {    
        public init() { }
        var calendar: PickCalendarFeature.State?
    }
    
    public enum Action {
        case didTappedDurationButton
        case calendar(PickCalendarFeature.Action)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .calendar:
                return .none
            case .didTappedDurationButton:
                state.calendar = .init(month: Date())
                return .none
            }
        }
        .ifLet(\.calendar, action: \.calendar) {
            PickCalendarFeature()
        }
    }
}

