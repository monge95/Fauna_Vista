//
//  File.swift
//  FaunaVista
//
//  Created by Pedro Monge Silveira on 09/10/26.
//
import SwiftUI
import AVKit

struct SplashVideoPlayer: UIViewControllerRepresentable {
    let videoName: String
    var videoExtension: String = "mov"
    let onFinish: () -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(onFinish: onFinish)
    }

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.showsPlaybackControls = false
        controller.videoGravity = .resizeAspectFill

        if let url = Bundle.main.url(forResource: videoName, withExtension: videoExtension) {
            let player = AVPlayer(url: url)
            player.isMuted = true
            controller.player = player

            NotificationCenter.default.addObserver(
                context.coordinator,
                selector: #selector(Coordinator.videoDidFinish(_:)),
                name: .AVPlayerItemDidPlayToEndTime,
                object: player.currentItem
            )
            player.play()
        } else {
            DispatchQueue.main.async { onFinish() }
        }
        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {}

    static func dismantleUIViewController(_ uiViewController: AVPlayerViewController, coordinator: Coordinator) {
        uiViewController.player?.pause()
        NotificationCenter.default.removeObserver(coordinator)
    }

    @MainActor
    final class Coordinator: NSObject {
        private let onFinish: () -> Void

        init(onFinish: @escaping () -> Void) {
            self.onFinish = onFinish
        }

        @objc func videoDidFinish(_ notification: Notification) {
            // Força a atualização acontecer na main thread,
            // senão a tela congela no último frame
            DispatchQueue.main.async { self.onFinish() }
        }
    }
}

struct SplashVideoView: View {
    var videoName: String = "splash"
    var videoExtension: String = "mov"
    var onFinish: () -> Void

    var body: some View {
        SplashVideoPlayer(
            videoName: videoName,
            videoExtension: videoExtension,
            onFinish: onFinish
        )
        .ignoresSafeArea()
        // Toque em qualquer lugar pula o vídeo
        .overlay {
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    onFinish()
                }
        }
    }
}

#Preview {
    SplashVideoView(onFinish: {})
}
