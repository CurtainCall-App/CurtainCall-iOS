//
//  FAQFeature.swift
//  MyPage
//
//  Created by 김민석 on 6/2/24.
//

import Foundation

import Common

import ComposableArchitecture

@Reducer
public struct FAQFeature {
    
    @ObservableState
    public struct State: Equatable {
        public init() { }
        var faqType: FAQType = .show
        var isOpened: [Bool] = [Bool](repeating: false, count: FAQType.show.list.count)
    }
    
    public enum Action {
        case didTappedType(FAQType)
        case didTappedOpen(Int)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTappedType(let type):
                guard state.faqType != type else { return .none }
                state.faqType = type
                state.isOpened = [Bool](repeating: false, count: type.list.count)
                return .none
            case .didTappedOpen(let index):
                state.isOpened[index].toggle()
                return .none
            }
        }
    }
}

public extension FAQFeature {
    
    enum FAQType: String, CaseIterable {
        case show = "작품"
        case party = "파티원"
        case talk = "파티원 톡방"
        case liveTalk = "라이브톡"
        case use = "이용문의"
        
        public struct FAQModel: Hashable {
            let title: String
            let description: String
        }
        
        public var list: [FAQModel] {
            switch self {
            case .show:
                return [
                    .init(
                        title: "Q. 새로운 작품은 업데이트 언제 업데이트 되나요?",
                        description: "커튼콜은 공연예술통합전산망(KOPIS)에서 제공하는 OPEN API를 통해 데이터를 제공하고 있어요. KOPIS가 제공하는 업데이트 일시에 따라 다음 날 오전 9시에 업데이트 돼요. "
                    ),
                    .init(
                        title: "Q. 공연 리뷰를 수정/삭제하고 싶어요. 어떻게 해야 하나요?",
                        description: "‘MY’ - ‘내가 쓴 글’ - ‘공연 리뷰’ - 더보기 클릭 - ‘수정’ or ‘삭제’"
                    ),
                    .init(
                        title: "Q. 저장한 작품 정보는 어디에서 확인하나요?",
                        description: "‘MY’ - ‘저장된 작품 목록’"
                    ),
//                    .init(
//                        title: "Q.분실물 정보는 어떻게 올리고 찾을 수 있나요?",
//                        description: "만약 물건을 발견했다면, 아래의 경로로 올릴 수 있어요.\n‘작품 탐색’ - ‘해당 공연 페이지’ - ‘분실물’ - ‘분실물 모두 보기’ - ‘분실물 올리기’\n\n만약 물건을 분실했다면, 아래의 경로로 확인할 수 있어요.\n‘작품 탐색’ - ‘해당 공연 페이지’ - ‘분실물’ - ‘분실물 모두 보기’ - ‘날짜 선택’"
//                    )
                ]
            case .party:
                return [
                    .init(
                        title: "Q. 파티원은 어떤 기능인가요?",
                        description: "공연을 함께 관람할 사람을 구하는 기능이에요."
                    ),
                    .init(
                        title: "Q. 파티원은 어떻게 모집하고 참여하나요?",
                        description: "만약 새로운 파티원을 모집하고 싶다면, 아래의 경로로 모집할 수 있어요.\n‘파티원’ - 글쓰기 아이콘 클릭\n\n만약 기존 파티원에 참여하고 싶다면, 아래의 경로로 참여할 수 있어요.\n‘파티원’ - 검색 or 모집글 확인 - 원하는 모집 글 클릭 - ‘참여하기’"
                    ),
                    .init(
                        title: "Q. 파티원 간 소통은 어떻게 할 수 있나요?",
                        description: "하나의 모집 글이 생성되면 자동으로 파티원 간 톡방이 개설돼요. 이때 해당 글에 ‘TALK 입장’ 버튼이 생기는데 여기에서 파티원들이 서로 대화할 수 있어요.\n이후에 자신의 모집/참여 톡방을 보려면, 아래의 경로로 확인할 수 있어요.\n\n‘MY’ - ‘MY 파티원’ - ‘TALK 입장’\n‘홈’ - ‘MY 파티원’ - ‘TALK 입장’"
                    ),
                    .init(
                        title: "Q. 파티원 모집에 참여했다가 취소하기가 가능한가요?",
                        description: "네, 가능해요. 내가 참여한 모집글은 아래의 경로로 참여를 취소할 수 있어요. 하지만 파티원의 다른 참여자들에게 알림이 갈 수 있으니, 신중히 생각해보고 참여해주세요.\n‘파티원’ - ‘모집 글’ - ‘참여 취소’\n‘MY’ - ‘MY 파티원’ - ‘참여 - ‘더보기’ - ‘삭제’"
                    ),
                    .init(
                        title: "Q. 파티원 모집 글을 수정/삭제할 수 있나요?",
                        description: "네, 가능해요. 내가 올린 모집글은 아래의 경로에서 수정/삭제 가능해요.\n‘MY’ - ‘MY 파티원’ - ‘모집’ - ‘더보기’ - ‘수정/삭제’"
                    ),
                    .init(
                        title: "Q. 파티원 모집 일시나 작품을 바꿀 수 있나요?",
                        description: "아니요, 글의 제목과 내용은 수정할 수 있지만 다른 참여자들에게 혼란을 줄 수 있기 때문에 모집 일시와 작품은 수정할 수 없어요.  만약 모집 일시와 작품을 바꾸고 싶다면 조금 번거롭더라도 다시 모집글을 작성해주세요."
                    ),
                    .init(
                        title: "Q. 파티원 모집 인원이 다 차지 않으면 어떻게 되나요?",
                        description: "파티원 모집 인원이 모두 모이지 않아도 모집글을 올리면 바로 해당 모집글 톡방이 개설돼요. 만약 참여 인원이 남아있다면 모집 일시까지 파티원에 참여할 수 있어요."
                    ),
                    .init(
                        title: "Q. 파티원 모집 글은 언제까지 노출되나요?",
                        description: "파티원 탭의 파티원 모집 글은 해당 모집 일자의 해당 시간까지 노출돼요. 그 이후로는 자동으로 글이 내려가요."
                    ),
                    .init(
                        title: "Q. 특정 글을 신고할 수 있나요?",
                        description: "네, 가능해요. 한 줄 리뷰, 분실물 정보, 파티원 모집 글의 우측 상단에서 ‘신고’ 기능을 통해 부적절한 글을 신고할 수 있어요. "
                    )
                ]
            case .talk:
                return [
                    .init(
                        title: "Q. MY 모집의 톡방을 직접 개설 또는 삭제할 수 있나요?",
                        description: "파티원 모집 톡방의 경우 직접 개설이나 삭제는 불가능해요.\n단, 파티원 모집 인원이 모두 찼을 때 톡방이 자동으로 개설되고, 모집 글을 삭제하면 자동으로 해당 톡방이 없어져요."
                    ),
                    .init(
                        title: "Q. MY 모집 글을 삭제해도 톡방은 유지되나요?",
                        description: "아니요, 모집 글을 삭제하면 해당 모집 글의 톡방은 자동으로 사라져요. 글 삭제 시 톡방이 함께 삭제되니 이 점 유의해주세요."
                    ),
                    .init(
                        title: "Q. 참여한 파티원 모집 글에서 톡방 나가기가 가능한가요?",
                        description: "네, 가능해요. 만약 참여한 톡방에서 나가고 싶다면, 해당 게시글의 ‘참여 취소’ 버튼을 통해 나올 수 있어요. 다만, 해당 모집글의 참여 자체가 취소되니 이 점 유의해주세요."
                    ),
                    .init(
                        title: "Q. 특정 파티원을 강제 퇴장 시킬 수 있나요?",
                        description: "네, 가능해요. 부적절한 언행을 하는 사용자가 있다면, 파티원 모집글 작성자가 직접 강제 퇴장 시킬 수 있어요."
                    )
                ]
            case .liveTalk:
                return [
                    .init(
                        title: "Q. 라이브톡은 어디에서 확인할 수 있나요?",
                        description: "아래의 경로에서 참여할 수 있어요.\n‘작품 탐색’ - ‘해당 공연 페이지’ - ‘LIVE TALK’"
                    ),
                    .init(
                        title: "Q. 라이브톡은 어떤 기능인가요?",
                        description: "공연 전후에 실시간으로 사람들과 대화를 할 수 있는 기능이에요. 공연 전 공연에 대한 기대감을 공유하고, 공연 후 공연에 대한 실시간 후기를 공유할 수 있어요."
                    ),
                    .init(
                        title: "Q. 지난 공연의 라이브톡을 볼 수 있나요?",
                        description: "네, 가능해요. 지난 공연과 현재 상영 중인 공연에 대한 실시간 대화들을 모두 확인할 수 있어요. "
                    )
                ]
            case .use:
                return [
                    .init(
                        title: "Q. 커튼콜은 어떤 서비스인가요?",
                        description: "커튼콜은 연극과 뮤지컬에 관한 정보를 공유하고 사용자 간 네트워크를 형성하는 커뮤니티 앱 서비스예요. \n커튼콜은 크게 세 가지의 기능을 제공해요. \n여러 작품들에 대한 정보를 알 수 있는 작품 탐색 기능, 무대 위의 감동을 공유하고자 하는 이들을 위한 파티원 모집 기능, 그리고 실시간으로 공연에 대한 기대감 혹은 후기를 나눌 수 있는 라이브톡 기능을 제공하고 있어요."
                    ),
                    .init(
                        title: "Q. 소셜 로그인 변경은 어떻게 하나요?",
                        description: "현재 커튼콜의 로그인 변경은 어려워요. 추후 앱 업데이트 시에 추가될 예정이에요."
                    ),
                    .init(
                        title: "Q. 앱 오류가 떠요.",
                        description: "네트워크나 서버의 문제일 수 있어요. 먼저 네트워크가 원활한 지 확인하고, 앱 업데이트가 최신 버전으로 되었는지 확인해주세요. 서버의 문제일 경우 빠르게 조치할 예정이니 조금만 기다려주세요!\n추가적으로 궁금한 점이 있다면 아래 메일로 문의 주시면 빠르게 확인 후 답변 드릴게요.\n\n[커튼콜 고객센터]\ncurtaincall.official2023@gmail.com"
                    ),
                    .init(
                        title: "Q. 문의는 어디에서 할 수 있나요?",
                        description: "문의 사항이 있으시다면  커튼콜 메일로 문의해주세요. 아래 메일 주소로 문의해 주시면, 빠르게 안내해 드릴게요.\n\n[커튼콜 고객센터]\ncurtaincall.official2023@gmail.com"
                    )
                ]
            }
        }
    }
}
