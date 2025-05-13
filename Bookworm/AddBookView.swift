//
//  AddBookView.swift
//  Bookworm
//
//  Created by Vitaliy Novichenko on 06.05.2025.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = "" 
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Unknown"
    @State private var review = ""
    @State private var date = Date.now
    
    let genres = ["Fantasy", "Horror", "Kids", "Poetry", "Romance", "Thriller", "Unknown"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Authors name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                Section("Write a review") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                    
                }
                Section {
                    Button("Save") {
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating, date: .now)
                        modelContext.insert(newBook)
                      //  try? modelContext.save()
                        
                        dismiss()
                    }
                 }
                .disabled(author.isEmpty || title.isEmpty)
            }
            .navigationTitle("Add Book")
        }
    }
}

#Preview {
    AddBookView()
}
