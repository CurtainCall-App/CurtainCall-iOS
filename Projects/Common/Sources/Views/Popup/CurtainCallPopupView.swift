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
    
    var allowAction: (() -> Void)
    
    public init(store: StoreOf<CurtainCallPopupFeature>, allowAction: @escaping (() -> Void)) {
        self.store = store
        self.allowAction = allowAction
    }
    
    public var body: some View {
        ZStack {
            Color.black.opacity(0.36).ignoresSafeArea(.container, edges: .top)
            VStack {
                Text(store.title)
                    .font(.subTitle4)
                    .foregroundStyle(.black)
                    .padding(.top, 40)
                if let message = store.message {
                    Text(message)
                        .font(.body3)
                        .foregroundStyle(Color.gray5)
                        .padding(.top, 14)
                        .padding(.horizontal, 12)
                    
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
                                allowAction()
                            }
                    } else {
                        
                    }
                }
                .padding([.horizontal, .bottom], 12)
                .padding(.top, 30)
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
            message: String? = nil,
            cancelText: String? = nil,
            allowText: String? = nil
        ) {
            self.title = title
            self.message = message
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

