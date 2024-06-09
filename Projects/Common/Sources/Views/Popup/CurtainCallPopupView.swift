//
//  CurtainCallPopupView.swift
//  Common
//
//  Created by 김민석 on 6/9/24.
//

import SwiftUI

import ComposableArchitecture

public struct CurtainCallPopupView: View {
    
    private let store: StoreOf<CurtainCallPopupFeature>
    
    @Environment (\.dismiss) var dismiss
    
    public init(store: StoreOf<CurtainCallPopupFeature>) {
        self.store = store
    }
    
    public var body: some View {
        ZStack {
            Color.black.opacity(0.36).ignoresSafeArea(.container, edges: .top)
            VStack {
                Text(store.title)
                    .font(.subTitle4)
                    .foregroundStyle(.black)
                    .padding(.vertical, 40)
                if let meessage = store.message {
                    //
                }
                HStack(spacing: 10) {
                    if let cancel = store.cancelText, let allow = store.allowText {
                        Text(cancel)
                            .font(.body2_SB)
                            .foregroundStyle(Color.gray4)
                            .frame(height: 45)
                            .frame(maxWidth: .infinity)
                            .background(Color.gray8)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .onTapGestureRectangle {
                                store.send(.didTappedCancel)
                            }
                        Text(allow)
                            .font(.body2_SB)
                            .foregroundStyle(.white)
                            .frame(height: 45)
                            .frame(maxWidth: .infinity)
                            .background(Color.primary1)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .onTapGestureRectangle {
                                store.send(.didTappedAllow)
                            }
                    } else {
                        
                    }
                }
                .padding([.horizontal, .bottom], 12)
            }
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal, 36)
        }
    }
}

@Reducer
public struct CurtainCallPopupFeature {
    
    public init() { }
    
    @ObservableState
    public struct State: Equatable {
        var title: String
        var message: String?
        var cancelText: String?
        var allowText: String?
        
        public init(
            title: String,
            cancelText: String? = nil,
            allowText: String? = nil
        ) {
            self.title = title
            self.cancelText = cancelText
            self.allowText = allowText
        }
    }
    
    public enum Action {
        case didTappedCancel
        case didTappedAllow
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}

