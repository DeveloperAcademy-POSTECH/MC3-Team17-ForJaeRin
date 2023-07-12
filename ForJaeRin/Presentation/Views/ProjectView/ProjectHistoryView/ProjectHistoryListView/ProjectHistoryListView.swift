//
//  ProjectHistoryListView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/12.
//

import SwiftUI

struct ProjectHistoryListView: View {
    let currencyStyle = Decimal.FormatStyle.Currency(code: "USD")
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("연습 기록보기")
            GeometryReader { geometry in
                ScrollView {
                    Table(of: Purchase.self) {
                                TableColumn("Base price") { purchase in
                                    Text(purchase.price, format: currencyStyle)
                                        .frame(height: 64)
                                }
                                TableColumn("With 15% tip") { purchase in
                                    Text(purchase.price * 1.15, format: currencyStyle)
                                }
                                TableColumn("With 20% tip") { purchase in
                                    Text(purchase.price * 1.2, format: currencyStyle)
                                }
                                TableColumn("With 25% tip") { purchase in
                                    Text(purchase.price * 1.25, format: currencyStyle)
                                }
                            } rows: {
                                TableRow(Purchase(price: 20))
                                TableRow(Purchase(price: 50))
                                TableRow(Purchase(price: 75))
                            }
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            
                }
//                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .border(.red, width: 2)
    }
}

struct ProjectHistoryListView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectHistoryListView()
    }
}

struct Purchase: Identifiable {
    let price: Decimal
    let id = UUID()
}
