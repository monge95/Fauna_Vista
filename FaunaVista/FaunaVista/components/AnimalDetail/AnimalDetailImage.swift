//
//  AnimalDetailImage.swift
//  FaunaVista
//
//  Created by Gabriel Groppo on 02/10/26.
//

import SwiftUI

struct AnimalDetailImage: View {

    let animal: Animal

    var body: some View {
        GeometryReader { geometry in
            Group {
                if let imageURL = animal.imageURL,
                   let url = URL(string: imageURL) {

                    AsyncImage(url: url) { phase in
                        switch phase {

                        case .empty:
                            ProgressView()
                                .frame(
                                    width: geometry.size.width,
                                    height: 260
                                )

                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(
                                    width: geometry.size.width,
                                    height: 260,
                                    alignment: imageAlignment
                                )
                                .clipped()

                        case .failure:
                            placeholder

                        @unknown default:
                            placeholder
                        }
                    }

                } else {
                    placeholder
                }
            }
            .frame(
                width: geometry.size.width,
                height: 260
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 24)
            )
        }
        .frame(height: 260)
    }

    private var placeholder: some View {
        RoundedRectangle(cornerRadius: 24)
            .fill(.gray.opacity(0.2))
            .frame(maxWidth: .infinity)
            .frame(height: 260)
            .overlay {
                Image(systemName: "photo")
                    .font(.system(size: 40))
                    .foregroundStyle(.secondary)
            }
    }

    private var imageAlignment: Alignment {
        switch animal.scientificName {
        case "Anodorhynchus leari":
            return .top

        default:
            return .center
        }
    }
}
