//
//  ReviewWriteFeature.swift
//  Review
//
//  Created by 김민석 on 3/17/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct ReviewWriteFeature {
    public init() { }
    
    public struct State: Equatable {
        public init(showInfo: ReviewWriteViewComponents) {
            self.showInfo = showInfo
        }
        let showInfo: ReviewWriteViewComponents
        @BindingState var grade: Double = 5
        @BindingState var reviewText: String = ""
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case didTappedStar(index: Int)
        case didTappedCreateReview
        case isSuccessCreateReview(id: Int)
        case isFailedCreateReview(Error)
        
    }
    
    @Dependency(\.reviewClient) var reviewClient
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding(\.$reviewText):
                return .none
            case .binding: return .none
            case .didTappedStar(let index):
                state.grade = Double(index)
                return .none
            case .didTappedCreateReview:
                return .run { [
                    showId = state.showInfo.showId,
                    grade = Int(state.grade),
                    content = state.reviewText
                ] send in
                    let body = CreateReviewBody(
                        showId: showId,
                        grade: grade,
                        content: content
                    )
                    do {
                        try await send(.isSuccessCreateReview(id: reviewClient.createReview(body).id))
                    } catch {
                        await send(.isFailedCreateReview(error))
                    }
                }
            case .isSuccessCreateReview(let id):
                print(id)
                return .none
            case .isFailedCreateReview(let error):
                print(error
                )
                return .none
            }
        }
    }
}
