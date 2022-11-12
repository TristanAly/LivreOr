//
//  ListMessageView.swift
//  LivreOr
//
//  Created by apprenant1 on 24/10/2022.
//

import SwiftUI

struct ListMessageView: View {
    @ObservedObject var vm = MessageViewModel()
    @State var show = false
    @State var showAlert = false

    
    var body: some View {
        NavigationView {
            VStack {
                List{
                    ForEach(vm.messages.message, id: \.content){
                        message in
                        NavigationLink {
                            CommentView(message: message)
                        } label: {
                            Text(message.content)
                        }
                    }
                     .onDelete(perform: deleteRow)
                }
            }
            .onAppear{
                Task{
                    vm.messages = try await vm.getMessage()
                }
            }
            .navigationTitle("TestList")
            .toolbar {
                ToolbarItem {
                    buttonplus
                        .sheet(isPresented: $show) {
                            NewPostView( isPresented: $show)
                        }
                }
            }
        }
    }
        func deleteRow(at indexSet: IndexSet) {
            for index in indexSet {
                    let messages = vm.messages.message[index]
                    showAlert = true
                        Task{
                            try await vm.deleteMessage(id: messages.id)
               }
            }
        }
}

struct ListMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ListMessageView()
    }
}

extension ListMessageView {
    
    private var buttonplus: some View{
        Button {
            show.toggle()
        } label: {
            Image(systemName: "plus")
        }
    }
}

extension BinaryInteger {
    var digits: [Int] {
        return String(describing: self).compactMap { Int(String($0)) }
    }
}
