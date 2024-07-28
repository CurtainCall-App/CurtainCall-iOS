//
//  PartyRecruitView.swift
//  Party
//
//  Created by 김민석 on 4/11/24.
//

import SwiftUI

import Common
import Show
import Calendar

import NukeUI
import ComposableArchitecture

public struct PartyRecruitView: View {
    
    @Bindable private var store: StoreOf<PartyRecruitFeature>
    
    @Environment (\.dismiss) var dismiss
    
    public init(store: StoreOf<PartyRecruitFeature>) {
        self.store = store
    }
    
    public var body: some View {
        ZStack {
            if store.calendar != nil {
                Color.black.opacity(0.01)
                    .ignoresSafeArea(.container, edges: .top)
                    .onTapGestureRectangle {
                        store.send(.didTappedBackground)
                    }
            }
            VStack {
                topView
                switch store.viewType {
                case .step1:
                    Image(asset: CommonAsset.partyRecruitProgressStep1)
                        .padding(.top, 20)
                    step1.onAppear { store.send(.fetchShowList(page: 0)) }
                case .step2:
                    Image(asset: CommonAsset.partyRecruitProgressStep2)
                        .padding(.top, 20)
                    step2
                case .step3:
                    Image(asset: CommonAsset.partyRecruitProgressStep3)
                        .padding(.top, 20)
                    step3
                }
            }
            .toolbar(.hidden)
            VStack {
                Spacer()
                if store.isFailedToCreateParty {
                    VStack {
                        Spacer()
                        ToastPopupView(type: .failed, text: "오류로 인해 모집글 업로드에 실패했어요")
                    }
                } else if store.isSuccessCreateParty {
                    VStack {
                        Spacer()
                        ToastPopupView(type: .success, text: "파티원 모집글이 업로드되었어요")
                            .onDisappear {
                                dismiss()
                            }
                    }
                } else {
                    nextButton
                        .onAppear {
                            store.send(.dismissToast)
                        }
                }
            }
            
            
        }
        
    }
    
    private var topView: some View {
        HStack {
            Image(asset: CommonAsset.navigationBackIcon)
                .onTapGestureRectangle {
                    dismiss()
                }
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
    
    private func makeShowTypeButton(type: ShowFeature.ShowType) -> some View {
        Text(type.title)
            .font(.body2_SB)
            .foregroundStyle(store.selectedShowType == type ? Color.white : Color.gray6)
            .padding(.horizontal, 11)
            .padding(.vertical, 4)
            .background(store.selectedShowType == type ? Color.primary1 : Color.gray9)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .onTapGestureRectangle {
                store.send(.didTappedShowTypeButton(type))
            }
    }
    
    private var categoryButton: some View {
        HStack(spacing: 2) {
            Text(store.selectedCategory.title)
                .font(.body3)
            Image(asset: CommonAsset.arrowTriangleDownFill)
        }
        .onTapGestureRectangle {
            store.send(.didTappedCategoryButton)
        }
    }
    
    private var nextButton: some View {
        VStack {
            Spacer()
            RectangleBottomButton(isEnable: $store.isPossibleNextButton, text: store.viewType != .step3 ? "다음" : "작성 완료") {
                store.send(.didTappedNextButton)
            }
            .padding(.bottom, 10)
            .padding(.horizontal, 20)
        }
    }
    
    @MainActor
    private var step1: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack {
                    Text("작품을 선택해주세요")
                        .foregroundStyle(.black)
                        .font(.subTitle4)
                    Spacer()
                }
                .padding(.top, 30)
                HStack {
                    makeShowTypeButton(type: .theater)
                    makeShowTypeButton(type: .musical)
                    Spacer()
                    categoryButton
                }
                .padding(.top, 12)
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(store.showList, id: \.self) { show in
                            VStack(spacing: 6) {
                                Spacer().frame(height: 10)
                                LazyImage(url: URL(string: show.poster)) {
                                    state in
                                    if let image = state.image {
                                        image.resizable()
                                            .aspectRatio(contentMode: .fill)
                                    } else if state.error != nil {
                                        ProgressView()
                                    } else {
                                        ProgressView()
                                    }
                                }
                                .frame(width: 105, height: 140)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 10)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.primary1, lineWidth: store.selectedShow == show ? 3 : 0)
                                )
                                
                                
                                Text(show.name)
                                    .font(.body3_SB)
                                    .foregroundStyle(.black)
                                    .lineLimit(1)
                            }
                            .onTapGestureRectangle {
                                store.send(.didTappedShowItem(show))
                            }
                            .onAppear {
                                if show == store.showList.last {
                                    store.send(.didScrollToLastItem)
                                }
                            }
                            
                        }
                    }
                    Color.clear.frame(height: 70)
                }
                .padding(.top, 20)
            }
            .padding(.horizontal, 20)
            Spacer()
        }
        .sheet(item: $store.scope(state: \.bottomSheet, action: \.bottomSheet)) { store in
            ShowSortBottomSheet(store: store)
                .presentationDetents([.height(270)])
                .presentationDragIndicator(.visible)
        }
        .onAppear {
            store.send(.fetchShowList(page: 0))
        }
    }
    
    private var step2: some View {
        ZStack {
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    HStack {
                        Text("공연 날짜를 선택해주세요.")
                            .foregroundStyle(.black)
                            .font(.subTitle4)
                        Spacer()
                    }
                    .padding(.top, 30)
                    
                    HStack {
                        if let date = store.partyDate {
                            Text(Utils.convertDateToAPIString(date: date))
                                .font(.body2_M)
                                .foregroundStyle(.black)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 12)
                        } else {
                            Text("날짜를 선택해주세요.")
                                .font(.body2_M)
                                .foregroundStyle(Color.gray6)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 12)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.gray9)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.top, 12)
                    .onTapGestureRectangle {
                        store.send(.didTappedSelectedShowDate)
                    }
                    
                    HStack {
                        Text("시간대를 선택해주세요.")
                            .foregroundStyle(.black)
                            .font(.subTitle4)
                        Spacer()
                    }
                    .padding(.top, 40)
                    
                    HStack {
                        if let time = store.partyTime {
                            Text(time)
                                .font(.body2_M)
                                .foregroundStyle(.black)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 12)
                        } else {
                            Text("시간을 선택해주세요.")
                                .font(.body2_M)
                                .foregroundStyle(Color.gray6)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 12)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.gray9)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.top, 12)
                    .onTapGestureRectangle {
                        store.send(.didTappedSelectedShowTime)
                    }
                    
                    HStack {
                        Text("인원을 선택해주세요.")
                            .foregroundStyle(.black)
                            .font(.subTitle4)
                        Spacer()
                    }
                    .padding(.top, 40)
                    
                    stepper
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.top, 12)
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            if let pickCalendarStore = self.store.scope(state: \.calendar, action: \.calendar) {
                VStack(spacing: 0) {
                    Spacer().frame(height: 110)
                    OnePickCalendarView(store: pickCalendarStore)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(color: .black.opacity(0.1) ,radius: 16, y: 10)
                        .padding(.horizontal, 20)
                    Spacer()
                }
            }
            
            if let timeSelectStore = self.store.scope(state: \.timeSelect, action: \.timeSelect) {
                VStack(spacing: 0) {
                    Spacer().frame(height: 220)
                    VStack {
                        TimeSelectView(store: timeSelectStore)
                    }
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: .black.opacity(0.1) ,radius: 16, y: 10)
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
        }
    }
    
    private var stepper: some View {
        HStack {
            Image(asset: CommonAsset.partyRecruitStepperMinus24px)
                .frame(height: 45)
                .frame(maxWidth: .infinity)
                .background(Color.primary2)
                .onTapGestureRectangle {
                    store.send(.didTappedStepper(-1))
                }
            Text("\(store.partyMemberCount)")
                .font(.subTitle2)
                .frame(height: 45)
                .frame(maxWidth: .infinity)
            Image(asset: CommonAsset.partyRecruitStepperPlus24px)
                .font(.subTitle2)
                .frame(height: 45)
                .frame(maxWidth: .infinity)
                .background(Color.primary2)
                .onTapGestureRectangle {
                    store.send(.didTappedStepper(1))
                }
        }
        
    }
    
    private var step3: some View {
        ScrollView {
            VStack(spacing: 0) {
                HStack {
                    Text("제목을 적어주세요.")
                        .foregroundStyle(.black)
                        .font(.subTitle4)
                    Spacer()
                }
                .padding(.top, 30)
                
                HStack {
                    TextField("", text: $store.partyTitle, prompt: Text("예시) OOO 함께 볼 사람 구해요!").foregroundStyle(Color.gray6))
                        .font(.body2_M)
                        .foregroundStyle(.black)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 12)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .background(Color.gray9)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.top, 12)
                
                HStack {
                    Text("내용을 적어주세요.")
                        .foregroundStyle(.black)
                        .font(.subTitle4)
                    Spacer()
                }
                .padding(.top, 40)
                
                TextEditor(text: $store.partyContent)
                    .font(.body2_M)
                    .foregroundStyle(.black)
                    .scrollContentBackground(.hidden)
                    .background(.clear)
                    .background(alignment: .topLeading) {
                        TextEditor(text: .constant(store.partyContent.isEmpty ? "예시)\n이번주 공연 같이 볼 3명 구합니다.\n구체적인 내용은 톡방 생성되면 이야기해요!" : ""))
                            .font(.body2_M)
                            .foregroundStyle(Color.gray6)
                            .scrollContentBackground(.hidden)
                            .background(.clear)
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 12)
                
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: 130)
                    .background(Color.gray9)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.top, 12)
                
                if store.partyContent.count > 500 {
                    HStack {
                        Text("500자 이내로 작성해주세요")
                            .font(.body3)
                            .foregroundStyle(.red)
                        Spacer()
                    }
                    .padding(.top, 12)
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
            Color.clear.frame(height: 70)
        }
    }
    
}
