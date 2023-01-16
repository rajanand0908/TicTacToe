//
//  GameBoardView.swift
//  TicTacToeApp
//
//  Created by Raj Anand on 15/01/23.
//

import SwiftUI

struct GameBoardView: View {
  
  @StateObject private var viewModel = GameBoardViewModel()
  
  var body: some View {
    GeometryReader { geometry in
      VStack {
        Spacer()
        LazyVGrid(columns: viewModel.columns, spacing: 5) {
          ForEach(0..<9) { index in
            ZStack {
              Circle()
                .foregroundColor(.red)
                .frame(width: geometry.size.width / 3 - 15, height: geometry.size.width / 3 - 15)
              Image(systemName: viewModel.moves[index]?.indicator ?? "")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.white)
            }
            .onTapGesture {
              viewModel.processPlayerMoves(for: index)
            }
          }
        }
        Spacer()
      }
      .disabled(viewModel.isGameBoardDisabled)
      .padding()
      .alert(item: $viewModel.alertItem) { alertItem in
        Alert(title: alertItem.title,
              message: alertItem.message,
              dismissButton: .default(alertItem.buttonTitle) { viewModel.resetGame() })
      }
    }
  }
  
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    GameBoardView()
  }
}
