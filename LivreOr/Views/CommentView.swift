//
//  CommentView.swift
//  LivreOr
//
//  Created by apprenant1 on 24/10/2022.
//

import SwiftUI

struct CommentView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var vm = MessageViewModel()
    @State var content = ""
    var message: Message
    var body: some View {
        ZStack{
            Color.gray.opacity(0.4)
                .ignoresSafeArea()
            VStack{
                HStack{
                    Image(systemName: "person.circle.fill")
                        .font(.largeTitle)
                    Text("Name")
                    Spacer()
                    //                Text(message.createdAt!)
                }
                .padding()
                VStack(alignment: .leading){
                    TextEditor(text: $content)
                        .frame(width: 370,height: 190)
                        .cornerRadius(12)
                }
                .onAppear(perform: {
                    self.content = message.content //?? "no content"
                })
                Spacer()
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        Task{
                            vm.message = try await vm.updateMessage(content: self.content, id: message.id)
                            
                        }
                        Task{
                            presentationMode.wrappedValue.dismiss()
                        }
                        
                    } label: {
                        Text("Save")
                    }
                    
                }
            }
        }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(message: Message(id: 1, content: "sed"))
    }
}
