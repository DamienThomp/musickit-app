//
//  VolumeSlider.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-16.
//

import SwiftUI
import MediaPlayer

struct VolumeSliderView: UIViewRepresentable {
    let tint: UIColor

    func makeUIView(context: Context) -> MPVolumeView {
        let volumeView = MPVolumeView(frame:.zero)
        volumeView.showsVolumeSlider = true
        let image = UIImage(systemName: "circle.fill")
        image?.withTintColor(tint)
        volumeView.setVolumeThumbImage(image, for: .normal)
        return volumeView
    }

    func updateUIView(_ uiView: MPVolumeView, context: Context) {
        uiView.tintColor = tint
    }
}
