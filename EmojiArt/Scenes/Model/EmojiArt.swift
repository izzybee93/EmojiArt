//
//  EmojiArt.swift
//  EmojiArt
//
//  Created by Izzy on 30/07/2020.
//  Copyright © 2020 Isabel Briant. All rights reserved.
//

import Foundation

struct EmojiArt {
    var backgroundURL: URL?
    var emojis: [Emoji] = []
    
    private var uniqueEmojiId = 0
    
    mutating func addEmoji(_ text: String, x: Int, y: Int, size: Int) {
        let emoji = Emoji(id: uniqueEmojiId, text: text, x: x, y: y, size: size)
        emojis.append(emoji)
        uniqueEmojiId += 1
    }
}

extension EmojiArt {
    struct Emoji: Identifiable {
        let id: Int
        let text: String
        var x: Int
        var y: Int
        var size: Int
        
        fileprivate init(id: Int, text: String, x: Int, y: Int, size: Int) {
            self.id = id
            self.text = text
            self.x = x
            self.y = y
            self.size = size
        }
    }
}
