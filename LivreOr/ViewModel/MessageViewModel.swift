//
//  MessageViewModel.swift
//  LivreOr
//
//  Created by apprenant1 on 24/10/2022.
//

import Foundation

class MessageViewModel: ObservableObject {
    
    @Published var messages = MessageData(message: [Message(id: 1, content: "test")])
    @Published var message: Message?
    @Published var test = IndexSet.self
    @Published var content: String = ""
    
    
    let basedURL = "http://localhost:8000"
    
    // MARK: Post Data
    func getMessage() async throws -> (MessageData) {
        
        guard let url = URL(string: "\(basedURL)/index")
        else { fatalError("Couldn't not find URL") }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
        //        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let messages = try JSONDecoder().decode(MessageData.self, from: data)
        print("Async decodedUser", messages)
        return messages
    }
    
    // MARK: Create Data
    func createMessage(content: String) async throws -> Message {
        // passer l'url de l'api
        guard let url = URL(string: "\(basedURL)/index")
        else {
            fatalError("Missing URL")
        }
        
        // créer le dictionnaire des données
        let body: [String : String] = ["content" : content]
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        // ajoute les valeurs dans le hearder de la requete pour préciser les types de données
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //prend les données et le transformer en objet Data optionnel(encoder)
        urlRequest.httpBody = try? JSONEncoder().encode(body)
        
        // éxecuter la requête
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        // decoder les données
        let decoder = JSONDecoder()
        //cconvertir le
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let message = try decoder.decode(Message.self, from: data)
        
        // retourner les données
        print("success created: \(message)")
        return message
    }
    
    // MARK: Update Data
    func updateMessage(content: String, id: Int) async throws -> Message {
        guard let url = URL(string: "\(basedURL)/index/\(id)")
        else {
            fatalError("Missing URL")
        }
        
        let body: [String : String] = ["content" : content]
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        urlRequest.httpBody = try? JSONEncoder().encode(body)
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let message = try decoder.decode(Message.self, from: data)
        
        print("success update: \(message)")
        return message
    }
    
    // MARK: Delete Data
    func deleteMessage(id: Int) async throws -> Message {
        guard let url = URL(string: "\(basedURL)/\(id)")
        else {
            fatalError("Missing URL")
        }
        
//        let indexSet: IndexSet = []
//        for index in id {
//            indexSet.append(index)
//        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let message = try decoder.decode(Message.self, from: data)
        
        print("success delete: \(message)")
        return message
    }
}
