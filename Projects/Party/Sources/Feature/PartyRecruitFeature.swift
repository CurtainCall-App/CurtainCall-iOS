//
//  PartyRecruitFeature.swift
//  Party
//
//  Created by 김민석 on 4/11/24.
//

import Foundation

import Common

import ComposableArchitecture

@Reducer
public struct PartyRecruitFeature {
    
    enum ViewType {
        case step1
        case step2
        case step3
    }
    
    @ObservableState
    public struct State: Equatable {
        public init() { }
        var viewType: ViewType = .step1
    }
    
    public enum Action {
        
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}
