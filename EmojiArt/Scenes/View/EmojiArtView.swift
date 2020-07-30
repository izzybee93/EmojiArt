//
//  EmojiArtView.swift
//  EmojiArt
//
//  Created by Izzy on 30/07/2020.
//  Copyright © 2020 Isabel Briant. All rights reserved.
//

import SwiftUI

struct EmojiArtView: View {
    @ObservedObject var viewModel: EmojiArtViewModel
    
    var body: some View {
        VStack {
            EmojiPicker()
            GeometryReader { geometry in
                ZStack {
                    Color.white.overlay(
                        Group {
                            if self.viewModel.backgroundImage != nil {
                                Image(uiImage: self.viewModel.backgroundImage!)
                            }
                        }
                    )
                        .edgesIgnoringSafeArea([.horizontal, .bottom])
                        .onDrop(of: ["public.image", "public.text"], isTargeted: nil) { (providers, location) -> Bool in
                            var location = geometry.convert(location, from: .global)
                            location = CGPoint(x: location.x - geometry.size.width/2, y: location.y - geometry.size.height/2)
                            return self.dropProviders(providers, at: location)
                    }
                    ForEach(self.viewModel.emojis) { emoji in
                        Text(emoji.text)
                            .font(self.font(for: emoji))
                            .position(self.position(for: emoji, in: geometry.size))
                    }
                }
            }
        }
    }
    
    private func font(for emoji: EmojiArt.Emoji) -> Font {
        Font.system(size: emoji.fontSize)
    }
    
    private func position(for emoji: EmojiArt.Emoji, in size: CGSize) -> CGPoint {
        CGPoint(x: emoji.location.x - size.width/2, y: emoji.location.y - size.height/2)
    }
    
    private func dropProviders(_ providers: [NSItemProvider], at location: CGPoint) -> Bool {
        var foundObject = providers.loadFirstObject(ofType: URL.self) { url in
            self.viewModel.setBackgroundURL(url)
            print(url)
        }
        if !foundObject {
            foundObject = providers.loadObjects(ofType: String.self) { string in
                self.viewModel.addEmoji(string, at: location, size: ViewConstants.defaultEmojiSize)
            }
        }
        return foundObject
    }
}


struct ViewConstants {
    static let defaultEmojiSize: CGFloat = 40
}

struct EmojiArtView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiArtView(viewModel: EmojiArtViewModel())
    }
}

