//
//  DeleteAccountDetailView.swift
//  MyPage
//
//  Created by 김민석 on 6/16/24.
//

import SwiftUI

import Common

import ComposableArchitecture

struct DeleteAccountDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    private let store: StoreOf<DeleteAccountDetailFeature>
    
    init(store: StoreOf<DeleteAccountDetailFeature>) {
        self.store = store
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("꼭 확인해주세요!")
                        .font(.subTitle1)
                        .foregroundStyle(.black)
                    Spacer()
                }
                .padding(.top, 30)
                HStack {
                    Text("커튼콜 계정을 삭제하면,")
                        .font(.body3)
                        .foregroundStyle(Color.gray4)
                    Spacer()
                }
                .padding(.top, 14)
                .padding(.bottom, 40)
                
                HStack(alignment: .top) {
                    Circle()
                        .frame(width: 6, height: 6)
                        .foregroundStyle(Color.primary1)
                        .padding(.top, 7)
                    Text("해당 계정으로 게시한 글과 좋아요한 작품 목록, 톡방 참여 내역 등 데이터가 모두 삭제됩니다.")
                        .font(.body3)
                        .foregroundStyle(Color.gray2)
                    Spacer()
                }
                
                Spacer().frame(height: 20)
                
                HStack(alignment: .top) {
                    Circle()
                        .frame(width: 6, height: 6)
                        .foregroundStyle(Color.primary1)
                        .padding(.top, 7)
                    Text("일부 라이브톡 내용, 파티원 톡방 내용은 탈퇴 후에도 유지될 수 있습니다.")
                        .font(.body3)
                        .foregroundStyle(Color.gray2)
                    Spacer()
                }
                
                Spacer().frame(height: 20)
                
                HStack(alignment: .top) {
                    Circle()
                        .frame(width: 6, height: 6)
                        .foregroundStyle(Color.primary1)
                        .padding(.top, 7)
                    Text("이후 계정을 복구하고 싶다면, 30일 내 접근 시 계정 복구가 가능합니다. 단, 30일 이후에는 영구적으로 삭제됩니다.")
                        .font(.body3)
                        .foregroundStyle(Color.gray2)
                    Spacer()
                }
                
                Spacer().frame(height: 40)
                
                HStack {
                    Text("계속할까요?")
                        .font(.subTitle4)
                        .foregroundStyle(.black)
                    Spacer()
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
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
                RectangleBottomButton(isEnable: .constant(true), text: "다음") {
                    store.send(.deleteAccount)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
            }
        }
    }
}
