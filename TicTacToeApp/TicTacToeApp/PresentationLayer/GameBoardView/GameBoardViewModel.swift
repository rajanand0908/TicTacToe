//
//  GameBoardViewModel.swift
//  TicTacToeApp
//
//  Created by Raj Anand on 16/01/23.
//

import SwiftUI

final class GameBoardViewModel: ObservableObject {
  
  let columns = [GridItem(.flexible()),
                 GridItem(.flexible()),
                 GridItem(.flexible())]
  
  @Published var moves: [Move?] = Array(repeating: nil, count: 9)
  @Published var isGameBoardDisabled = false
  @Published var alertItem: AlertItem?
  
  func processPlayerMoves(for position: Int) {
    guard !isSquareOccupied(in: moves, forIndex: position) else { return }
    moves[position] = Move(player: .human,
                        boardIndex: position)
    if checkWinCondition(for: .human, in: moves) {
      alertItem = AlertContext.humanWin
      return
    }
    
    if checkForDraw(in: moves) {
      alertItem = AlertContext.draw
      return
    }
    isGameBoardDisabled = true
    // check for win condition or draw
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
      let computerPosition = determineComputerMovePosition(in: moves)
      moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
      isGameBoardDisabled = false
      if checkWinCondition(for: .computer, in: moves) {
        alertItem = AlertContext.computerWin
        return
      }
      if checkForDraw(in: moves) {
        alertItem = AlertContext.draw
        return
      }
    }
  }
  
  func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
    return moves.contains(where: { $0?.boardIndex == index })
  }
  
  func determineComputerMovePosition(in moves: [Move?]) -> Int {
    var movePoisiton = Int.random(in: 0..<9)
    while isSquareOccupied(in: moves, forIndex: movePoisiton) {
      movePoisiton = Int.random(in: 0..<9)
    }
    return movePoisiton
  }
  
  func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
    let winPatters: Set<Set<Int>> = [[0, 1, 2], [0, 3, 6], [0, 4, 8], [1, 4, 7], [2, 5, 8], [2, 4, 6], [3, 4, 5], [6, 7, 8]]
    let playersPosition = Set(moves.compactMap { $0 }.filter { $0.player == player }.map { $0.boardIndex })
     for pattern in winPatters where pattern.isSubset(of: playersPosition) { return true }
    return false
  }
  
  func checkForDraw(in moves: [Move?]) -> Bool {
    return moves.compactMap { $0 }.count == 9
  }
  
  func resetGame() {
    moves = Array(repeating: nil, count: 9)
  }
  
}
