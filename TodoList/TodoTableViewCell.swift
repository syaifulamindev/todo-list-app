//
//  TodoTableViewCell.swift
//  TodoList
//
//  Created by Phincon on 03/07/24.
//

import UIKit


protocol TodoTableViewCellDelegate {
  func todoTableViewCheckmark(_ indexPath: IndexPath, isChecked: Bool)
}

class TodoTableViewCell: UITableViewCell {

  @IBOutlet weak var checkmarkButton: UIButton!
  @IBOutlet weak var todoLabel: UILabel!
  
  var indexPath: IndexPath!
  var delegate: TodoTableViewCellDelegate?
  
  var isChecked: Bool = false {
    didSet {
      let image = isChecked ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "circle")
      checkmarkButton.setImage(image, for: .normal)
    }
  }
  
  @IBAction func toggleCheckmark() {
    isChecked.toggle()
    delegate?.todoTableViewCheckmark(indexPath, isChecked: isChecked)
  }
  
    
}
