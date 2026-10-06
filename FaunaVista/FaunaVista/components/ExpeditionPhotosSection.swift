//
//  ExpeditionPhotosSection.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 06/10/26.
//

import SwiftUI

struct ExpeditionPhotosSection: View {

    let photos: [ExpeditionPhotoModel]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {

            Text("Fotos da expedição")
                .font(.system(size: 20, weight: .bold))

            HStack(spacing: 12) {
                ForEach(photos.prefix(3)) { photo in
                    ExpeditionPhotoCard(photo: photo)
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
    }
}
