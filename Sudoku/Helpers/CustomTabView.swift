//
//  CustomTabView.swift
//  Sudoku
//
//  Created by Yedige Ashirbek on 29.04.2023.
//

import SwiftUI

struct TabItemData: Identifiable {
    var id = UUID()
    let image: String
    let title: String
    let index: Int
}

struct TabItemView: View {
    let data: TabItemData
    let isSelected: Bool
    
    var body: some View {
        VStack {
            Image(systemName: data.image)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 21, height: 21)
                .animation(.default, value: isSelected)
                .foregroundColor(isSelected == true ? .blue : .gray)
            
            Text(data.title)
                .foregroundColor(isSelected == true ? .blue : .gray)
                .font(Font.custom(Constants.semibold, size: 10))
        }
    }
}

struct TabBottomView: View {

    @Binding var selectedIndex: Int
    let tabbarItems: [TabItemData]
    var height: CGFloat = 60
    var width: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        HStack {
            Spacer()
            ForEach(tabbarItems) { item in
                Button {
                    self.selectedIndex = item.index
                } label: {
                    let isSelected = (selectedIndex == item.index)
                    TabItemView(data: item, isSelected: isSelected)
                }
                Spacer()
            }
        }
        .frame(width: width - 32, height: height)
        .background(.white)
        .cornerRadius(13)
        .shadow(color: Constants.shadowColor, radius: 5, x: 0, y: 5)
    }
}
