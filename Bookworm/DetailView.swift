//
//  DetailView.swift
//  Bookworm
//
//  Created by Vitaliy Novichenko on 11.05.2025.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    let book: Book
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                
                    images()
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
            Text("i read this book \(book.date?.formatted(date:.abbreviated, time: .omitted) ?? "")")
                .padding()
                .foregroundStyle(.secondary)
            Text(book.review)
                .font(.title2)
                .padding()
            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete Book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) {  }
        } message: {
            Text("Are yoy sure?")
        }
        .toolbar {
            Button("Delete this book", systemImage: "trash") {
                showingDeleteAlert = true
            }
        }
    }
    func deleteBook() {
        modelContext.delete(book)
        dismiss()
    }
    func images() -> Image {
        if book.genre == "Unknown" {
            Image(.book)
        } else {
            Image(book.genre)
        }
    }
}

#Preview {
    do {
        //конфигурация модели будет хранится только в памяти
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let conteiner = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(title: "Test Book", author: "Test Author", genre: "Fantasy", review: "This was a great book, i realy enjoed it.", rating: 4, date: .now)
        
        return DetailView(book: example)
            .modelContainer(conteiner)
    } catch {
        return Text("Failed to create preview \(error.localizedDescription)")
    }
}
