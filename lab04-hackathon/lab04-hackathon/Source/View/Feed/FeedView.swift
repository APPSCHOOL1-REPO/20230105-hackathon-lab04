//
//  FeedView.swift
//  lab04-hackathon
//
//  Created by MacBook on 2023/01/05.
//

import SwiftUI

struct FeedView: View {
    @State private var showMenu = false
    
    let data = Feed.dummy
    
    var body: some View {
        NavigationView {
            let drag = DragGesture()
                .onEnded {
                    if $0.translation.width < -100 {
                        withAnimation {
                            showMenu = false
                        }
                    }
                }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    ScrollView {
                        ForEach(data) { feed in
                            FeedCell(feed: feed)
                        }
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: showMenu ? geometry.size.width/2 : 0)
                    .disabled(showMenu ? true : false)
                    if showMenu {
                        FeedMenu()
                            .frame(width: geometry.size.width/2)
                            .transition(.move(edge: .leading))
                    }
                }
                .gesture(drag)
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        withAnimation {
                            showMenu.toggle()
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("hi")
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
