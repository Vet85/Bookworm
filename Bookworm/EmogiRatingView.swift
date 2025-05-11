//
//  EmogiRatingView.swift
//  Bookworm
//
//  Created by Vitaliy Novichenko on 09.05.2025.
//

import SwiftUI

struct EmogiRatingView: View {
    let rating: Int
    
    var body: some View {
        switch rating {
        case 1:
            Text("🙈")
        case 2:
            Text("💁")
        case 3:
            Text("😏")
        case 4:
            Text("😄")
        default:
            Text("😍")
        }
    }
}

#Preview {
    EmogiRatingView(rating: 3)
}
