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
            recommandationViews
            Spacer()
        }
        .onAppear {
            store.send(.fetchShowRecommendations)
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
        GeometryReader { geometry in
            TabView {
                defaultRecommandView
                ForEach(store.showRecommendations, id: \.self) { info in
                    makeRecommandationView(info: info)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
    
    private var defaultRecommandView: some View {
        GeometryReader { geometry in
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
            .frame(maxWidth: geometry.size.width)
            .frame(height: geometry.size.width - 40)
            .background(Color.primary1)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .padding(.horizontal, 20)
            .onTapGestureRectangle {
                guard let url = URL(string: "https://www.instagram.com/curtaincall_official_"),
                      UIApplication.shared.canOpenURL(url) else { return }
                UIApplication.shared.open(url)
            }
        }
    }
    
    @MainActor
    private func makeRecommandationView(info: FetchShowRecomandationResponseResult) -> some View {
        GeometryReader { geometry in
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
            .frame(maxWidth: geometry.size.width)
            .frame(height: geometry.size.width - 40)
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
    }
}
