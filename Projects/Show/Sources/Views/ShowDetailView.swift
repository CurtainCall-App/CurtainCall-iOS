//
//  ShowDetailView.swift
//  Show
//
//  Created by 김민석 on 3/3/24.
//

import SwiftUI

import Common
import ComposableArchitecture
import NukeUI

public struct ShowDetailView: View {
    private let store: StoreOf<ShowDetailFeature>
    
    @Environment (\.dismiss) var dismiss
    
    public init(store: StoreOf<ShowDetailFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack(alignment: .top) {
                VStack {
                    Color.primary1
                        .frame(height: 300)
                        .roundedCorner(30, corners: [.bottomLeft, .bottomRight])
                        .ignoresSafeArea()
                    Spacer()
                }
                VStack(spacing: 0) {
                    VStack(spacing: 0) {
                        HStack {
                            Spacer()
                            Image(asset: CommonAsset.showDetailFavoriteHeartUnfill)
                        }
                        .padding([.top, .trailing], 18)
                        
                        LazyImage(url: URL(string: viewStore.showInfo?.poster ?? "")) { state in
                            if let image = state.image {
                                image.resizable().aspectRatio(contentMode: .fill)
                            } else if state.error != nil {
                            } else {
                                ProgressView()
                            }
                        }
                        .frame(width: 200, height: 286)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                        .padding(.top, 18)
                        .shadow(radius: 10, y: 4)
                        Text(viewStore.showInfo?.genre.nameKR ?? "")
                            .foregroundStyle(Color.white)
                            .font(.body4)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .background(Color.primary1)
                            .clipShape(Capsule())
                            .padding(.top, 18)
                        
                        Text(viewStore.showInfo?.name ?? "")
                            .foregroundStyle(.black)
                            .font(.subTitle1)
                            .padding(.top, 8)
                        rankView
                            .padding(.top, 20)
                        liveTalkButton
                            .padding(.top, 18)
                            .padding(.horizontal, 20)
                    }
                    .frame(height: 558)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 10, y: 2)
                    .padding(.top, 12)
                    .padding(.horizontal, 20)
                    
                    VStack {
                        categoryView
                            .padding(.top, 30)
                    }
                }
                
            }
            .onAppear {
                viewStore.send(.fetchDetailResponse)
            }
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image(asset: CommonAsset.navigationBackWhiteIcon)
                        .onTapGesture {
                            dismiss()
                        }
                }
            }
            .navigationTitle(viewStore.showInfo?.name ?? "")
            .navigationBarTitleTextColor(.white)
            
        }
    }
    
    private var rankView: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack {
                Text("예매 순위 3위 |")
                    .font(.body4)
                    .foregroundStyle(Color.primary1)
                Spacer().frame(width: 4)
                Image(asset: CommonAsset.showDetailStar16px)
                Spacer().frame(width: 2)
                Text(String(format: "%.1f", (viewStore.showInfo?.reviewGradeAvg ?? 0)))
                    .font(.body4)
                    .foregroundStyle(Color.primary1)
                Spacer().frame(width: 6)
                Text("(\(viewStore.showInfo?.reviewCount ?? 0)개 리뷰)")
                    .font(.body4)
                    .foregroundStyle(Color.gray4)
            }
            .frame(width: 224, height: 30)
            .padding(.horizontal, 10)
            .overlay {
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.gray8, lineWidth: 1)
                    .foregroundStyle(.clear)
            }
        }
    }
    
    private var liveTalkButton: some View {
        Text("LIVE TALK")
            .font(.subTitle4)
            .foregroundStyle(Color.primary1)
            .frame(height: 46)
            .frame(maxWidth: .infinity)
            .background(Color.primary2)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    private var categoryView: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack(spacing: 0) {
                ForEach(ShowDetailFeature.ShowDetailCategoryType.allCases, id: \.self) { type in
                    VStack {
                        Spacer()
                        Text(type.rawValue)
                            .font(.subTitle4)
                            .foregroundStyle(viewStore.currentSelectedCategory == type ? Color.primary1 : Color.gray8)
                        Spacer()
                        if viewStore.currentSelectedCategory == type {
                            Color.primary1
                                .frame(height: 3)
                        } else {
                            Color.gray6
                                .frame(height: 3)
                        }
                    }
                    .onTapGestureRectangle {
                        viewStore.send(.didTappedCategory(type))
                    }
                }
            }
            .frame(height: 45)
        }
        
    }
}


