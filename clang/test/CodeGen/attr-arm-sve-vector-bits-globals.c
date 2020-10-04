// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: aarch64-registered-target
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -target-feature +bf16 -msve-vector-bits=128 -fallow-half-arguments-and-returns -S -O1 -emit-llvm -o - %s | FileCheck %s --check-prefix=CHECK-128
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -target-feature +bf16 -msve-vector-bits=512 -fallow-half-arguments-and-returns -S -O1 -emit-llvm -o - %s | FileCheck %s --check-prefix=CHECK-512

#include <arm_sve.h>

#define N __ARM_FEATURE_SVE_BITS

typedef svint64_t fixed_int64_t __attribute__((arm_sve_vector_bits(N)));
typedef svbfloat16_t fixed_bfloat16_t __attribute__((arm_sve_vector_bits(N)));
typedef svbool_t fixed_bool_t __attribute__((arm_sve_vector_bits(N)));

fixed_int64_t global_i64;
fixed_bfloat16_t global_bf16;
fixed_bool_t global_bool;

//===----------------------------------------------------------------------===//
// WRITES
//===----------------------------------------------------------------------===//

// CHECK-128-LABEL: @write_global_i64(
// CHECK-128-NEXT:  entry:
// CHECK-128-NEXT:    [[V_ADDR:%.*]] = alloca <vscale x 2 x i64>, align 16
// CHECK-128-NEXT:    store <vscale x 2 x i64> [[V:%.*]], <vscale x 2 x i64>* [[V_ADDR]], align 16, [[TBAA6:!tbaa !.*]]
// CHECK-128-NEXT:    [[TMP0:%.*]] = bitcast <vscale x 2 x i64>* [[V_ADDR]] to <2 x i64>*
// CHECK-128-NEXT:    [[TMP1:%.*]] = load <2 x i64>, <2 x i64>* [[TMP0]], align 16, [[TBAA10:!tbaa !.*]]
// CHECK-128-NEXT:    store <2 x i64> [[TMP1]], <2 x i64>* @global_i64, align 16, [[TBAA10]]
// CHECK-128-NEXT:    ret void
//
// CHECK-512-LABEL: @write_global_i64(
// CHECK-512-NEXT:  entry:
// CHECK-512-NEXT:    [[V_ADDR:%.*]] = alloca <vscale x 2 x i64>, align 16
// CHECK-512-NEXT:    store <vscale x 2 x i64> [[V:%.*]], <vscale x 2 x i64>* [[V_ADDR]], align 16, [[TBAA6:!tbaa !.*]]
// CHECK-512-NEXT:    [[TMP0:%.*]] = bitcast <vscale x 2 x i64>* [[V_ADDR]] to <8 x i64>*
// CHECK-512-NEXT:    [[TMP1:%.*]] = load <8 x i64>, <8 x i64>* [[TMP0]], align 16, [[TBAA10:!tbaa !.*]]
// CHECK-512-NEXT:    store <8 x i64> [[TMP1]], <8 x i64>* @global_i64, align 16, [[TBAA10]]
// CHECK-512-NEXT:    ret void
//
void write_global_i64(svint64_t v) { global_i64 = v; }

// CHECK-128-LABEL: @write_global_bf16(
// CHECK-128-NEXT:  entry:
// CHECK-128-NEXT:    [[V_ADDR:%.*]] = alloca <vscale x 8 x bfloat>, align 16
// CHECK-128-NEXT:    store <vscale x 8 x bfloat> [[V:%.*]], <vscale x 8 x bfloat>* [[V_ADDR]], align 16, [[TBAA11:!tbaa !.*]]
// CHECK-128-NEXT:    [[TMP0:%.*]] = bitcast <vscale x 8 x bfloat>* [[V_ADDR]] to <8 x bfloat>*
// CHECK-128-NEXT:    [[TMP1:%.*]] = load <8 x bfloat>, <8 x bfloat>* [[TMP0]], align 16, [[TBAA10]]
// CHECK-128-NEXT:    store <8 x bfloat> [[TMP1]], <8 x bfloat>* @global_bf16, align 16, [[TBAA10]]
// CHECK-128-NEXT:    ret void
//
// CHECK-512-LABEL: @write_global_bf16(
// CHECK-512-NEXT:  entry:
// CHECK-512-NEXT:    [[V_ADDR:%.*]] = alloca <vscale x 8 x bfloat>, align 16
// CHECK-512-NEXT:    store <vscale x 8 x bfloat> [[V:%.*]], <vscale x 8 x bfloat>* [[V_ADDR]], align 16, [[TBAA11:!tbaa !.*]]
// CHECK-512-NEXT:    [[TMP0:%.*]] = bitcast <vscale x 8 x bfloat>* [[V_ADDR]] to <32 x bfloat>*
// CHECK-512-NEXT:    [[TMP1:%.*]] = load <32 x bfloat>, <32 x bfloat>* [[TMP0]], align 16, [[TBAA10]]
// CHECK-512-NEXT:    store <32 x bfloat> [[TMP1]], <32 x bfloat>* @global_bf16, align 16, [[TBAA10]]
// CHECK-512-NEXT:    ret void
//
void write_global_bf16(svbfloat16_t v) { global_bf16 = v; }

// CHECK-128-LABEL: @write_global_bool(
// CHECK-128-NEXT:  entry:
// CHECK-128-NEXT:    [[V_ADDR:%.*]] = alloca <vscale x 16 x i1>, align 16
// CHECK-128-NEXT:    store <vscale x 16 x i1> [[V:%.*]], <vscale x 16 x i1>* [[V_ADDR]], align 16, [[TBAA13:!tbaa !.*]]
// CHECK-128-NEXT:    [[TMP0:%.*]] = bitcast <vscale x 16 x i1>* [[V_ADDR]] to <2 x i8>*
// CHECK-128-NEXT:    [[TMP1:%.*]] = load <2 x i8>, <2 x i8>* [[TMP0]], align 16, [[TBAA10]]
// CHECK-128-NEXT:    store <2 x i8> [[TMP1]], <2 x i8>* @global_bool, align 2, [[TBAA10]]
// CHECK-128-NEXT:    ret void
//
// CHECK-512-LABEL: @write_global_bool(
// CHECK-512-NEXT:  entry:
// CHECK-512-NEXT:    [[V_ADDR:%.*]] = alloca <vscale x 16 x i1>, align 16
// CHECK-512-NEXT:    store <vscale x 16 x i1> [[V:%.*]], <vscale x 16 x i1>* [[V_ADDR]], align 16, [[TBAA13:!tbaa !.*]]
// CHECK-512-NEXT:    [[TMP0:%.*]] = bitcast <vscale x 16 x i1>* [[V_ADDR]] to i64*
// CHECK-512-NEXT:    [[TMP1:%.*]] = load i64, i64* [[TMP0]], align 16, [[TBAA10]]
// CHECK-512-NEXT:    store i64 [[TMP1]], i64* bitcast (<8 x i8>* @global_bool to i64*), align 2, [[TBAA10]]
// CHECK-512-NEXT:    ret void
//
void write_global_bool(svbool_t v) { global_bool = v; }

//===----------------------------------------------------------------------===//
// READS
//===----------------------------------------------------------------------===//

// CHECK-128-LABEL: @read_global_i64(
// CHECK-128-NEXT:  entry:
// CHECK-128-NEXT:    [[TMP0:%.*]] = load <vscale x 2 x i64>, <vscale x 2 x i64>* bitcast (<2 x i64>* @global_i64 to <vscale x 2 x i64>*), align 16, [[TBAA10]]
// CHECK-128-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
// CHECK-512-LABEL: @read_global_i64(
// CHECK-512-NEXT:  entry:
// CHECK-512-NEXT:    [[TMP0:%.*]] = load <vscale x 2 x i64>, <vscale x 2 x i64>* bitcast (<8 x i64>* @global_i64 to <vscale x 2 x i64>*), align 16, [[TBAA10]]
// CHECK-512-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
svint64_t read_global_i64() { return global_i64; }

// CHECK-128-LABEL: @read_global_bf16(
// CHECK-128-NEXT:  entry:
// CHECK-128-NEXT:    [[TMP0:%.*]] = load <vscale x 8 x bfloat>, <vscale x 8 x bfloat>* bitcast (<8 x bfloat>* @global_bf16 to <vscale x 8 x bfloat>*), align 16, [[TBAA10]]
// CHECK-128-NEXT:    ret <vscale x 8 x bfloat> [[TMP0]]
//
// CHECK-512-LABEL: @read_global_bf16(
// CHECK-512-NEXT:  entry:
// CHECK-512-NEXT:    [[TMP0:%.*]] = load <vscale x 8 x bfloat>, <vscale x 8 x bfloat>* bitcast (<32 x bfloat>* @global_bf16 to <vscale x 8 x bfloat>*), align 16, [[TBAA10]]
// CHECK-512-NEXT:    ret <vscale x 8 x bfloat> [[TMP0]]
//
svbfloat16_t read_global_bf16() { return global_bf16; }

// CHECK-128-LABEL: @read_global_bool(
// CHECK-128-NEXT:  entry:
// CHECK-128-NEXT:    [[TMP0:%.*]] = load <vscale x 16 x i1>, <vscale x 16 x i1>* bitcast (<2 x i8>* @global_bool to <vscale x 16 x i1>*), align 2, [[TBAA10]]
// CHECK-128-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
// CHECK-512-LABEL: @read_global_bool(
// CHECK-512-NEXT:  entry:
// CHECK-512-NEXT:    [[TMP0:%.*]] = load <vscale x 16 x i1>, <vscale x 16 x i1>* bitcast (<8 x i8>* @global_bool to <vscale x 16 x i1>*), align 2, [[TBAA10]]
// CHECK-512-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
svbool_t read_global_bool() { return global_bool; }
