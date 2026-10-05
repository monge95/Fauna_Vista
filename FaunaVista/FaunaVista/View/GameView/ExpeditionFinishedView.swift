//
//  ExpeditionFinishedView.swift
//  Tela "Análise das fotos": escolher as fotos com checkmark.
//

import SwiftUI

struct ExpeditionFinishedView: View {
    @ObservedObject var vm: ExpeditionViewModel

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        ZStack(alignment: .bottom) {
            Color(.systemBackground).ignoresSafeArea()

            ScrollView {
                VStack(spacing: 6) {
                    Text("Análise das fotos")
                        .font(.system(size: 28, weight: .heavy))

                    Text("Selecione as fotos que\ndeseja enviar para análise")
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 16)

                    if vm.photoCards.isEmpty {
                        Text("Nenhuma foto foi registrada.")
                            .foregroundStyle(.secondary)
                            .padding(.top, 40)
                    }

                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(vm.photoCards) { photo in
                            PhotoSelectionCell(
                                photo: photo,
                                isSelected: vm.isSelected(photo)
                            ) {
                                vm.toggleSelection(photo)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 120)
            }

            VStack {
                Button {
                    vm.confirmSelection()
                } label: {
                    Text("Enviar fotos (\(vm.selectedPhotoIDs.count)/\(vm.requiredSelection))")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.vertical, 16)
                        .frame(maxWidth: 260)
                        .background(
                            vm.canSubmitSelection ? FaunaPalette.teal : Color.gray,
                            in: Capsule()
                        )
                }
                .disabled(!vm.canSubmitSelection)
                .padding(.bottom, 24)
                .padding(.top, 30)
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(
                        colors: [.clear, Color(.systemBackground)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
        }
    }
}

private struct PhotoSelectionCell: View {
    let photo: ExpeditionPhoto
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Color.clear
                .aspectRatio(1, contentMode: .fit)
                .overlay(
                    Image(uiImage: photo.image)
                        .resizable()
                        .scaledToFill()
                )
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(isSelected ? FaunaPalette.teal : .clear, lineWidth: 4)
                )
                .overlay(alignment: .topTrailing) {
                    Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                        .font(.system(size: 30))
                        .foregroundStyle(.white)
                        .shadow(radius: 2)
                        .padding(10)
                }
        }
        .buttonStyle(.plain)
    }
}
