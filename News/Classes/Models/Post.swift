//
//  Post.swift
//  News
//
//  Created by Алексей Агеев on 22.10.2020.
//

import Foundation

final class Post: Codable, Identifiable {
    let id: UUID?
    let authorId: UUID
    let replyTo: UUID?
    let header: String?
    let text: String
    let imageLink: String?
    let numberOfLikes: UInt64
    let numberOfDislikes: UInt64
    
    init(id: UUID? = nil,
         authorId: UUID,
         replyTo: UUID? = nil,
         header: String,
         text: String,
         imageLink: String? = nil,
         numberOfLikes: UInt64,
         numberOfDislikes: UInt64) {
        self.id = id
        self.authorId = authorId
        self.replyTo = replyTo
        self.header = header
        self.text = text
        self.imageLink = imageLink
        self.numberOfLikes = numberOfLikes
        self.numberOfDislikes = numberOfDislikes
    }
}

extension Post {
    struct PostWithAuthorData: Identifiable {
        let id: UUID?
        let author: User.AnotherUser
        let replyTo: UUID?
        let header: String?
        let text: String
        let imageLink: String?
        let numberOfLikes: UInt64
        let numberOfDislikes: UInt64
    }
}

let testPosts: [Post.PostWithAuthorData] = [
    Post.PostWithAuthorData(
        id: nil,
        author: User.AnotherUser(
            name: "Steve",
            lastname: "Jobs",
            nickname: "SteveJobs",
            imageLink: "samples/cloudinary-group.jpg"
        ),
        replyTo: nil,
        header: "Think Different",
        text: "Here’s to the crazy ones, the misfits, the rebels, the troublemakers, the round pegs in the square holes… the ones who see things differently — they’re not fond of rules… You can quote them, disagree with them, glorify or vilify them, but the only thing you can’t do is ignore them because they change things… they push the human race forward, and while some may see them as the crazy ones, we see genius, because the ones who are crazy enough to think that they can change the world, are the ones who do.",
        imageLink: "sample.jpg",
        numberOfLikes: 0,
        numberOfDislikes: 0
    ),
    Post.PostWithAuthorData(
        id: nil,
        author: User.AnotherUser(
            name: "Steve",
            lastname: "Jobs",
            nickname: "SteveJobs"
        ),
        replyTo: nil,
        header: "Think Different",
        text: "Here’s to the crazy ones, the misfits, the rebels, the troublemakers, the round pegs in the square holes… the ones who see things differently — they’re not fond of rules… You can quote them, disagree with them, glorify or vilify them, but the only thing you can’t do is ignore them because they change things… they push the human race forward, and while some may see them as the crazy ones, we see genius, because the ones who are crazy enough to think that they can change the world, are the ones who do.",
        imageLink: "sample.jpg",
        numberOfLikes: 0,
        numberOfDislikes: 0
    )
]

