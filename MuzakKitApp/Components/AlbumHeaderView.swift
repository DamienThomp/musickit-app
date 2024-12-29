//
//  AlbumHeaderView.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2024-12-28.
//

import SwiftUI

struct AlbumHeaderView: View {

    var title: String = "Fake Train"
    var artistName: String = "Unwound"
    var genreName: String = "Alternative"
    var copyWrite: String = "2001 copywrite"
    var url: URL = URL(string: "https://i.scdn.co/image/ab67616d0000b273133bfea3a205d035cee306ad"
    )!

    var body: some View {
        VStack(alignment: .center, spacing: 2) {
//            if let artwork {
//                ArtworkImage(
//                    artwork,
//                    width: 240,
//                    height: 240
//                )
//                .cornerRadius(12)
//                .padding(.bottom, 8)
//            }

            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .frame(width: 240, height: 240)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.bottom, 30)
            } placeholder: {
                Image(systemName: "waveform.path")
            }


            Text(title)
                .font(.system(.title2))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            Text(artistName)
                .font(.system(.title2))
                .foregroundStyle(.pink)
                .multilineTextAlignment(.center)
            HStack {
                Text(genreName)
                Text(copyWrite)
            }
            .font(.system(.caption2))
            .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    AlbumHeaderView()
}
