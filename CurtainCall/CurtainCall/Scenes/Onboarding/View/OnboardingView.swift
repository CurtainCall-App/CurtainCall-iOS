//
//  OnboardingView.swift
//  CurtainCall
//
//  Created by 김민석 on 12/28/23.
//

import SwiftUI

struct OnboardingView: View {
    private let data = OnboardingData.list
    @State private var currentIndex: Int = 0
    
    var body: some View {
        ZStack {
            Color.pointColor1
                .ignoresSafeArea(.container)
            VStack {
                indicatorView
                    .padding(.top, 30)
                    .padding(.trailing, 24)
                OnboardingInfoView(
                    data: data,
                    curIndex: $currentIndex
                )
                nextButton
                    .padding(.bottom, 16)
                    .padding(.horizontal, 24)
            }
        }
    }
    
    var indicatorView: some View {
        HStack {
            Spacer()
            ForEach(0..<data.count, id: \.self) { index in
                Capsule()
                    .fill(.white)
                    .frame(width: 14, height: 6)
                    
            }
        }
    }
    
    var nextButton: some View {
        Text("다음")
            .frame(maxWidth: .infinity)
            .frame(height: 58)
            .background(Color.pointColor2)
            .foregroundStyle(Color.pointColor1)
            .font(.system(size: 18, weight: .semibold))
            .clipShape(.rect(cornerRadius: 15))
        
    }
    
}

struct OnboardingInfoView: View {
    var data: [OnboardingData]
    @Binding var curIndex: Int
    
    var body: some View {
            TabView(selection: $curIndex) {
                ForEach(0..<data.count, id: \.self) { index in
                    VStack {
                        HStack{
                            Text(data[index].title)
                                .font(.heading1)
                                .foregroundStyle(.white)
                                .padding(.leading, 24)
                            Spacer()
                        }
                        
                        Spacer().frame(height: 30)
                        HStack {
                            Text(data[index].description)
                                .font(.body1)
                                .foregroundStyle(.white)
                                .padding(.leading, 24)
                            Spacer()
                        }
                        Spacer()
                        Image(data[index].image)
                            .tag(index)
                        Spacer()
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .background(.clear)
            Spacer()
    }
}
