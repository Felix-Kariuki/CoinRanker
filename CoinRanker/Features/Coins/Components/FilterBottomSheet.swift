//
//  FilterBottomitem.swift
//  CoinRanker
//
//  Created by Felix kariuki on 28/06/2025.
//

import SwiftUI
import Foundation

public struct FilterBottomSheet: View {
    var onCancel:()->Void
    var onApply:()->Void
    @StateObject var viewModel: CoinsViewModel
    public var body: some View {
        VStack{
            TitleMedium(text: "sortBy",fontSize: 20)
            
            Divider()
            ForEach(viewModel.sortOptions, id: \.id){item in
                FilterOption(
                    title: item.name,
                    isSelected: viewModel.filters.contains(item.filter),
                    onSelect: {
                        viewModel.onFilterSelect(item.filter)
                    })
                Divider()
            }
            
            bottomButtons
            
        }.padding([.bottom,.leading,.trailing],spacing.medium)
    }
}


struct FilterOption:View {
    var title:String
    var isSelected:Bool = false
    var onSelect:()->Void = { }
    var body: some View {
        HStack{
            BodyLargeText(text: title)
            Spacer()
            if isSelected {
                Image(
                    systemName:"checkmark.circle.fill").foregroundStyle(Theme.primaryColor)
            }
        }.padding(.vertical, spacing.small)
            .contentShape(Rectangle())
            .onTapGesture {
                onSelect()
            }
    }
}

private extension FilterBottomSheet {
    var bottomButtons: some View {
        HStack(spacing:spacing.extraMedium){
            SecondaryButton(text: "cancel", onClick: {
                onCancel()
            },fontSize: 16)
            
            
            PrimaryButton(text: "apply", onClick: {
                onApply()
            },fontSize: 16)
            
            
        }.padding(.vertical)
    }
}


#Preview {
    FilterBottomSheet(
        onCancel: {},
        onApply: {},
        viewModel: CoinsViewModel())
}
