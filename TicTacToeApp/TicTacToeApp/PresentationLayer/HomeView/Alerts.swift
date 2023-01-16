//
//  Alerts.swift
//  TicTacToeApp
//
//  Created by Raj Anand on 16/01/23.
//

import SwiftUI

struct AlertItem: Identifiable {
  let id = UUID()
  var title: Text
  var message: Text
  var buttonTitle: Text
}

struct AlertContext {
  static let humanWin    = AlertItem(title: Text("You Win!"),
                           message: Text("Congratulation, You beat your own AI"),
                           buttonTitle: Text("Play Again"))
  static let computerWin = AlertItem(title: Text("You Lost"),
                              message: Text("You programmed a super AI."),
                              buttonTitle: Text("Rematch"))
  static let draw        = AlertItem(title: Text("Draw"),
                       message: Text("What a battle of wits we have..."),
                       buttonTitle: Text("Try Again"))
  
}
