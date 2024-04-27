//
//  TimeSelectView.swift
//  Party
//
//  Created by 김민석 on 4/21/24.
//

import SwiftUI

import Common

import ComposableArchitecture

public struct TimeSelectView: View {
    
    private let store: StoreOf<TimeSelectFeature>
    
    public init(store: StoreOf<TimeSelectFeature>) {
        self.store = store
    }
    
    public var body: some View {
        ForEach(store.times, id: \.self) { time in
            Text(time)
                .font(.subTitle4)
                .foregroundStyle(Color.gray1)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(.white)
                .onTapGestureRectangle {
                    store.send(.didTappedTime(time))
                }
        }
    }
}
