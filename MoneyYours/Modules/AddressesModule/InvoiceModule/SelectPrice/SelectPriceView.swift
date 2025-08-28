//
//  SelectPriceView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 25.01.2025.
//

import SwiftUI

struct SelectPriceView: View {
    struct TextFieldState {
        var title: String
        var placeholder: String
        var text: Binding<String>
        var keyboardType: UIKeyboardType
    }
    
    @StateObject var viewModel: SelectPriceViewModel
    @FocusState private var isFocusedPriceText: Bool
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                communalInvoiceTypeView(type: viewModel.communalInvoiceType)
                
                priceTextField
                
                textFields(for: viewModel.communalInvoiceType)
                    .padding([.horizontal, .bottom], 16)
            }
        }
        .safeAreaInset(edge: .bottom) {
            saveButton
                .padding([.horizontal, .bottom], 16)
        }
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
    }
}

private extension SelectPriceView {
    private func communalInvoiceTypeView(type: CommunalInvoiceType) -> some View {
        Text(type.emoji + " " + type.name)
            .font(.headline)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background {
                RoundedRectangle(cornerRadius: 32)
                    .foregroundStyle(type.color.gradient)
            }
    }
    
    private var priceTextField: some View {
        VStack(spacing: 8) {
            Text("Sum:")
                .foregroundStyle(.starDust)
                .font(.subheadline)
            
            HStack(spacing: 8) {
                PriceTextField(
                    placeholder: "",
                    alignment: .center,
                    text: $viewModel.priceText
                )
                .background {
                    GeometryReader { geometry in
                        Color.clear
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                }
                .fixedSize()
                .tint(.beanRed)
                .keyboardType(.decimalPad)
                .focused($isFocusedPriceText)
                .onChange(of: isFocusedPriceText) { _, newValue in
                    if newValue {
                        viewModel.beginEditingPriceIfNeeded()
                    } else {
                        viewModel.priceText = viewModel.formattedPrice(text: viewModel.priceText)
                    }
                }
                
                Text(viewModel.currency.string)
            }
            .font(.price)
            
            Text("Total:")
                .foregroundStyle(.starDust)
                .font(.subheadline)
            
            HStack {
                Text(viewModel.sumText)
                
                Text(viewModel.currency.string)
            }
            .font(.price) // або інший стиль
        }
    }
    
    func textFields(for type: CommunalInvoiceType) -> some View {
        VStack(spacing: 16) {
            switch type {
            case .electricity:
                sectionTextFieldRow(
                    sectionTitle: "T1",
                    valueState: TextFieldState(
                        title: "Sum at 1",
                        placeholder: "Sum",
                        text: $viewModel.valueText,
                        keyboardType: .decimalPad
                    ),
                    countState: TextFieldState(
                        title: "Count",
                        placeholder: "Count",
                        text: $viewModel.countText,
                        keyboardType: .numberPad
                    )
                )
                
                sectionTextFieldRow(
                    sectionTitle: "T2",
                    valueState: TextFieldState(
                        title: "Sum at 1",
                        placeholder: "Sum",
                        text: $viewModel.secondValueText,
                        keyboardType: .decimalPad
                    ),
                    countState: TextFieldState(
                        title: "Count",
                        placeholder: "Count",
                        text: $viewModel.secondCountText,
                        keyboardType: .numberPad
                    )
                )
                
            case .internet:
                textFieldRow(
                    valueState: TextFieldState(
                        title: "Sum at 1 day",
                        placeholder: "Sum",
                        text: $viewModel.valueText,
                        keyboardType: .decimalPad
                    ),
                    countState: TextFieldState(
                        title: "Count days",
                        placeholder: "Count",
                        text: $viewModel.countText,
                        keyboardType: .numberPad
                    )
                )
                
            case .water, .heating, .gas, .gasDelivery, .garbageDisposal, .rent, .notSelected:
                EmptyView()
            }
        }
    }
    
    func sectionTextFieldRow(
        sectionTitle: String,
        valueState: TextFieldState,
        countState: TextFieldState
    ) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(sectionTitle)
                .font(.headline)
            
            Divider()
            
            textFieldRow(valueState: valueState, countState: countState)
        }
    }
    
    func textFieldRow(
        valueState: TextFieldState,
        countState: TextFieldState
    ) -> some View {
        HStack(spacing: 16) {
            textField(state: valueState)
            
            textField(state: countState)
        }
    }
    
    private func textField(state: TextFieldState) -> some View {
        TitlePriceTextField(
            title: state.title,
            placeholder: state.placeholder,
            text: state.text
        )
        .keyboardType(state.keyboardType)
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
}

#Preview {
    @Previewable @State var price: Price = .row(id: UUID(5), value: 0.0, count: 1)

    PreviewCoordinatorNavigationStack {
        SelectPriceView(
            viewModel: SelectPriceViewModel(
                coordinator: .preview,
                price: $price,
                communalInvoiceType: .electricity,
                monthInvoice: MonthInvoice(
                    id: UUID(6),
                    addressId: UUID(1),
                    year: 2025,
                    month: .august
                )
            )
        )
    }
}
