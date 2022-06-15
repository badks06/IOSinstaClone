//
//  ContentView.swift
//  Shared
//
//  Created by Adk Soft on 27/05/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
            HomeView()
                .navigationBarTitle("Instagram",
                                    displayMode: .inline)
                .navigationBarItems(leading:
                            Button(action: {},
                            label: {
                    Image(systemName: "camera")
                }), trailing:
                            Button(action: {},
                            label: {
                            Image(systemName: "paperplane")
                }))
            } .tabItem{
                Image(systemName: "house.fill")
                }
            Text("Search")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                }
            Text("Add")
                .tabItem {
                    Image(systemName: "plus.app")
                        .font(.title2)
                }
            Text("Heart")
                .tabItem {
                    Image(systemName: "heart.fill")
                        .font(.title2)
                }
            Text("Profil")
                .tabItem {
                    Image(systemName: "person.fill")
                        .font(.title2)
                }
        }
    }
}

struct HomeView: View {
    var relativeFormatter: RelativeDateTimeFormatter {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        formatter.locale = Locale(identifier: "fr_FR")
        return formatter
    }
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack(spacing: 20) {
                        ForEach(Author.all) {author in
                            AuthorStoryView(author: author)
                        }
                    }.padding(.all, 10)
                }
                Divider()
                
                ForEach(Post.all) { post in
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            AuthorStoryView(author: post.author, width: 40, showText: false)
                            VStack(alignment: .leading) {
                                Text(post.author.name)
                                    .font(.headline)
                                Text("Paris")
                            }
                            
                            Spacer()
                            Image(systemName: "ellipsis")
                        } .padding(.all, 10)
                        
                        Divider()
                        Image(post.imageName)
                            .resizable()
                            .scaledToFit()
                        
                        HStack(spacing: 20) {
                            Button(action: {}, label: { Image(systemName: "heart")
                                    .font(.title)
                            }).buttonStyle(PlainButtonStyle())
                            Button(action: {}, label: { Image(systemName: "bubble.right")
                                    .font(.title)
                            }).buttonStyle(PlainButtonStyle())
                            Button(action: {}, label: { Image(systemName: "paperplane")
                                    .font(.title)
                            }).buttonStyle(PlainButtonStyle())
                            Spacer()
                            Button(action: {}, label: { Image(systemName: "bookmark")
                                    .font(.title)
                            }).buttonStyle(PlainButtonStyle())
                        }.padding(.all, 10)
                    }
                    VStack(alignment: .leading) {
                        Button(action: {}, label: { Image(systemName: "Voir les j'aime")
                                .font(.headline)
                        }).buttonStyle(PlainButtonStyle())
                        
                    HStack(alignment: .top) {
                        Text(post.author.name)
                            .font(.headline)
                        Text(post.comment)
                            .lineLimit(nil)
                    }
                        
                        Text(relativeFormatter.localizedString(for: post.creationDate, relativeTo: Date()))
                    }.padding(.horizontal)
            }
        }
    }
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AuthorStoryView: View {
    let author: Author
    var width: CGFloat = 70
    var showText = true
    var body: some View {
    VStack {
        Image(author.photoName)
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .frame(width: width)
            .overlay(
                Circle().stroke(Color.red,
                               style:StrokeStyle(lineWidth: 2))
                .frame(width: width + 5, height: 75)
            )
        if showText {
            Text(author.name)
        }
    }
}
}

