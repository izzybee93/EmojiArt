//
//  EmojiPicker.swift
//  EmojiArt
//
//  Created by Izzy on 30/07/2020.
//  Copyright © 2020 Isabel Briant. All rights reserved.
//

import SwiftUI

struct EmojiPicker: View {
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(EmojiArtViewModel.palette, id: \.self) { emoji in // provide a var to use as the id (Identifiable), using keypath
                    Text(emoji)
                        .font(.system(size: ViewConstants.defaultEmojiSize))
                        .onDrag { NSItemProvider(object: emoji as NSString) }
                }
            }
        }.padding(.horizontal)
    }
}

struct EmojiPicker_Previews: PreviewProvider {
    static var previews: some View {
        EmojiPicker()
    }
}
