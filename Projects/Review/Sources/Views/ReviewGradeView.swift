//
//  ReviewGradeView.swift
//  Review
//
//  Created by 김민석 on 3/17/24.
//

import SwiftUI

import Common

public struct ReviewGradeView: View {
    
    @Binding var grade: Double

    init(grade: Binding<Double>) {
        self._grade = grade
    }
    
    public var body: some View {
        ZStack {
            HStack(spacing: 4) {
                ForEach(0..<Int(grade), id: \.self) { index in
                    starFill
                }
                ForEach(0..<5-Int(grade), id: \.self) { index in
                    startUnfill
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 82)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            UISliderView(value: $grade)
                .frame(width: 226)
        }
    }
    
    private var starFill: some View {
        return Image(asset: CommonAsset.reviewWriteGradeStartFill)
    }
    
    private var startUnfill: some View {
        return Image(asset: CommonAsset.reviewWriteGradeStartUnfill)
    }
}

struct UISliderView: UIViewRepresentable {
    @Binding var value: Double
    
    var minValue = 1.0
    var maxValue = 5.0
    var thumbColor: UIColor = .clear
    var minTrackColor: UIColor = .clear
    var maxTrackColor: UIColor = .clear
    
    class Coordinator: NSObject {
        var value: Binding<Double>
        
        init(value: Binding<Double>) {
            self.value = value
        }
        
        @objc func valueChanged(_ sender: UISlider) {
            self.value.wrappedValue = Double(sender.value)
        }
    }
    
    func makeCoordinator() -> UISliderView.Coordinator {
        Coordinator(value: $value)
    }
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider(frame: .zero)
        slider.thumbTintColor = thumbColor
        slider.minimumTrackTintColor = minTrackColor
        slider.maximumTrackTintColor = maxTrackColor
        slider.minimumValue = Float(minValue)
        slider.maximumValue = Float(maxValue)
        slider.value = Float(value)
        
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueChanged(_:)),
            for: .valueChanged
        )
        
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(value)
    }
}
