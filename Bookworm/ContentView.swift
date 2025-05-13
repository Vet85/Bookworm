//
//  ContentView.swift
//  Bookworm
//
//  Created by Vitaliy Novichenko on 05.05.2025.

//
//  (sort: \Book.rating, order: .reverse)
//  (sort: \Book.title)
//  (sort: [SortDescriptor(\Book.title, order: .reverse)])

import SwiftData
import SwiftUI



struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.author)
    ]) var books: [Book]
    
    @State private var showingAddScreen = false
    
    var body: some View {
           NavigationStack {
                List {
                    ForEach(books) { book in
                        NavigationLink(value: book) {
                            HStack {
                                EmogiRatingView(rating: book.rating)
                                    .font(.largeTitle)
                                
                                VStack(alignment: .leading) {
                                    Text(book.title)
                                        .font(.headline)
                                        .foregroundStyle(book.rating == 1 ? .red : .white)
                                    Text(book.author)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .listRowBackground(Color.clear)
                        }
                    }
                    
                    .onDelete(perform: deleteBook)
                }
                .scrollContentBackground(.hidden)
                
                .background(Image(.book)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.keyboard)
                )
                .navigationTitle("Bookworm \(books.count)")
                .toolbarBackground(.yellow)
                .toolbarColorScheme(.dark)
                .navigationDestination(for: Book.self, destination: { bookk in
                    DetailView(book: bookk)
                })
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add book", systemImage: "plus") {
                            showingAddScreen.toggle()
                        }
                    }
                }
                .sheet(isPresented: $showingAddScreen) {
                    AddBookView()
                }
            
        }
            .background(Color.blue)
    }
    func deleteBook(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}
