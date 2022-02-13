//
//  TodoApiProtocol.swift
//  
//
//  Created by Eszenyi Gábor on 2022. 02. 13..
//

import Foundation

public protocol TodoApiProtocol {

    func getTodoList() async throws -> [Todo.Item.Response]

    func createNew(todoItem: Todo.Item.Request) async throws -> Todo.Item.Response

    func getTodoItem(for id: String) async throws -> Todo.Item.Response

    func update(todoItem: Todo.Item.Request, for id: String) async throws -> Todo.Item.Response

    func deleteTodoItem(for id: String) async throws -> EmptyResponse
}
