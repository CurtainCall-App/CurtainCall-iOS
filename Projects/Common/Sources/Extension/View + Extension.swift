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
    
    public func roundedCorner(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
    
    public func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor ]
        return self
    }

}
