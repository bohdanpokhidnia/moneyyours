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
    @State private var secondValueText: String = "0"
    @State private var secondCountText: String = "0"
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
                .foregroundStyle(.starDust)
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
            
        case .multi:
            multiPriceView
        }
    }
    
    private var calculatePriceView: some View {
        HStack(spacing: 16) {
            textField(
                title: "Enter sum at 1",
                placeholder: "Sum",
                text: $valueText,
                keyboardType: .decimalPad,
                updatedText: valueText
            ) { newValue in
                viewModel.updatedCalculatedPrice(value: newValue, count: countText)
            }
            
            textField(
                title: "Enter count",
                placeholder: "Count",
                text: $countText,
                keyboardType: .numberPad,
                updatedText: countText
            ) { newValue in
                viewModel.updatedCalculatedPrice(value: valueText, count: newValue)
            }
        }
    }
    
    private var multiPriceView: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                textField(
                    title: "Enter sum at 1",
                    placeholder: "Sum",
                    text: $valueText,
                    keyboardType: .decimalPad,
                    updatedText: valueText
                ) { newValue in
                    viewModel.updateMultiPrice(
                        value: newValue,
                        count: countText,
                        secondVale: secondValueText,
                        secondCount: secondCountText
                    )
                }
                
                textField(
                    title: "Enter count",
                    placeholder: "Count",
                    text: $countText,
                    keyboardType: .numberPad,
                    updatedText: countText
                ) { newValue in
                    viewModel.updateMultiPrice(
                        value: valueText,
                        count: newValue,
                        secondVale: secondValueText,
                        secondCount: secondCountText
                    )
                }
            }
            
            Divider()
            
            HStack(spacing: 16) {
                textField(
                    title: "Enter sum at 1",
                    placeholder: "Sum",
                    text: $secondValueText,
                    keyboardType: .decimalPad,
                    updatedText: secondValueText
                ) { newValue in
                    viewModel.updateMultiPrice(
                        value: valueText,
                        count: countText,
                        secondVale: newValue,
                        secondCount: secondCountText
                    )
                }
                
                textField(
                    title: "Enter count",
                    placeholder: "Count",
                    text: $secondCountText,
                    keyboardType: .numberPad,
                    updatedText: secondCountText
                ) { newValue in
                    viewModel.updateMultiPrice(
                        value: valueText,
                        count: countText,
                        secondVale: secondValueText,
                        secondCount: newValue
                    )
                }
            }
        }
    }
    
    private func textField(
        title: String,
        placeholder: String,
        text: Binding<String>,
        keyboardType: UIKeyboardType,
        updatedText: String,
        onChange: @escaping (String) -> Void
    ) -> some View {
        TitleTextField(
            title: title,
            placeholder: placeholder,
            text: text
        )
        .keyboardType(keyboardType)
        .onChange(of: updatedText) { _, newValue in
            onChange(newValue)
            updatePriceText()
        }
    }
    
    private func updatePriceText() {
        priceText = viewModel.price.wrappedValue.sumString
    }
    
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
            valueText = price.value?.formatted(viewModel.currencyFormatStyle) ?? "0"
            countText = price.count?.description ?? "0"
            
        case .multi:
            valueText = price.value?.formatted(viewModel.currencyFormatStyle) ?? "0"
            countText = price.count?.description ?? "0"
            secondValueText = price.secondValue?.formatted(viewModel.currencyFormatStyle) ?? "0"
            secondCountText = price.secondCount?.description ?? "0"
        }
        
        priceText = price.sumString
    }
}

#Preview {
    @Previewable @State var price: Price = .calculate(id: UUID(5), value: 5.0, count: 1)

    PreviewCoordinatorNavigationStack {
        SelectPriceView(
            viewModel: SelectPriceViewModel(
                coordinator: .preview,
                price: $price
            )
        )
    }
}
