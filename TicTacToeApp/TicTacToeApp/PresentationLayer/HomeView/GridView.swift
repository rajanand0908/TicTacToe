//
//  GridView.swift
//  TicTacToeApp
//
//  Created by Raj Anand on 15/01/23.
//

import SwiftUI

struct GridView: View {
  
  let columns = [GridItem(.flexible()),
                 GridItem(.flexible()),
                 GridItem(.flexible())]
  
  @State private var moves: [Move?] = Array(repeating: nil, count: 9)
  @State private var isGameBoardDisabled = false
  
  var body: some View {
    GeometryReader { geometry in
      VStack {
        Spacer()
        LazyVGrid(columns: columns, spacing: 5) {
          ForEach(0..<9) { index in
            ZStack {
              Circle()
                .foregroundColor(.red)
                .frame(width: geometry.size.width / 3 - 15, height: geometry.size.width / 3 - 15)
              Image(systemName: moves[index]?.indicator ?? "")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.white)
            }
            .onTapGesture {
              guard !isSquareOccupied(in: moves, forIndex: index) else { return }
              moves[index] = Move(player: .human,
                                  boardIndex: index)
              if checkWinCondition(for: .human, in: moves) {
                print("Human wins")
                return
              }
              
              if checkForDraw(in: moves) {
                print("Game Draw")
                return
              }
              isGameBoardDisabled = true
              // check for win condition or draw
              DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let computerPosition = determineComputerMovePosition(in: moves)
                moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
                isGameBoardDisabled = false
              }
              if checkWinCondition(for: .computer, in: moves) {
                print("Computer wins")
                return
              }
              if checkForDraw(in: moves) {
                print("Game Draw")
                return
              }
            }
          }
        }
        Spacer()
      }
      .disabled(isGameBoardDisabled)
      .padding()
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
    return winPatters.contains(playersPosition)
  }
  
  func checkForDraw(in moves: [Move?]) -> Bool {
    return moves.compactMap { $0 }.count == 9
  }
  
}
