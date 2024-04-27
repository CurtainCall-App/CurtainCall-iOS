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
            VStack {
                topView
                ScrollView {
                    VStack {
                        
                    }
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .padding(.horizontal, 20)
                Spacer()
            }
        }
        .toolbar(.hidden)
        .onAppear {
            store.send(.fetchPartyDetail)
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
}


