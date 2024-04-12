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
            stepView
                .padding(.top, 20)
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
    
    private var stepView: some View {
        switch store.viewType {
        case .step1: Image(asset: CommonAsset.partyRecruitProgressStep1)
        case .step2: Image(asset: CommonAsset.partyRecruitProgressStep2)
        case .step3: Image(asset: CommonAsset.partyRecruitProgressStep3)
        }
    }
    
    private var showView: some View {
        VStack {
            Text("작품을 선택해주세요")
                .foregroundStyle(.black)
                .font(.subTitle4)
                .padding(.top, 30)
            
        }
    }
    
    private func makeShowTypeButton(type: ShowType) -> some View {
        Text(type.title)
            .font(.body2_SB)
            .foregroundStyle(store.selectedShowType == type ? Color.white : Color.gray6)
            .padding(.horizontal, 11)
            .padding(.vertical, 4)
            .background(store.selectedShowType == type ? Color.primary1 : Color.gray9)
            .clipShape(RoundedRectangle(cornerRadius: 30))
    }
    
}
