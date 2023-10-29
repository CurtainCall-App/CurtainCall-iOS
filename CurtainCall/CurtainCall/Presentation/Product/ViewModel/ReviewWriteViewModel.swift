//
//  ReviewWriteViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/31.
//

import Foundation
import Combine

import CombineMoya
import Moya

final class ReviewWriteViewModel {
    
    // MARK: - Properties
    
    @Published var isValidReview: Bool = false
    @Published var isWriteReview: Bool = false
    @Published var reviewScore: Int = 0
    private var provider = MoyaProvider<ReviewAPI>()
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Helper
    
    func reviewScoreChanged(value: Int) {
        reviewScore = value
    }
    
    func reviewTextViewChanged(text: String?) {
        guard let text, !text.isEmpty, text != Constants.REVIEW_WRITE_TEXTVIEW_PLACEHOLDER else {
            isValidReview = false
            return
        }
        isValidReview = true
    }
    
    func requestCreateReview(id: String, grade: Int, content: String) {
        provider.requestPublisher(.create(id: id, grade: grade, content: content))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                    return
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                if let data = try? response.map(WriteReviewResponse.self) {
                    isWriteReview = true
                } else {
                    isWriteReview = false
                }
            }.store(in: &subscriptions)

    }
}
