//
//  SelectPriceView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 25.01.2025.
//

import SwiftUI

struct SelectPriceView: View {
    @State private var priceText: String = ""
    @State private var valueText: String = "0"
    @State private var countText: String = "0"
    @ObservedObject var viewModel: SelectPriceViewModel
    
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            
            saveButton
        }
        .overlay(alignment: .top) {
            contentView
        }
        .padding([.horizontal, .bottom], 16)
        .background(.invoiceBackground)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    viewModel.backButtonTapped()
                } label: {
                    Image(systemName: "arrow.backward")
                        .tint(.beanRed)
                }
            }
        }
        .onAppear {
            updateSumText()
        }
    }
}

private extension SelectPriceView {
    private var contentView: some View {
        VStack(spacing: 32) {
            Button {
                viewModel.priceTypeButtonTapped()
            } label: {
                SelectPriceRow(priceKind: viewModel.price.wrappedValue.kind)
            }
            
            priceTextField
            
            additionalFields
        }
    }
    
    private var priceTextField: some View {
        VStack(spacing: 8) {
            Text("Sum")
                .foregroundStyle(.lightGreyGreen)
                .font(.footnote)
            
            HStack(spacing: 8) {
                PriceTextField(text: $priceText)
                    .background {
                        GeometryReader { geometry in
                            Color.clear
                                .frame(width: geometry.size.width, height: geometry.size.height)
                        }
                    }
                    .fixedSize()
                    .tint(.beanRed)
                    .keyboardType(.decimalPad)
                    .onChange(of: priceText) { _, newValue in
                        viewModel.updateFixedPrice(text: newValue)
                    }
                
                Text(viewModel.currency.string)
            }
            .font(.price)
        }
    }
    
    @ViewBuilder
    private var additionalFields: some View {
        switch viewModel.price.wrappedValue.kind {
        case .fixed:
            EmptyView()
            
        case .calculate:
            calculatePriceView
            
//        case .multi:
//            multiPriceView
        }
    }
    
    private var calculatePriceView: some View {
        HStack(spacing: 16) {
            TitleTextField(
                title: "Enter sum at 1",
                placeholder: "Sum",
                text: $valueText
            )
            .keyboardType(.decimalPad)
            .onChange(of: valueText) { _, newValue in
                viewModel.updatedCalculatedPrice(value: newValue, count: countText)
                priceText = viewModel.price.wrappedValue.sumString
            }
            
            TitleTextField(
                title: "Enter count",
                placeholder: "Count",
                text: $countText
            )
            .keyboardType(.numberPad)
            .onChange(of: countText) { _, newValue in
                viewModel.updatedCalculatedPrice(value: valueText, count: newValue)
                priceText = viewModel.price.wrappedValue.sumString
            }
        }
    }
    
//    private var multiPriceView: some View {
//        VStack(spacing: 16) {
//            calculatePriceView
//            
//            Divider()
            
//            HStack(spacing: 16) {
//                TitleTextField(
//                    title: "Previously count",
//                    placeholder: "Value",
//                    text: $store.multiPreviouslyCounterText
//                )
//                .onChange(of: store.multiPreviouslyCounterText) { _, newValue in
//                    store.multiPreviouslyCounterText = newValue.formatted(.priceInput)
//                }
//                
//                TitleTextField(
//                    title: "Current count",
//                    placeholder: "Value",
//                    text: $store.multiCurrentCounterText
//                )
//                .onChange(of: store.multiCurrentCounterText) { _, newValue in
//                    store.multiCurrentCounterText = newValue.formatted(.priceInput)
//                }
//            }
//            .keyboardType(.numberPad)
//        }
//    }
    
    private var saveButton: some View {
        Button("Save") {
            viewModel.saveButtonTapped()
        }
        .buttonStyle(
            BottomActionButtonStyle(fillColor: .beanRed)
        )
        .disabled(viewModel.isDisableSaveButton)
    }
    
    private func updateSumText() {
        let price = viewModel.price.wrappedValue
        
        switch price.kind {
        case .fixed:
            break
            
        case .calculate:
            valueText = price.value?.formatted(.ua) ?? "0"
            countText = price.count?.description ?? "0"
        }
        
        priceText = price.sumString
    }
}

#Preview {
    SelectPriceView(
        viewModel: SelectPriceViewModel(
            coordinator: .preview,
            price: .constant(.calculate(id: UUID(5), value: .zero, count: .zero))
        )
    )
}
