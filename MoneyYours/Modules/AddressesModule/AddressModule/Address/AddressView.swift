//
//  AddressView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 15.06.2024.
//

import SwiftUI


struct AddressView: View {
    @ObservedObject var viewModel: AddressViewModel
    
    var body: some View {
        ScrollableGradientHeaderView(
            title: viewModel.address.name,
            configuration: GradientHeaderConfiguration(presetColors: .addresses)
        ) {
            VStack(alignment: .leading, spacing: 16) {
                subtitleText
                
//                Button("Add month") {
////                    viewModel.addInvoiceButtonTapped()
//                }
//                .buttonStyle(ImageButtonStyle(image: Image(systemName: "plus.circle.fill")))
//                .tint(.black)
//                .padding(16)
                
                ForEach(viewModel.monthLists) { monthList in
                    Text(monthList.year.description)
                        .frame(maxWidth: .infinity)
                    
                    ForEach(monthList.months) { month in
                        Button(month.name) {
                            print("[dev] tapped at \(month.name)")
                        }
                        .buttonStyle(
                            EmojiRowButtonStyle(
                                emoji: month.emoji,
                                emojiBackground: month.color
                            )
                        )
                    }
                    .padding(.horizontal, 16)
                }
            }
            .padding(.bottom, 16)
        }
        .ignoresSafeArea(edges: [.top])
        .background(.appBackground)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button{
                    viewModel.backButtonTapped()
                } label: {
                    Image(systemName: "arrow.backward")
                        .tint(.white)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                HStack(spacing: 8) {
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.white)
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(.white)
                    }
                }
            }
        }
    }
}

// MARK: - Views

private extension AddressView {
    private var subtitleText: some View {
        HStack {
            VStack(alignment: .leading, spacing: 12) {
                Text("Months")
                    .font(.system(size: 19, weight: .bold))
                    .foregroundStyle(.primaryText)
                
                Text("Add month for billing")
                    .foregroundStyle(.starDust)
                    .font(.system(size: 14, weight: .regular))
            }
            
            Spacer()
        }
        .padding([.top, .leading], 16)
    }
}

#Preview {
    NavigationStack {
        AddressView(
            viewModel: AddressViewModel(
                coordinator: .preview,
                address: .activeAddress
            )
        )
        .setupNavigationTransparent()
    }
}
