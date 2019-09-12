//
//  TransformerViewModel.swift
//  Aequilibrium
//
//  Created by CtanLI on 2019-09-11.
//  Copyright © 2019 aequilibrium. All rights reserved.
//

import Foundation

class TransformerViewModel: Equatable, TransformerViewModelProtocol {
    
    static func == (lhs: TransformerViewModel, rhs: TransformerViewModel) -> Bool {
        return lhs.tvm.id == rhs.tvm.id
    }
    
    var tvm: Transformers
    required init(tvm: Transformers) {
        self.tvm = tvm
    }
}


