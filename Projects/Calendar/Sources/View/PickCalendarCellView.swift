//
//  PickCalendarCellView.swift
//  Calendar
//
//  Created by 김민석 on 4/2/24.
//

import SwiftUI

public struct PickCalendarCellView: View {
    var day: Int
    var clicked: Bool = false
    
    public init(day: Int, clicked: Bool) {
        self.day = day
        self.clicked = clicked
    }
    
    public var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 5)
                .opacity(0)
                .overlay(Text(String(day)))
                .foregroundColor(.blue)
                .background(clicked ? .yellow : .clear)
            if clicked {
                
            }
            
        }
    }
}
