//
//  EmojiArtViewModel.swift
//  EmojiArt
//
//  Created by Izzy on 30/07/2020.
//  Copyright © 2020 Isabel Briant. All rights reserved.
//

import SwiftUI

final class EmojiArtViewModel: ObservableObject {
    static let palette: [String] = "🌺☀️🌹🌳🌻".map { String($0) }
    
    @Published private(set) var backgroundImage: UIImage?
    @Published private var emojiArt: EmojiArt
    
    var emojis: [EmojiArt.Emoji] {
        emojiArt.emojis
    }
    
    init() {
        emojiArt = EmojiArt()
    }
    
    func addEmoji(_ emoji: String, at location: CGPoint, size: CGFloat) {
        emojiArt.addEmoji(emoji, x: Int(location.x), y: Int(location.y), size: Int(size))
    }
    
    func moveEmoji(_ emoji: EmojiArt.Emoji, by offset: CGSize) {
        guard let index = emojiArt.emojis.firstIndex(matching: emoji) else { return }
        emojiArt.emojis[index].x += Int(offset.width)
        emojiArt.emojis[index].y += Int(offset.height)
    }
    
    func scaleEmoji(_ emoji: EmojiArt.Emoji, by scale: CGFloat) {
        guard let index = emojiArt.emojis.firstIndex(matching: emoji) else { return }
        emojiArt.emojis[index].size = Int((CGFloat(emojiArt.emojis[index].size) * scale).rounded(.toNearestOrEven))
    }
    
    func setBackgroundURL(_ url: URL?) {
        guard let imageURL = url?.imageURL else { return }
        emojiArt.backgroundURL = imageURL
        fetchImage(imageURL)
    }
    
    private func fetchImage(_ url: URL) {
        backgroundImage = nil
        URLSession(configuration: .default).dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            guard error == nil, let data = data else {
                self.backgroundImage = UIImage(named: "placeholder")
                return
            }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                if url == self.emojiArt.backgroundURL {
                    self.backgroundImage = image
                }
            }
        }.resume()
    }
}

extension EmojiArt.Emoji {
    var fontSize: CGFloat { CGFloat(size) }
    var location: CGPoint { CGPoint(x: x, y: y) }
}
