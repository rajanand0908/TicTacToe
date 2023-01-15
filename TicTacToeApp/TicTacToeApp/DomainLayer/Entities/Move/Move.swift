//
//  Move.swift
//  TicTacToeApp
//
//  Created by Raj Anand on 15/01/23.
//

enum Player {
  case human, computer
}

struct Move {
  let player: Player
  let boardIndex: Int
  
  var indicator: String {
    return player == .human ? "xmark" : "circle"
  }
}
