//
//  PrototypeFeedDetailView.swift
//  lab04-hackathon
//
//  Created by 지정훈 on 2023/01/05.
//

import SwiftUI

struct PrototypeFeedDetailView: View {
    var arr : [String] = ["귀여워", "귀여오옹오", "햄뿡이 최고"]
    var body: some View {
        VStack{
            Text("햄뿡이")
            Image(systemName: "pencil.circle.fill")
                .resizable()
                .aspectRatio( contentMode: .fit)
                .frame(width: 250,height: 250)
            //댓글에 들어가는 뷰
            VStack(alignment: .leading){
                HStack{
                    Text("날짜 들어감")
                }
                Text("햄뿡이에욧")   //작성자 게시글
            }.padding(20)
            VStack{
                // 참고자료
                //https://seons-dev.tistory.com/entry/SwiftUI-ForEach
                //댓글이 들어갈 예정
                ForEach(arr.indices){ index in
                    Text("\(arr[index])")
                }
            }
        }
    }
}

struct PrototypeFeedDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PrototypeFeedDetailView()
    }
}
