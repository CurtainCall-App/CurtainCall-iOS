//
//  ReviewWriteView.swift
//  Review
//
//  Created by 김민석 on 3/17/24.
//

import SwiftUI

import Common
import ComposableArchitecture
import NukeUI

public struct ReviewWriteView: View {
    
    @Environment(\.dismiss) var dismiss
    private let store: StoreOf<ReviewWriteFeature>
    
    public init(store: StoreOf<ReviewWriteFeature>) {
        self.store = store
    }
    
    public var body: some View {
        ZStack {
            Color.gray9.ignoresSafeArea()
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                ScrollView {
                    VStack {
                        LazyImage(url: URL(string: viewStore.showInfo.showImage)) { state in
                            if let image = state.image {
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                            } else if state.error != nil {
                                
                            } else {
                                ProgressView()
                            }
                        }
                        .frame(width: 180, height: 257)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                        .padding(.top, 10)
                        .shadow(radius: 10, y: 4)
                        
                        Text(viewStore.showInfo.genre.nameKR)
                            .foregroundStyle(Color.white)
                            .font(.body4)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .background(Color.primary1)
                            .clipShape(Capsule())
                            .padding(.top, 20)
                        
                        Text(viewStore.showInfo.showName)
                            .font(.subTitle1)
                            .foregroundStyle(.black)
                            .padding(.top, 8)
                        
                        Text("공연은 만족스러웠나요?")
                            .font(.subTitle4)
                            .foregroundStyle(Color.primary1)
                            .padding(.top, 20)
                        
                        ReviewGradeView(grade: viewStore.$grade)
                            .padding(.top, 12) 

                            
                        
                        Text("공연 리뷰를 작성해주세요")
                            .font(.subTitle4)
                            .foregroundStyle(Color.primary1)
                            .padding(.top, 40)

                        TextEditor(text: viewStore.$reviewText)
                            .padding(.vertical, 16)
                            .padding(.horizontal, 20)
                            .font(.body2_M)
                            .foregroundStyle(Color.gray3)
                            .frame(
                                minWidth: 0,
                                maxWidth: .infinity,
                                minHeight: 140,
                                maxHeight: .infinity,
                                alignment: .leading
                            )
                            .background(
                                Color.white
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                )
                            .padding(.top, 12)
                        
                        Text("작성 완료")
                            .font(.subTitle4)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(Color.primary1)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.top, 28)
                            .padding(.bottom, 10)
                            .onTapGestureRectangle {
                                viewStore.send(.didTappedCreateReview)
                            }
                    }
                    .navigationBarBackButtonHidden()
                    .navigationTitle("공연 리뷰")
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Image(asset: CommonAsset.navigationBackIcon)
                                .onTapGesture {
                                    dismiss()
                                }
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
    }
}
