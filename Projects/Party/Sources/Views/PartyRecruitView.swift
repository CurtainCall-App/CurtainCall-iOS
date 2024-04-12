//
//  PartyRecruitView.swift
//  Party
//
//  Created by 김민석 on 4/11/24.
//

import SwiftUI

import Common

import ComposableArchitecture

public struct PartyRecruitView: View {
    
    private let store: StoreOf<PartyRecruitFeature>
    
    public init(store: StoreOf<PartyRecruitFeature>) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            topView
            Text("테스트")
            Spacer()
        }
        .toolbar(.hidden)
        
    }
    
    private var topView: some View {
        HStack {
            Image(asset: CommonAsset.navigationBackIcon)
            Spacer()
            Text("파티원 모집")
                .font(.subTitle3)
                .foregroundStyle(.black)
            Spacer()
            Image(asset: CommonAsset.navigationSearchIcon)
        }
        .padding(.horizontal, 16)
        .frame(height: 44)
    }
}
