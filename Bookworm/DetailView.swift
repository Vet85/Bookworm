//
//  DetailView.swift
//  Bookworm
//
//  Created by Vitaliy Novichenko on 11.05.2025.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    let book: Book
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre)
                    .resizable()
                    .scaledToFit()
                Text(book.genre.uppercased())
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x: -5, y: -5)
            }
            Text(book.author)
                .font(.title)
                .foregroundStyle(.secondary)
            Text(book.review)
                .padding()
            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    do {
        //конфигурация модели будет хранится только в памяти
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let conteiner = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(title: "Test Book", author: "Test Author", genre: "Fantasy", review: "This was a great book, i realy enjoed it.", rating: 4)
        
        return DetailView(book: example)
            .modelContainer(conteiner)
    } catch {
        return Text("Failed to create preview \(error.localizedDescription)")
    }
}
