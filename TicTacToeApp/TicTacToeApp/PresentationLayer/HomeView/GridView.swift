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
              Image(systemName: "xmark")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.white)
            }
          }
        }
        Spacer()
      }
      .padding()
    }
  }
}
