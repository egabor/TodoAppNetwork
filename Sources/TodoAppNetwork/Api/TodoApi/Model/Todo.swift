//
//  Todo.swift
//  
//
//  Created by Eszenyi Gábor on 2022. 02. 13..
//

import Foundation

public struct Todo {
    public struct Item: Codable {
        public struct Request: Encodable {
            public var id: String?
            public var title: String
            public var desc: String?
            public var isCompleted: Bool?
            public var createdAt: Date?
            public var modifiedAt: Date?

            public init(
                id: String? = nil,
                title: String,
                desc: String? = nil,
                isCompleted: Bool? = nil,
                createdAt: Date? = nil,
                modifiedAt: Date? = nil
            ) {
                self.id = id
                self.title = title
                self.desc = desc
                self.isCompleted = isCompleted
                self.createdAt = createdAt
                self.modifiedAt = modifiedAt
            }
        }

        public struct Response: Decodable {
            public var id: String
            public var title: String
            public var desc: String?
            public var isCompleted: Bool
            public var createdAt: Date
            public var modifiedAt: Date
        }
    }
}
