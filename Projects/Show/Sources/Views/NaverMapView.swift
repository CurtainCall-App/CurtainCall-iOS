//
//  NaverMapView.swift
//  Show
//
//  Created by 김민석 on 3/11/24.
//

import SwiftUI

import NMapsMap

struct NaverMapView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> NMFMapView {
        let mapView = NMFMapView()
        return mapView
    }
    
    func updateUIView(_ uiView: NMFMapView, context: Context) {
        
    }
}



