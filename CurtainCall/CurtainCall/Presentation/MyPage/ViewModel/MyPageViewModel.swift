//
//  MyPageViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/24.
//

import Foundation
import Combine

import Moya
import CombineMoya
import SwiftKeychainWrapper

final class MyPageViewModel {
    private let userInfoProvider = MoyaProvider<MyPageAPI>()
    private var subscriptions: Set<AnyCancellable> = []
    var userInfoSubject = PassthroughSubject<MyPageDetailResponse, Never>()
    
    func requestUserInfo() {
        let userId = UserDefaults.standard[.userId]
        userInfoProvider.requestPublisher(.detailProfile(id: userId))
            .sink { completion in
                if case let .failure(error) = completion {
                    print("UserInfo Error", error)
                    return
                }
            } receiveValue: { [weak self] response in
                print(response.statusCode)
                if let data = try? response.map(MyPageDetailResponse.self) {
                    UserInfoManager.shared.userInfo = data
                    self?.userInfoSubject.send(data)
                    return
                } else {
                    print("User Info respone Error: \(String(data: response.data, encoding: .utf8))")
                    return
                }
            }.store(in: &subscriptions)

    }
    
}
