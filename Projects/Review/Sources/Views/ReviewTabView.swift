//
//  ReviewTabView.swift
//  Review
//
//  Created by 김민석 on 3/16/24.
//

import SwiftUI

import Common
import ComposableArchitecture

public struct ReviewTabView: View {
    
    private let store: StoreOf<ReviewFeature>
    
    public init(store: StoreOf<ReviewFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading, spacing: 12) {
                Text("1021개의 리뷰가 있어요")
                    .font(.subTitle3)
                    .foregroundStyle(.black)
                    .padding(.top, 28)
                Text("리뷰 모두 보기")
                    .font(.subTitle4)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.primary1)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.top, 28)
            }
            .padding(.horizontal, 20)
        }
    
    }
}
