//
//  TodoService.swift
//  TodoList
//
//  Created by Phincon on 03/07/24.
//

import Foundation

class TodoService {
  static let todoListKey = "todoList"
  static let doneListKey = "doneList"
  
  var todoList: [String] = {
    UserDefaults.standard.value(forKey: todoListKey) as? [String] ?? []
  }()
  
  var doneList: [String] = {
    UserDefaults.standard.value(forKey: doneListKey)  as? [String] ?? []
  }()
  
  func saveTodo() {
    UserDefaults.standard.set(todoList, forKey: TodoService.todoListKey)
  }
  
  func saveDone() {
    UserDefaults.standard.set(doneList, forKey: TodoService.doneListKey)
  }
  
  func saveTodoAndDone() {
    saveTodo()
    saveDone()
  }
  
  func add(todo: String) {
    todoList.append(todo)
    saveTodo()
  }
  
  func removeTodo(at index: Int) {
    todoList.remove(at: index)
    saveTodo()
  }
  
  func removeDone(at index: Int) {
    doneList.remove(at: index)
    saveTodo()
  }
  
  func switchTodo(at index: Int) {
    let removedTodo = todoList.remove(at: index)
    doneList.append(removedTodo)
    saveTodoAndDone()
  }
  
  func switchDone(at index: Int) {
    let removedDone = doneList.remove(at: index)
    todoList.append(removedDone)
    saveTodoAndDone()
  }
  
}
