//===------------ SCFToSPIRV.h - Pass entrypoint ----------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// Provides patterns for lowering SCF ops to SPIR-V dialect.
//
//===----------------------------------------------------------------------===//
#ifndef MLIR_CONVERSION_SCFTOSPIRV_SCFTOSPIRV_H_
#define MLIR_CONVERSION_SCFTOSPIRV_SCFTOSPIRV_H_

#include <memory>

namespace mlir {
class MLIRContext;
class Pass;

// Owning list of rewriting patterns.
class OwningRewritePatternList;
class SPIRVTypeConverter;

/// Collects a set of patterns to lower from scf.for, scf.if, and
/// loop.terminator to CFG operations within the SPIR-V dialect.
void populateSCFToSPIRVPatterns(MLIRContext *context,
                                SPIRVTypeConverter &typeConverter,
                                OwningRewritePatternList &patterns);
} // namespace mlir

#endif // MLIR_CONVERSION_SCFTOSPIRV_SCFTOSPIRV_H_
