//
//  ExpeditionPhotoCard.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 06/10/26.
//

import SwiftUI

struct ExpeditionPhotoCard: View {

    let photo: ExpeditionPhotoModel

    var body: some View {
        Group {
            if let imageData = photo.image,
               let uiImage = UIImage(data: imageData) {

                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()

            } else {
                Rectangle()
                    .fill(.gray.opacity(0.2))
                    .overlay {
                        Image(systemName: "photo")
                            .foregroundStyle(.gray)
                    }
            }
        }
        .frame(height: 110)
        .clipShape(
            RoundedRectangle(cornerRadius: 14)
        )
    }
}
