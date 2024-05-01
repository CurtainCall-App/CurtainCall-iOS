//
//  HomeView.swift
//  Home
//
//  Created by 김민석 on 2/22/24.
//

import SwiftUI

import Common

import ComposableArchitecture
import NukeUI

public struct HomeView: View {
    private let store: StoreOf<HomeFeature>
    
    public init(store: StoreOf<HomeFeature>) {
        self.store = store
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            topbar
            ScrollView {
                VStack {
                    recommandationViews
                    top10View
                    toOpenShowView
                }
            }
            .scrollIndicators(.hidden)
            Spacer()
            
        }
        .onAppear {
            store.send(.fetchShowRecommendations)
            store.send(.fetchShowTop10)
            store.send(.fetchToOpenShow)
        }
        
    }
    
    private var topbar: some View {
        HStack {
            Image(asset: CommonAsset.homeNavigationTitle)
            Spacer()
        }
        .padding(.leading, 20)
        .frame(height: 44)
    }
    
    @MainActor
    private var recommandationViews: some View {
        VStack {
            TabView {
                defaultRecommandView
                ForEach(store.showRecommendations, id: \.self) { info in
                    makeRecommandationView(info: info)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .frame(maxWidth: .infinity)
        .frame(height: 346)
    }
    
    private var defaultRecommandView: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(asset: CommonAsset.homeLogo)
                    .padding([.leading, .top], 30)
                Spacer()
            }
            Spacer()
            HStack {
                Text("새롭게 바뀐 커튼콜을 확인해보세요!")
                    .foregroundStyle(.white)
                    .font(.body4)
                    .padding(.leading, 30)
                Spacer()
            }
            HStack {
                Text("CURTAIN CALL\nRENEWAL")
                    .foregroundStyle(Color.primary2)
                    .font(.heading2)
                    .padding(.top, 20)
                    .padding([.leading, .bottom], 30)
                Spacer()
            }
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 346)
        .background(Color.primary1)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .padding(.horizontal, 20)
        .onTapGestureRectangle {
            guard let url = URL(string: "https://www.instagram.com/curtaincall_official_"),
                  UIApplication.shared.canOpenURL(url) else { return }
            UIApplication.shared.open(url)
        }
        
    }
    
    @MainActor
    private func makeRecommandationView(info: FetchShowRecomandationResponseResult) -> some View {
        VStack(alignment: .center, spacing: 0) {
            LazyImage(url: URL(string: info.poster)) { state in
                if let image = state.image {
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                } else {
                    ProgressView()
                }
            }
            .frame(width: 140, height: 186)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.top, 20)
            
            HStack(spacing: 4) {
                Text("추천")
                    .font(.caption_)
                    .foregroundStyle(Color.primary1)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(Color.primary2)
                    .clipShape(Capsule())
                Text(info.genre.nameKR)
                    .font(.caption_)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(Color.primary1)
                    .clipShape(Capsule())
            }
            .padding(.top, 16)
            
            Text(info.description)
                .font(.body5)
                .foregroundStyle(.white)
                .padding(.horizontal, 16)
                .padding(.top, 12)
            
            Text(info.name)
                .font(.subTitle4)
                .foregroundStyle(.white)
                .padding(.horizontal, 16)
                .padding(.top, 2)
            
            Spacer()
            
            Text(info.startDate
                 + " - " +
                 info.endDate)
            .font(.caption_)
            .foregroundStyle(.white)
            .padding(.bottom, 20)
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 346)
        .background {
            LazyImage(url: URL(string: info.poster)) { state in
                if let image = state.image {
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .scaleEffect(100)
                } else {
                    
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .blur(radius: 10)
        }
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .padding(.horizontal, 20)
        
    }
    
    @MainActor
    private var top10View: some View {
        VStack(spacing: 0) {
            HStack {
                Text("TOP10 인기 작품")
                    .font(.subTitle2)
                    .foregroundStyle(.black)
                Spacer()
            }
            ScrollView(.horizontal) {
                LazyHGrid(rows: [.init(.flexible(maximum: 120))], spacing: 12, content: {
                    ForEach(Array(zip(store.showTop10.indices, store.showTop10)), id: \.0) { index, info in
                        ZStack {
                            VStack(spacing: 0) {
                                LazyImage(url: URL(string: info.poster)) { state in
                                    if let image = state.image {
                                        image.resizable()
                                            .aspectRatio(contentMode: .fill)
                                    } else {
                                        ProgressView()
                                    }
                                }
                                .frame(width: 120, height: 160)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                                HStack {
                                    Text(info.genre.nameKR)
                                        .font(.caption_)
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(Color.primary1)
                                        .clipShape(Capsule())
                                        .padding(.top, 14)
                                    Spacer()
                                }
                                
                                HStack {
                                    Text(info.name)
                                        .font(.body3_SB)
                                        .foregroundStyle(.black)
                                        .lineLimit(1)
                                        .padding(.top, 8)
                                    Spacer()
                                }
                                .frame(maxWidth: 120)
                            }
                            VStack {
                                HStack {
                                    Text("\(index + 1)")
                                        .font(.body2_SB)
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(
                                            Color.black.opacity(0.6)
                                            
                                        )
                                        .roundedCorner(10, corners: [.topLeft, .bottomRight])
                                    Spacer()
                                }
                                Spacer()
                            }
                            
                        }
                        
                    }
                    Spacer().frame(width: 20)
                })
            }
            .padding(.top, 12)
            .scrollIndicators(.hidden)
        }
        .padding(.top, 40)
        .padding(.leading, 20)
    }
    
    @MainActor
    private var toOpenShowView: some View {
        VStack(spacing: 0) {
            HStack {
                Text("티켓 오픈 예정")
                    .font(.subTitle2)
                    .foregroundStyle(.black)
                Spacer()
            }
            ScrollView(.horizontal) {
                LazyHGrid(rows: [.init(.flexible(maximum: 120))], spacing: 12, content: {
                    ForEach(Array(zip(store.showToOpen.indices, store.showToOpen)), id: \.0) { index, info in
                        ZStack {
                            VStack(spacing: 0) {
                                LazyImage(url: URL(string: info.poster)) { state in
                                    if let image = state.image {
                                        image.resizable()
                                            .aspectRatio(contentMode: .fill)
                                    } else {
                                        ProgressView()
                                    }
                                }
                                .frame(width: 120, height: 160)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                                HStack {
                                    Text(info.genre.nameKR)
                                        .font(.caption_)
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(Color.primary1)
                                        .clipShape(Capsule())
                                        .padding(.top, 14)
                                    Spacer()
                                }
                                
                                HStack {
                                    Text(info.name)
                                        .font(.body3_SB)
                                        .foregroundStyle(.black)
                                        .lineLimit(1)
                                        .padding(.top, 8)
                                    Spacer()
                                }
                                .frame(maxWidth: 120)
                            }
                            VStack {
                                HStack {
                                    let day = getTodayDiffDay(date: Utils.convertDateStringToDate(dateString: info.startDate) ?? Date())
                                    Text(day == 0 ? "D-ㅇay" : "D-\(day)")
                                        .font(.body4)
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 3)
                                        .background(
                                            Color.black.opacity(0.6)
                                            
                                        )
                                        .roundedCorner(6, corners: .allCorners)
                                        .padding([.top, .leading], 8)
                                    Spacer()
                                }
                                Spacer()
                            }
                            
                        }
                        
                    }
                    Spacer().frame(width: 20)
                })
            }
            .padding(.top, 12)
            .scrollIndicators(.hidden)
        }
        .padding(.top, 40)
        .padding(.leading, 20)
    }
}

extension HomeView {
    func getTodayDiffDay(date: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: Date(), to: date)
        return components.day ?? 0
    }
}
