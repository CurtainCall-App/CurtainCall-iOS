//
//  DeleteAccountView.swift
//  MyPage
//
//  Created by 김민석 on 6/16/24.
//

import SwiftUI

import Common

import ComposableArchitecture

struct DeleteAccountView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Bindable private var store: StoreOf<DeleteAccountFeature>
    
    init(store: StoreOf<DeleteAccountFeature>) {
        self.store = store
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    HStack {
                        Text("커튼콜을 떠나시나요?")
                            .font(.subTitle1)
                            .foregroundStyle(.black)
                        Spacer()
                    }
                    .padding(.top, 30)
                    HStack {
                        Text("계정을 삭제하려는 이유를 알려주세요.")
                            .font(.body3)
                            .foregroundStyle(Color.gray4)
                        Spacer()
                    }
                    .padding(.top, 14)
                    .padding(.bottom, 40)
                    checkViews
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                Spacer().frame(height: 70)
            }
            .navigationTitle("계정 삭제")
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image(asset: CommonAsset.navigationBackIcon)
                        .onTapGesture {
                            dismiss()
                        }
                }
            }
            VStack {
                Spacer()
                RectangleBottomButton(isEnable: $store.isEnableDeleteAccount, text: "다음") {
                    store.send(.didTappedDeleteAccount)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
            }
        }
    }
    
    private var checkViews: some View {
        VStack(spacing: 20) {
            ForEach(DeleteAccountFeature.DeleteAccountType.allCases, id: \.self) { type in
                HStack(spacing: 10) {
                    Image(asset: store.deleteAccountType == type ? CommonAsset.checkOffIcon20px : CommonAsset.checkOnIcon20px)
                        .onTapGestureRectangle {
                            store.send(.check(type))
                        }
                    Text(type.title)
                        .font(.body2_SB)
                        .foregroundStyle(Color.gray2)
                    Spacer()
                }
            }
            if store.deleteAccountType == .기타 {
                TextEditor(text: $store.content)
                    .font(.body2_M)
                    .foregroundStyle(.black)
                    .scrollContentBackground(.hidden)
                    .background(.clear)
                    .background(alignment: .topLeading) {
                        TextEditor(text: .constant(store.content.isEmpty ? "자유롭게 작성해주세요." : ""))
                            .font(.body2_M)
                            .foregroundStyle(Color.gray6)
                            .scrollContentBackground(.hidden)
                            .background(.clear)
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 12)
                
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: 130)
                    .background(Color.gray9)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.top, 12)
                
                if store.content.count > 500 {
                    HStack {
                        Text("500자 이내로 작성해주세요")
                            .font(.body3)
                            .foregroundStyle(.red)
                        Spacer()
                    }
                    .padding(.top, 12)
                }
            }
            
            
        }
        
    }
}
