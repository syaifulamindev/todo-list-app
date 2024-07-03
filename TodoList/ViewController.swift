//
//  ViewController.swift
//  TodoList
//
//  Created by Phincon on 03/07/24.
//

import UIKit

class ViewController: UIViewController {

  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var plusButton: UIButton!
  var todoServices = TodoService()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupButton()
    setupTableView()
  }
  
  func setupButton() {
    plusButton.backgroundColor = .systemGreen
    plusButton.layer.cornerRadius = 27
    plusButton.layer.masksToBounds = true
    plusButton.tintColor = .white
  }
  
  func setupTableView() {
    tableView.register(UINib(nibName: "TodoTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
  }
  
  @IBAction func addTask() {
    let alertController = UIAlertController(title: "Todo", message: "input something you want todo", preferredStyle: .alert)
    alertController.addTextField { textfield in
      textfield.placeholder = "Do Something.."
    }
    
    let okAction = UIAlertAction(title: "OK", style: .default) { action in
      let todoText = alertController.textFields?.first?.text
      self.todoServices.add(todo: todoText ?? "")
      self.tableView.reloadData()
    }
    
    alertController.addAction(okAction)
    
    present(alertController, animated: true)
  }
  
  
  
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    section == 0 ? todoServices.todoList.count : todoServices.doneList.count
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    section == 0 ? "Todo" : "Done"
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TodoTableViewCell
    
    if indexPath.section == 0 {
      cell.todoLabel.text = todoServices.todoList[indexPath.row]
    } else {
      cell.todoLabel.text = todoServices.doneList[indexPath.row]
    }
    
    cell.selectionStyle = .none
    cell.delegate = self
    cell.indexPath = indexPath
    cell.isChecked = indexPath.section == 1
    return cell
  }
  
  
}

extension ViewController: TodoTableViewCellDelegate {
  
  func todoTableViewCheckmark(_ indexPath: IndexPath, isChecked: Bool) {
    if indexPath.section == 0 {
      todoServices.switchTodo(at: indexPath.row)
    } else {
      todoServices.switchDone(at: indexPath.row)
    }
  }
  
  
}

