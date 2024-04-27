//
//  PartyRecruitFeature.swift
//  Party
//
//  Created by 김민석 on 4/11/24.
//

import Foundation

import Common
import Show
import Calendar

import ComposableArchitecture

@Reducer
public struct PartyRecruitFeature {
    
    enum ViewType {
        case step1
        case step2
        case step3
    }
    
    @ObservableState
    public struct State: Equatable {
        public init() { }
        var viewType: ViewType = .step1
        var selectedShowType: ShowFeature.ShowType = .theater
        var selectedCategory: ShowSortFeature.CategoryType = .popular
        var selectedShow: ShowResponseContent?
        var showList: [ShowResponseContent] = []
        var page: Int = 0
        var isPossibleNextButton = false
        var partyDate: Date?
        var partyTime: String?
        var calendar: OnePickCalendarFeature.State?
        var timeSelect: TimeSelectFeature.State?
        var partyMemberCount: Int = 1
        @Presents var bottomSheet: ShowSortFeature.State?
        var partyTitle: String = ""
        var partyContent: String = ""
        var isSuccessCreateParty: Bool = false
        var isFailedToCreateParty: Bool = false
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case fetchShowList(page: Int)
        case showListResponse([ShowResponseContent])
        case didScrollToLastItem
        case didTappedCategoryButton
        case bottomSheet(PresentationAction<ShowSortFeature.Action>)
        case didTappedNextButton
        case didTappedShowItem(ShowResponseContent)
        case didTappedShowTypeButton(ShowFeature.ShowType)
        case didTappedSelectedShowDate
        case didTappedSelectedShowTime
        case didTappedStepper(Int)
        case calendar(OnePickCalendarFeature.Action)
        case timeSelect(TimeSelectFeature.Action)
        case successCreateParty(CreatePartyResponseDTO)
        case failToCreateParty
        case dismissToast
    }
    
    @Dependency (\.showClient) var showClient
    @Dependency (\.partyClient) var partyClient
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding(\.partyTitle):
                state.isPossibleNextButton = !state.partyTitle.isEmpty && !state.partyContent.isEmpty
                return .none
            case .binding(\.partyContent):
                state.isPossibleNextButton = !state.partyTitle.isEmpty && !state.partyContent.isEmpty
                return .none
            case .fetchShowList(let page):
                state.page = page
                return .run { [
                    showType = state.selectedShowType,
                    categoryType = state.selectedCategory
                ] send in
                    try await send(.showListResponse(self.showClient.fetchShowList(page, showType, categoryType).content))
                }
            case .showListResponse(let response):
                state.showList.append(contentsOf: response)
                return .none
            case .didTappedCategoryButton:
                state.bottomSheet = .init(categoryType: state.selectedCategory)
                return .none
            case .didTappedNextButton:
                if !state.isPossibleNextButton { return .none }
                switch state.viewType {
                case .step1:
                    state.isPossibleNextButton = false
                    state.viewType = .step2
                    return .none
                case .step2:
                    state.isPossibleNextButton = false
                    state.viewType = .step3
                    return .none
                case .step3:
                    guard state.isPossibleNextButton,
                          !state.isFailedToCreateParty,
                          let show = state.selectedShow,
                          let date = state.partyDate,
                          let time = state.partyTime else { return .none }
                    let dateString = Utils.convertDateToAPIString(date: date)
                    let APIDate = dateString + "T" + time + ":00"
                    return .run { [
                        title = state.partyTitle,
                        content = state.partyContent,
                        maxCount = state.partyMemberCount
                    ] send in
                        do {
                            try await send(.successCreateParty(partyClient.createParty(
                                .init(
                                    showId: show.id,
                                    showAt: APIDate,
                                    title: title,
                                    content: content,
                                    maxMemberNum: maxCount)))
                            )
                        } catch {
                            await send(.failToCreateParty)
                        }
                    }
                    .animation()
                }
            case .didTappedShowItem(let item):
                state.selectedShow = nil
                state.selectedShow = item
                state.isPossibleNextButton = state.selectedShow != nil
                return .none
            case .didScrollToLastItem:
                return .run { [page = state.page] send in
                    await send(.fetchShowList(page: page + 1))
                }
            case .didTappedShowTypeButton(let type):
                if type == state.selectedShowType {
                    return .none
                }
                state.selectedShowType = type
                state.showList = []
                state.page = 0
                return .run { [page = state.page] send in
                    await send(.fetchShowList(page: page))
                }
            case .bottomSheet(.presented(.didTappedCategory(let type))):
                defer { state.bottomSheet = nil }
                if state.selectedCategory == type { return .none }
                state.selectedCategory = type
                state.showList = []
                return .run { send in
                    await send(.fetchShowList(page: 0))
                }
            case .didTappedSelectedShowDate:
                guard let startDateString = state.selectedShow?.startDate,
                      let startDate = Utils.convertDateStringToDate(dateString: startDateString),
                      let endDateString = state.selectedShow?.endDate,
                      let endDate = Utils.convertDateStringToDate(dateString: endDateString) else {
                    return .none
                }
                let components = Calendar.current.dateComponents([.day],
                                                                 from: startDate,
                                                                 to: endDate
                )
                var duringDate: Set<Date> = []
                if let days = components.day {
                    for day in 0...days {
                        if let date = Calendar.current.date(byAdding: .day, value: day, to: startDate) {
                            duringDate.insert(date.addingTimeInterval(54000))
                        }
                    }
                }
                duringDate.insert(endDate)
                state.timeSelect = nil
                state.partyTime = nil
                state.calendar = .init(month: Date(), duringDate: duringDate)
                return .none
            case .didTappedSelectedShowTime:
                guard let show = state.selectedShow,
                      let partyDate = state.partyDate,
                      let dayOfWeek = DayOfWeek(week: Calendar.current.component(.weekday, from: partyDate)) else { return .none }
                let timesString = show.showTimes.filter { $0.dayOfWeek == dayOfWeek }.map { $0.time }
                let times = timesString.map { $0.split { $0 == ":" }.dropLast().joined(separator: ":") }
                state.timeSelect = .init(times: times)
                return .none
            case .didTappedStepper(let i):
                guard state.partyMemberCount + i >= 1 else { return .none }
                state.partyMemberCount += i
                return .none
            case .calendar(.didTappedConfirmButton):
                state.partyDate = state.calendar?.selectedDate
                state.calendar = nil
                state.isPossibleNextButton = state.partyTime != nil && state.partyDate != nil
                return .none
            case .calendar: return .none
            case .timeSelect(.didTappedTime(let time)):
                state.partyTime = time
                state.timeSelect = nil
                state.isPossibleNextButton = state.partyTime != nil && state.partyDate != nil
                return .none
            case .successCreateParty:
                state.isSuccessCreateParty = true
                return .none
            case .failToCreateParty:
                state.isFailedToCreateParty = true
                return .run { send in
                    try await Task.sleep(for: .seconds(1))
                    await send(.dismissToast)
                }.animation()
            case .dismissToast:
                state.isFailedToCreateParty = false
                state.isSuccessCreateParty = false
                return .none
            case .timeSelect: return .none
            case .bottomSheet: return .none
            case .binding: return .none
            }
        }
        .ifLet(\.$bottomSheet, action: \.bottomSheet) {
            ShowSortFeature()
        }
        .ifLet(\.calendar, action: \.calendar) {
            OnePickCalendarFeature()
        }
        .ifLet(\.timeSelect, action: \.timeSelect) {
            TimeSelectFeature()
        }
    }
}
