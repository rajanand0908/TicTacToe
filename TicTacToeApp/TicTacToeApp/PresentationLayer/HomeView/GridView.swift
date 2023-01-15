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
              // check for win condition or draw
              DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let computerPosition = determineComputerMovePosition(in: moves)
                moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
              }
            }
          }
        }
        Spacer()
      }
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
  
}
