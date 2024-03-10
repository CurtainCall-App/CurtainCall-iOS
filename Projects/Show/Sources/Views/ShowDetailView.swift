//
//  ShowDetailView.swift
//  Show
//
//  Created by 김민석 on 3/3/24.
//

import SwiftUI

import Common
import ComposableArchitecture

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
                cardView
                    .padding(.top, 12)
                    .padding(.horizontal, 20)
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
            .navigationTitle("작품명 작품명 작품명")
            .navigationBarTitleTextColor(.white)
            .onTapGesture {
                viewStore.send(.fetchDetailResponse)
            }
        }
    }
    
    private var cardView: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Image(asset: CommonAsset.showDetailFavoriteHeartUnfill)
            }
            .padding([.top, .trailing], 18)
            
            Color.red
                .frame(width: 200, height: 286)
                .clipShape(RoundedRectangle(cornerRadius: 18))
                .padding(.top, 18)
                .shadow(radius: 10, y: 4)
            Text("뮤지컬")
                .foregroundStyle(Color.white)
                .font(.body4)
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .background(Color.primary1)
                .clipShape(Capsule())
                .padding(.top, 18)
            
            Text("비스티")
                .foregroundStyle(.black)
                .font(.subTitle1)
                .padding(.top, 8)
            rankView
                .padding(.top, 20)
            liveTalkButton
                .padding(.top, 18)
                .padding(.horizontal, 20)
            Spacer()
        }
        .frame(height: 558)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 10, y: 2)
    }
    
    private var rankView: some View {
        HStack {
            Text("예ao 순위 3위 |")
                .font(.body4)
                .foregroundStyle(Color.primary1)
            Spacer().frame(width: 4)
            Image(asset: CommonAsset.showDetailStar16px)
            Spacer().frame(width: 2)
            Text("4.9")
                .font(.body4)
                .foregroundStyle(Color.primary1)
            Spacer().frame(width: 6)
            Text("(1021개 리뷰)")
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
    
    private var liveTalkButton: some View {
        Text("LIVE TALK")
            .font(.subTitle4)
            .foregroundStyle(Color.primary1)
            .frame(height: 46)
            .frame(maxWidth: .infinity)
            .background(Color.primary2)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}


