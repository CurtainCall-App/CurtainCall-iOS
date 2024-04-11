//
//  PartyView.swift
//  Party
//
//  Created by 김민석 on 2/22/24.
//

import SwiftUI

import Common
import Calendar

import ComposableArchitecture
import NukeUI

public struct PartyView: View {
    private let store: StoreOf<PartyFeature>
    
    public init(store: StoreOf<PartyFeature>) {
        self.store = store
    }
    
    public var body: some View {
        ZStack {
            Color.gray8
                .ignoresSafeArea(.container, edges: .top)
            
            VStack {
                topView
                if store.partyList.isEmpty {
                    emptyView
                } else {
                    ScrollView {
                        VStack {
                            ForEach(store.partyList, id: \.self) { info in
                                makePartyItem(info: info)
                            }
                            
                            Color.clear.padding(.bottom, 85)
                        }
                    }
                }
                Spacer()
            }
            VStack {
                Spacer()
                recruitMemberButton
                    .padding(.bottom, 20)
                    .padding(.horizontal, 20)
            }
            VStack {
                IfLetStore(self.store.scope(state: \.calendar, action: \.calendar)) { store in
                    VStack {
                        Spacer().frame(height: 54)
                        PickCalendarView(store: store)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(color: .black.opacity(0.1) ,radius: 16, y: 10)
                            .padding(.horizontal, 20)
                        
                        Spacer()
                    }
                }
            }
        }
        .toolbar(.hidden)
        
    }
    
    private var topView: some View {
        HStack {
            Text("파티원")
                .font(.heading2)
                .padding(.leading, 20)
            Spacer()
            if store.selectedDates.isEmpty {
                Image(asset: CommonAsset.iconCalendar24px)
                    .padding(.trailing, 16)
                    .padding(.vertical, 10)
                    .onTapGestureRectangle {
                        store.send(.didTappedDurationButton)
                    }
            } else {
                Text(PartyFeature.convertDateToString(dates: store.selectedDates))
                    .font(.body4)
                    .foregroundStyle(Color.primary1)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.primary2)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .padding(.trailing, 16)
                    .padding(.vertical, 10)
                
                    .onTapGestureRectangle {
                        store.send(.didTappedDurationButton)
                    }
            }
            
            Image(asset: CommonAsset.iconSearch24px)
                .padding(.trailing, 10)
                .padding(.vertical, 10)
        }
        
        
    }
    
    private var emptyView: some View {
        VStack {
            Spacer()
            Image(asset: CommonAsset.emptyParty60px)
            Text("모집 중인 파티원이 없어요!")
                .font(.body2_SB)
                .foregroundStyle(Color.primary1)
                .padding(.top, 16)
            Spacer()
        }
    }
    
    private var recruitMemberButton: some View {
        Text("파티원 모집하기")
            .font(.subTitle4)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.primary1)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    @MainActor
    private func makePartyItem(info: FetchPartyListResult) -> some View {
        VStack(alignment: .leading) {
            HStack {
                LazyImage(url: URL(string: info.showPoster)) {
                    state in
                    if let image = state.image {
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                    } else if state.error != nil {
                        ProgressView()
                    } else {
                        ProgressView()
                    }
                }
                .frame(width: 80, height: 109)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                
                VStack(alignment:.leading) {
                    HStack(spacing: 8) {
                        if let url = info.creatorImageUrl {
                            LazyImage(url: URL(string: url)) { state in
                                if let image = state.image {
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                } else if state.error != nil {
                                    Image(asset: CommonAsset.partyDefaultProfile28px)
                                } else {
                                    ProgressView()
                                }
                            }
                            .frame(width: 28, height: 28)
                            .clipShape(Circle())
                        } else {
                            Image(asset: CommonAsset.partyDefaultProfile28px)
                                .frame(width: 28, height: 28)
                                
                        }
                        Text(info.creatorNickname)
                            .font(.body4)
                            .foregroundStyle(.black)
                        Spacer()
                    }
                    
                    Text(info.title)
                        .font(.body2_SB)
                        .foregroundStyle(.black)
                        .lineLimit(1)
                        .padding(.top, 17)
                        .multilineTextAlignment(.leading)
                    
                    Text(info.content)
                        .font(.body4)
                        .foregroundStyle(Color.gray3)
                        .lineLimit(2)
                        .padding(.top, 8)
                        .multilineTextAlignment(.leading)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 10)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
            HStack(spacing: 0) {
                Color.gray8
                    .frame(width: 14, height: 14)
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
                Color.gray8
                    .frame(width: 14, height: 14)
                    .clipShape(Circle())
                    .padding(.trailing, -7)
            }
            HStack {
                HStack(spacing: 6) {
                    Text(Utils.convertAPIDateStringToDay(dateString: info.createdAt))
                        .font(.body5)
                        .frame(height: 21)
                        .foregroundStyle(Color.gray4)
                        .padding(.horizontal, 6)
                        .background(Color.gray8)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                    
                    Text(Utils.convertAPIDateStringToTime(dateString: info.createdAt))
                        .font(.body5)
                        .frame(height: 21)
                        .foregroundStyle(Color.gray4)
                        .padding(.horizontal, 6)
                        .background(Color.gray8)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                }
                .padding(.horizontal, 17)
                .padding(.bottom, 14)
            }
            .frame(height: 40)
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal, 20)
        
        
        
        
    }
}
