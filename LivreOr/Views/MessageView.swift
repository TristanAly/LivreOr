//
//  MessageView.swift
//  LivreOr
//
//  Created by apprenant1 on 24/10/2022.
//

import SwiftUI

struct MessageView: View {
    
    @State private var comment = "test"
    
    var body: some View {
        VStack{
            Image("error")
                .resizable()
                .frame(width: 350,height: 200)
            ZStack{
                RoundedRectangle(cornerRadius: 8)
                    .stroke()
                    .frame(width: 380, height: 150)
                VStack{
                    TextEditor(text: $comment)
                        .frame(width: 370, height: 150)
                }
            }
//            CommentView(message: Row(id: 4, content: "fffd"))
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
