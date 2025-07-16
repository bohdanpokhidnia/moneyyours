//
//  SelectPriceTypeView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 30.06.2025.
//

import SwiftUI

struct SelectPriceTypeView: View {
    @ObservedObject var viewModel: SelectPriceTypeViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Select price")
                .font(.title)
                .fontWeight(.bold)
            
            ForEach(Price.Kind.allCases, id: \.self) { priceKind in
                Button {
                    viewModel.select(priceKind: priceKind)
                } label: {
                    SelectPriceRow(priceKind: priceKind)
                        .frame(maxWidth: .infinity, minHeight: 32, alignment: .leading)
                }
                .opacity(viewModel.priceKind.wrappedValue == priceKind ? 1.0 : 0.5)
                
                Divider()
            }
            
            Spacer()
        }
        .padding([.top, .horizontal], 16)
    }
}

#Preview {
    SelectPriceTypeView(
        viewModel: SelectPriceTypeViewModel(
            coordinator: .preview,
            priceKind: .constant(.fixed)
        )
    )
}
