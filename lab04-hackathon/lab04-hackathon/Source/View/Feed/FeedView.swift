//
//  FeedView.swift
//  lab04-hackathon
//
//  Created by MacBook on 2023/01/05.
//

import SwiftUI

struct FeedView: View {
    @State var showingMenu = false
    @EnvironmentObject var feed: FeedStore
    @EnvironmentObject var user: UserStore
    
    var body: some View {
        
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation {
                        showingMenu.toggle()
                    }
                }
            }
        
        ZStack {
            
            Color("background")
                .ignoresSafeArea()
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    ScrollView {

                        if feed.feedsSorted.isEmpty {
                            Spacer()
                            FeedCellEmpty()
                                .opacity(showingMenu ? 0.5 : 1)
                            Spacer()
                        } else {
                            ForEach(feed.feedsSorted, id: \.feedId) { feed in
                                FeedCell(feed: feed)
                                    .padding(.bottom)
                                    .opacity(showingMenu ? 0.5 : 1)
                                    .environmentObject(user)
                            }
                        }
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: showingMenu ? geometry.size.width/2 : 0)
                    .disabled(showingMenu ? true : false)
                    if showingMenu {
                        FeedMenu(showingMenu: $showingMenu)
                            .frame(width: geometry.size.width/2)
                            .transition(.move(edge: .leading))
                    }
                }
                .gesture(drag)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button {
                        withAnimation {
                            showingMenu.toggle()
                        }
                    } label: {
                        Image("line")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AddFeedView()
                    } label: {
                        Image("plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                    }
                }
            }
            .onAppear {
                feed.read()
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView().environmentObject(FeedStore())
        
    }
}
