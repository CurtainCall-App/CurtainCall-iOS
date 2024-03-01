//
//  View + Extension.swift
//  Common
//
//  Created by 김민석 on 2/25/24.
//

import SwiftUI

extension View {
    public func onTapGestureRectangle(perform action: @escaping() -> Void) -> some View {
        self.contentShape(Rectangle())
            .onTapGesture(perform: action)
    }
}
