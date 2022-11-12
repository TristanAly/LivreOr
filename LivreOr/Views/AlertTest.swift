//
//  AlertTest.swift
//  LivreOr
//
//  Created by apprenant1 on 28/10/2022.
//

import SwiftUI

struct AlertTest: View {
   
    @State var array = ["test", "test1", "test2", "test4"]
    @State var show = false
    var body: some View {
        VStack{
            List{
                ForEach(array, id: \.self) { test in
                    HStack{
                        Text(test)
                    }
                }
                .swipeActions(edge: .trailing) {
                    Button {
                    show = true
                    } label: {
                        Image(systemName: "trash.fill")
                    }
                }
            }
        }
        .confirmationDialog("Delete", isPresented: $show) {
            Button {
                array.remove(at: 0)
            } label: {
                Text("Delete")
            }

        } message: {
            Text("are you sure to delete this message ?")
        }

    }
}

struct AlertTest_Previews: PreviewProvider {
    static var previews: some View {
        AlertTest()
    }
}
