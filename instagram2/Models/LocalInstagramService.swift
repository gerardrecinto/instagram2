//
//  LocalInstagramService.swift
//  instagram2 — replaces Parse SDK with in-memory mock
//

import UIKit

struct InstaPost {
    let id: String
    let username: String
    let caption: String
    let imageName: String
    let likeCount: Int
    let createdAt: Date
    var isLiked: Bool = false
}

@MainActor
final class LocalInstagramService {

    static let shared = LocalInstagramService()
    private init() {}

    var currentUsername: String? {
        get { UserDefaults.standard.string(forKey: "instaUser") }
        set { UserDefaults.standard.set(newValue, forKey: "instaUser") }
    }

    var isLoggedIn: Bool { currentUsername != nil }

    func login(username: String, password: String) throws {
        guard !username.isEmpty, !password.isEmpty else {
            throw NSError(domain: "Auth", code: 1,
                          userInfo: [NSLocalizedDescriptionKey: "Username and password required"])
        }
        currentUsername = username
    }

    func logout() { currentUsername = nil }

    private(set) var posts: [InstaPost] = [
        InstaPost(id: "1", username: "johndoe", caption: "Golden Gate at sunset", imageName: "", likeCount: 142, createdAt: Date()),
        InstaPost(id: "2", username: "janesmith", caption: "Exploring the city", imageName: "", likeCount: 87, createdAt: Date()),
        InstaPost(id: "3", username: "photolover", caption: "Morning coffee", imageName: "", likeCount: 234, createdAt: Date()),
    ]

    func addPost(caption: String) {
        let post = InstaPost(id: UUID().uuidString, username: currentUsername ?? "me",
                             caption: caption, imageName: "", likeCount: 0, createdAt: Date())
        posts.insert(post, at: 0)
    }

    func toggleLike(id: String) {
        if let idx = posts.firstIndex(where: { $0.id == id }) {
            posts[idx].isLiked.toggle()
        }
    }
}
