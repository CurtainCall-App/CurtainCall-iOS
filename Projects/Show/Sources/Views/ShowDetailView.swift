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
import NMapsMap

public struct ShowDetailView: View {
    private let store: StoreOf<ShowDetailFeature>
    
    @Environment (\.dismiss) var dismiss
    
    public init(store: StoreOf<ShowDetailFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 0) {
                navigationBar
                ScrollView {
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
                        VStack {
                            switch viewStore.currentSelectedCategory {
                            case .detail:
                                detailTapView
                                //                                    .onAppear {
                                //                                        viewStore.send(.fetchFacilityDetail(id: viewStore.showInfo?.facilityId ?? ""))
                                //                                    }
                            case .review: Color.green
                            case .lostItem: Color.yellow
                            }
                        }
                    }
                    .background {
                        VStack(spacing: 0) {
                            Color.primary1
                                .frame(height: 300)
                                .roundedCorner(30, corners: [.bottomLeft, .bottomRight])
                                .ignoresSafeArea()
                            Spacer()
                        }
                    }
                }
                .onAppear {
                    UIScrollView.appearance().bounces = false
                    viewStore.send(.fetchDetailResponse)
                }
                .onDisappear {
                    UIScrollView.appearance().bounces = true
                }
                .navigationBarBackButtonHidden()
            }
        }
    }
    
    private var navigationBar: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack {
                HStack {
                    Image(asset: CommonAsset.navigationBackWhiteIcon)
                        .onTapGesture {
                            dismiss()
                        }
                    Spacer()
                }
                .padding(.horizontal, 16)
                HStack {
                    Spacer()
                    Text(viewStore.showInfo?.name ?? "")
                        .foregroundStyle(.white)
                        .font(.subTitle3)
                    Spacer()
                }
            }
            .frame(height: 44)
            .background(Color.primary1)
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
                            .foregroundStyle(viewStore.currentSelectedCategory == type ? Color.primary1 : Color.gray6)
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
    
    @MainActor
    private var detailTapView: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("공연 정보")
                        .font(.subTitle3)
                        .foregroundStyle(.black)
                        .padding(.top, 40)
                        .padding(.leading, 20)
                    Spacer()
                }
                HStack {
                    makeDetailTapTitleView(title: "공연기간")
                        .padding([.leading, .vertical], 6)
                    Group {
                        Text((viewStore.showInfo?.startDate)?.replacingOccurrences(of: "-", with: ".") ?? "")
                        + Text(" - ")
                        + Text((viewStore.showInfo?.endDate)?.replacingOccurrences(of: "-", with: ".") ?? "")
                    }
                    .padding(.horizontal, 12)
                    .font(.body3)
                    .foregroundStyle(Color.gray2)
                    Spacer()
                }
                .background(Color.gray9)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .padding(.horizontal, 20)
                
                HStack {
                    makeDetailTapTitleView(title: "공연시간")
                        .padding([.leading, .vertical], 6)
                    Text("날짜 변환 테스트")
                        .padding(.horizontal, 12)
                        .font(.body3)
                        .foregroundStyle(Color.gray2)
                    Spacer()
                }
                .background(Color.gray9)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .padding(.horizontal, 20)
                
                HStack {
                    makeDetailTapTitleView(title: "러닝타임")
                        .padding([.leading, .vertical], 6)
                    Text(viewStore.showInfo?.runtime ?? "")
                        .padding(.horizontal, 12)
                        .font(.body3)
                        .foregroundStyle(Color.gray2)
                    Spacer()
                }
                .background(Color.gray9)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .padding(.horizontal, 20)
                
                HStack {
                    makeDetailTapTitleView(title: "관람연령")
                        .padding([.leading, .vertical], 6)
                    Text(viewStore.showInfo?.age ?? "")
                        .padding(.horizontal, 12)
                        .font(.body3)
                        .foregroundStyle(Color.gray2)
                    Spacer()
                }
                .background(Color.gray9)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .padding(.horizontal, 20)
                
                HStack {
                    makeDetailTapTitleView(title: "티켓가격")
                        .padding([.leading, .vertical], 6)
                    Text(viewStore.showInfo?.ticketPrice ?? "")
                        .padding(.horizontal, 12)
                        .font(.body3)
                        .foregroundStyle(Color.gray2)
                    Spacer()
                }
                .background(Color.gray9)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .padding(.horizontal, 20)
                
                HStack {
                    makeDetailTapTitleView(title: "공연장소")
                        .padding([.leading, .vertical], 6)
                    Text(viewStore.showInfo?.ticketPrice ?? "")
                        .padding(.horizontal, 12)
                        .font(.body3)
                        .foregroundStyle(Color.gray2)
                    Spacer()
                }
                .background(Color.gray9)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .padding(.horizontal, 20)
                
                Spacer().frame(height: 30)
                Color.gray9.frame(height: 6)
                Spacer().frame(height: 30)
                
                HStack {
                    Text("장소 세부 정보")
                        .font(.subTitle3)
                        .foregroundStyle(.black)
                        .padding(.leading, 20)
                    Spacer()
                }
                
                HStack {
                    makeDetailTapTitleView(title: "주소")
                        .padding([.leading, .vertical], 6)
                    Text(viewStore.showInfo?.facilityName ?? "")
                        .padding(.horizontal, 12)
                        .font(.body3)
                        .foregroundStyle(Color.gray2)
                    Spacer()
                }
                .background(Color.gray9)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .padding(.horizontal, 20)
                
                HStack {
                    makeDetailTapTitleView(title: "전화번호")
                        .padding([.leading, .vertical], 6)
                    Text(viewStore.facilityInfo?.phone ?? "")
                        .padding(.horizontal, 12)
                        .font(.body3)
                        .foregroundStyle(Color.gray2)
                    Spacer()
                }
                .background(Color.gray9)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .padding(.horizontal, 20)
                
                HStack {
                    makeDetailTapTitleView(title: "웹사이트")
                        .padding([.leading, .vertical], 6)
                    Text("http:")
                        .padding(.horizontal, 12)
                        .font(.body3)
                        .foregroundStyle(Color.gray2)
                    Spacer()
                }
                .background(Color.gray9)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .padding(.horizontal, 20)
                
                NaverMapView()
                    .frame(maxWidth: .infinity)
                    .frame(height: 180)
                    .padding(.horizontal, 20)
                
                Spacer().frame(height: 30)
                Color.gray9.frame(height: 6)
                Spacer().frame(height: 30)
                
                makeDetailImages(images: viewStore.showInfo?.introductionImages ?? [])
            }
        }
    }
    
    private func makeDetailTapTitleView(title: String) -> some View {
        Text(title)
            .font(.body4)
            .frame(width: 61, height: 26)
            .foregroundStyle(.white)
            .background(Color.primary1)
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
    
    @MainActor
    private func makeDetailImages(images: [String]) -> some View {
        let images = images.map { $0.removeTags() }
        return WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack {
                ForEach(images, id: \.self) { image in
                    LazyImage(url: URL(string: image)) { state in
                        if let image = state.image {
                            image.resizable().aspectRatio(contentMode: .fill)
                        } else if state.error != nil { }
                        else {
                            HStack {
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                        }
                    }
                }
            }
            
        }
    }
    
}


