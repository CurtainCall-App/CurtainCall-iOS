//
//  PartyDetailView.swift
//  Party
//
//  Created by 김민석 on 4/27/24.
//

import SwiftUI

import Common

import NukeUI
import ComposableArchitecture

struct PartyDetailView: View {
    private let store: StoreOf<PartyDetailFeature>
    
    @Environment (\.dismiss) var dismiss
    
    public init(store: StoreOf<PartyDetailFeature>) {
        self.store = store
    }
    
    public var body: some View {
        ZStack {
            Color.primary1.ignoresSafeArea(.container, edges: .top)
            VStack(alignment: .leading) {
                topView
                ScrollView {
                    VStack {
                        LazyImage(url: URL(string: store.partyDetailInfo?.showPoster ?? "")) { state in
                            if let image = state.image {
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                            } else {
                                ProgressView()
                            }
                        }
                        .frame(width: 180, height: 257)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 18)
                        )
                        .padding(.top, 40)
                        
                        profileView
                            .padding(.top, 30)
                        
                        contentView
                            .padding(.top, 20)
                        
                        dotLienView
                            .padding(.vertical, 24)
                        
                        showInfoView
                            .padding(.bottom, 30)
                    }
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal, 20)
                    
                    Spacer()
                        .frame(height: 40)
                    
                    makeBottomButton()
//                    VStack {
//                        Text("TALK 입장")
//                            .font(.subTitle4)
//                            .foregroundStyle(Color.primary1)
//                            .frame(maxWidth: .infinity)
//                            .frame(height: 55)
//                            .background(Color.primary2)
//                            .clipShape(RoundedRectangle(cornerRadius: 10))
//                            .padding(.horizontal, 20)
//                            .padding(.bottom, 10)
//                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .toolbar(.hidden)
        .onAppear {
            store.send(.fetchPartyDetail)
            store.send(.fetchDidParticipated)
        }
        
    }
    
    private var topView: some View {
        HStack {
            Image(asset: CommonAsset.navigationBackWhiteIcon)
                .onTapGestureRectangle {
                    dismiss()
                }
            Spacer()
            Text("파티원 모집")
                .font(.subTitle3)
                .foregroundStyle(.white)
            Spacer()
            Image(asset: CommonAsset.navigationMoreIcon)
            
        }
        .padding(.horizontal, 16)
        .frame(height: 44)
    }
    
    @MainActor
    private var profileView: some View {
        HStack(spacing: 12) {
            if let urlString = store.partyDetailInfo?.creatorImageUrl {
                LazyImage(url: URL(string: urlString)) { state in
                    if let image = state.image {
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                    } else {
                        ProgressView()
                    }
                }
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            } else {
                Image(asset: CommonAsset.partyDefaultProfile40px)
                    .frame(width: 40, height: 40)
            }
            VStack(alignment: .leading) {
                Text(store.partyDetailInfo?.creatorNickname ?? "")
                    .font(.body3_SB)
                    .foregroundStyle(.black)
                Text(Utils.convertAPIDateStringToDay(dateString: store.partyDetailInfo?.createdAt ?? ""))
                    .font(.body3)
                    .foregroundStyle(Color.gray5)
            }
            Spacer()
        }
        .padding(.horizontal, 16)
    }
    
    private var contentView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(store.partyDetailInfo?.title ?? "")
                    .font(.subTitle4)
                    .foregroundStyle(.black)
                Text(store.partyDetailInfo?.content ?? "")
                    .font(.body3)
                    .foregroundStyle(Color.gray1)
            }
            .padding(.horizontal, 16)
            Spacer()
        }
    }
    
    private var dotLienView: some View {
        HStack(spacing: 0) {
            Color.primary1
                .frame(width: 16, height: 16)
                .clipShape(Circle())
                .padding(.leading, -7)
            GeometryReader { geometry in
                Path { path in
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: 0))
                }
                .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                .foregroundColor(.gray8)
            }
            .frame(height: 2)
            Color.primary1
                .frame(width: 16, height: 16)
                .clipShape(Circle())
                .padding(.trailing, -7)
        }
    }
    
    private var showInfoView: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 35) {
                Text("작품명")
                    .font(.body4)
                    .foregroundStyle(Color.gray5)
                Text(store.partyDetailInfo?.showName ?? "")
                    .font(.body4)
                    .foregroundStyle(Color.gray1)
                Spacer()
            }
            HStack(spacing: 20) {
                Text("공연 일자")
                    .font(.body4)
                    .foregroundStyle(Color.gray5)
                Text(Utils.convertAPIDateStringToDay(dateString: store.partyDetailInfo?.showAt ?? ""))
                    .font(.body4)
                    .foregroundStyle(Color.gray1)
                Spacer()
                
            }
            HStack(spacing: 20) {
                Text("공연 시간")
                    .font(.body4)
                    .foregroundStyle(Color.gray5)
                Text(Utils.convertAPIDateStringToTime(dateString: store.partyDetailInfo?.showAt ?? ""))
                    .font(.body4)
                    .foregroundStyle(Color.gray1)
                Spacer()
            }
            HStack(spacing: 20) {
                Text("공연 장소")
                    .font(.body4)
                    .foregroundStyle(Color.gray5)
                Text(store.partyDetailInfo?.facilityName ?? "")
                    .font(.body4)
                    .foregroundStyle(Color.gray1)
                Spacer()
            }
            HStack(spacing: 20) {
                Text("참여 인원")
                    .font(.body4)
                    .foregroundStyle(Color.gray5)
                Text("\(store.partyDetailInfo?.curMemberNum ?? 0)")
                    .font(.body4)
                    .foregroundStyle(Color.gray1)
                Spacer()
            }
        }
        .padding(.horizontal, 16)
    }
    
    private func makeBottomButton() -> some View {
        VStack {
            if let creatorId = store.partyDetailInfo?.creatorId {
                if creatorId == UserDefaults.standard.integer(forKey: UserDefaultKeys.userId.rawValue) {
                    Text("TALK 입장")
                        .font(.subTitle4)
                        .foregroundStyle(Color.primary1)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color.primary2)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                } else {
                    if store.isParticipated {
                        HStack(spacing: 10) {
                            Text("참여 취소")
                                .font(.subTitle4)
                                .foregroundStyle(Color.gray4)
                                .frame(height: 55)
                                .frame(width: 110)
                                .background(Color.gray8)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            Text("TALK 시작하기")
                                .font(.subTitle4)
                                .foregroundStyle(Color.primary1)
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .background(Color.primary2)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    } else {
                        Text("참여하기")
                            .font(.subTitle4)
                            .foregroundStyle(Color.primary1)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(Color.primary2)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .onTapGestureRectangle {
                                
                            }
                    }
                }
            } else {
                EmptyView()
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
    }
}


