//
//  NewPostView.swift
//  LivreOr
//
//  Created by apprenant1 on 24/10/2022.
//

import SwiftUI

struct NewPostView: View {
    
    @ObservedObject var vm = MessageViewModel()
    @State var content: String = ""
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            ZStack{
                Color.gray.opacity(0.1).ignoresSafeArea()
                VStack(alignment: .leading){
                    Text("Create new post")
                        .font(.title2)
                        .bold()
                    TextField("Message", text: $content)
                        .padding()
                        .background(.white)
                        .cornerRadius(10)
                        .padding(.bottom)
                    Spacer()
                }.padding()
            }
            .navigationTitle("New Post")
            .toolbar {
                ToolbarItem {
                    Button {
                        Task{
                            vm.message = try await vm.createMessage(content: content)
                            print("j'ai créer une donnée")
                        }
                        Task{
                            try await vm.getMessage()
                        }
                        Task{
                            isPresented.toggle()
                        }
                        
                    } label: {
                        Text("Post")
                    }
                }
            }
        }
    }
}

//struct NewPostView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewPostView()
//    }
//}
