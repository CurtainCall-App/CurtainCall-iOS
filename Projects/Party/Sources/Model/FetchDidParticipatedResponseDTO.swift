//
//  FetchDidParticipatedResponseDTO.swift
//  Party
//
//  Created by 김민석 on 4/28/24.
//

import Foundation

public struct FetchDidParticipatedResponseDTO: Decodable {
    let content: [FetchDidParticipatedContent]
}
                  
public struct FetchDidParticipatedContent: Decodable {
    let partyId: Int
    let participated: Bool
}
