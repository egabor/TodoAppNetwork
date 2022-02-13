//
//  TodoApi.swift
//  
//
//  Created by Eszenyi Gábor on 2022. 02. 13..
//

import Foundation
import Combine

internal class TodoApi: BaseApi, TodoApiProtocol {

    func getTodoList() async throws -> [Todo.Item.Response] {
        let request = NetworkRequest(baseUrl, "items", .get, headers)
        return try await buildRequest(with: request)
    }

    func createNew(todoItem: Todo.Item.Request) async throws -> Todo.Item.Response {
        let request = NetworkRequest(baseUrl, "items", .post, headers, body: convertToData(data: todoItem))
        return try await buildRequest(with: request)
    }

    func getTodoItem(for id: String) async throws -> Todo.Item.Response {
        let request = NetworkRequest(baseUrl, "item/\(id)", .get, headers)
        return try await buildRequest(with: request)
    }

    func update(todoItem: Todo.Item.Request, for id: String) async throws -> Todo.Item.Response {
        let request = NetworkRequest(baseUrl, "items/\(id)", .put, headers, body: convertToData(data: todoItem))
        return try await buildRequest(with: request)
    }

    func deleteTodoItem(for id: String) async throws -> EmptyResponse {
        let request = NetworkRequest(baseUrl, "item/\(id)", .delete, headers)
        return try await buildRequest(with: request)
    }
}
