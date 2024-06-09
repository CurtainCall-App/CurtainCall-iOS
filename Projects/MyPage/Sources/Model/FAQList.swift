//
//  FAQList.swift
//  MyPage
//
//  Created by 김민석 on 6/2/24.
//

import Foundation

struct FAQModel {
    let title: String
    let description: String
}

enum FAQList {
    static let show: [FAQModel] = [
        .init(
            title: "Q.새로운 작품은 업데이트 언제 업데이트 되나요?",
            description: "커튼콜은 공연예술통합전산망(KOPIS)에서 제공하는 OPEN API를 통해 데이터를 제공하고 있어요. KOPIS가 제공하는 업데이트 일시에 따라 다음 날 오전 9시에 업데이트 돼요. "
        )
    ]
    
    static let party: [FAQModel] = [
        .init(
            title: "Q.파티원은 어떤 기능인가요?",
            description: "공연을 함께 관람할 사람을 구하는 기능이에요."
        )
    ]
    
    static let talk: [FAQModel] = [
        .init(
            title: "Q.MY 모집의 톡방을 직접 개설 또는 삭제할 수 있나요?",
            description: "파티원 모집 톡방의 경우 직접 개설이나 삭제는 불가능해요.\n단, 파티원 모집 인원이 모두 찼을 때 톡방이 자동으로 개설되고, 모집 글을 삭제하면 자동으로 해당 톡방이 없어져요."
        )
    ]
    
    static let liveTalk: [FAQModel] = [
        .init(
            title: "Q.라이브톡은 어디에서 확인할 수 있나요?",
            description: "아래의 경로에서 참여할 수 있어요.\n‘작품 탐색’ - ‘해당 공연 페이지’ - ‘LIVE TALK’"
        )
    ]
    
    static let use: [FAQModel] = [
        .init(
            title: "Q.커튼콜은 어떤 서비스인가요?",
            description: "커튼콜은 연극과 뮤지컬에 관한 정보를 공유하고 사용자 간 네트워크를 형성하는 커뮤니티 앱 서비스예요. \n커튼콜은 크게 세 가지의 기능을 제공해요. \n여러 작품들에 대한 정보를 알 수 있는 작품 탐색 기능, 무대 위의 감동을 공유하고자 하는 이들을 위한 파티원 모집 기능, 그리고 실시간으로 공연에 대한 기대감 혹은 후기를 나눌 수 있는 라이브톡 기능을 제공하고 있어요."
        )
    ]
}
