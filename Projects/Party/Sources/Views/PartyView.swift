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

public struct PartyView: View {
    private let store: StoreOf<PartyFeature>
    
    public init(store: StoreOf<PartyFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack {
                Color.gray8
                    .ignoresSafeArea(.container, edges: .top)
                
                VStack {
                    topView
                    emptyView
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
    }
    
    private var topView: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack {
                Text("파티원")
                    .font(.heading2)
                    .padding(.leading, 20)
                Spacer()
                Image(asset: CommonAsset.iconCalendar24px)
                    .padding(.trailing, 16)
                    .padding(.vertical, 10)
                    .onTapGestureRectangle {
                        viewStore.send(.didTappedDurationButton)
                    }
                Image(asset: CommonAsset.iconSearch24px)
                    .padding(.trailing, 10)
                    .padding(.vertical, 10)
            }
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
}
