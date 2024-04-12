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
        var partyList: [FetchPartyListResult] = []
        var path = StackState<Path.State>()
    }
    
    public enum Action {
        case didTappedDurationButton
        case didTappedRecruitMemberButton
        case calendar(PickCalendarFeature.Action)
        case partyListResponse([FetchPartyListResult])
        case path(StackAction<Path.State, Path.Action>)
    }
    
    @Dependency (\.partyClient) var partyClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .calendar(.didTappedConfirmButton):
                if (state.calendar?.clickedDates ?? []).isEmpty {
                    return .none
                }
                state.selectedDates = state.calendar?.selectedDates ?? []
                state.calendar = nil
                return .run { [selectedDates = state.selectedDates] send in
                    if selectedDates.count == 1, let date = selectedDates.first {
                        try await send(.partyListResponse(partyClient.fetchPartyList(0, date, date).content))
                    } else if let startDate = selectedDates.first, let endDate = selectedDates.last {
                        try await send(.partyListResponse(partyClient.fetchPartyList(0, startDate, endDate).content))
                    }
                }
            case .didTappedDurationButton:
                state.calendar = .init(month: Date())
                return .none
            case .didTappedRecruitMemberButton:
                state.path.append(.partyRecruit(.init()))
                return .none
            case .partyListResponse(let response):
                state.partyList = response
                return .none
            case .calendar:
                return .none
            case .path:
                return .none
            }
        }
        .ifLet(\.calendar, action: \.calendar) {
            PickCalendarFeature()
        }
    }
    
    @Reducer
    public struct Path {
        @ObservableState
        public enum State: Equatable {
            case partyRecruit(PartyRecruitFeature.State = .init())
        }
        
        public enum Action {
            case partyRecruit(PartyRecruitFeature.Action)
        }
        
        public var body: some Reducer<State, Action> {
            Scope(state: \.partyRecruit, action: \.partyRecruit) {
                PartyRecruitFeature()
            }
        }
    }
    
    
    static public func convertDateToString(dates: [Date]) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        print("##", dates)
        if dates.count == 1, let date = dates.first {
            return formatter.string(from: date)
        } else {
            return "\(formatter.string(from: dates.first ?? Date())) ~ \(formatter.string(from: dates.last ?? Date()))"
        }
    }
}

