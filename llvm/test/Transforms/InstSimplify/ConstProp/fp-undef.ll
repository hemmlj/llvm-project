; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instsimplify -S | FileCheck %s

declare <2 x double> @llvm.minnum.v2f64(<2 x double>, <2 x double>)
declare <2 x double> @llvm.maxnum.v2f64(<2 x double>, <2 x double>)
declare <2 x double> @llvm.minimum.v2f64(<2 x double>, <2 x double>)
declare <2 x double> @llvm.maximum.v2f64(<2 x double>, <2 x double>)

; Constant folding - undef undef.

define double @fadd_undef_undef(double %x) {
; CHECK-LABEL: @fadd_undef_undef(
; CHECK-NEXT:    ret double undef
;
  %r = fadd double undef, undef
  ret double %r
}

define double @fsub_undef_undef(double %x) {
; CHECK-LABEL: @fsub_undef_undef(
; CHECK-NEXT:    ret double undef
;
  %r = fsub double undef, undef
  ret double %r
}

define double @fmul_undef_undef(double %x) {
; CHECK-LABEL: @fmul_undef_undef(
; CHECK-NEXT:    ret double undef
;
  %r = fmul double undef, undef
  ret double %r
}

define double @fdiv_undef_undef(double %x) {
; CHECK-LABEL: @fdiv_undef_undef(
; CHECK-NEXT:    ret double undef
;
  %r = fdiv double undef, undef
  ret double %r
}

define double @frem_undef_undef(double %x) {
; CHECK-LABEL: @frem_undef_undef(
; CHECK-NEXT:    ret double undef
;
  %r = frem double undef, undef
  ret double %r
}

; Constant folding.

define float @fadd_undef_op0_nnan_constant(float %x) {
; CHECK-LABEL: @fadd_undef_op0_nnan_constant(
; CHECK-NEXT:    ret float 0x7FF8000000000000
;
  %r = fadd nnan float undef, 1.0
  ret float %r
}

define float @fadd_undef_op1_constant(float %x) {
; CHECK-LABEL: @fadd_undef_op1_constant(
; CHECK-NEXT:    ret float 0x7FF8000000000000
;
  %r = fadd float 2.0, undef
  ret float %r
}

define float @fsub_undef_op0_fast_constant(float %x) {
; CHECK-LABEL: @fsub_undef_op0_fast_constant(
; CHECK-NEXT:    ret float 0x7FF8000000000000
;
  %r = fsub fast float undef, 3.0
  ret float %r
}

define float @fsub_undef_op1_constant(float %x) {
; CHECK-LABEL: @fsub_undef_op1_constant(
; CHECK-NEXT:    ret float 0x7FF8000000000000
;
  %r = fsub float 4.0, undef
  ret float %r
}

define float @fmul_undef_op0_nnan_constant(float %x) {
; CHECK-LABEL: @fmul_undef_op0_nnan_constant(
; CHECK-NEXT:    ret float 0x7FF8000000000000
;
  %r = fmul nnan float undef, 5.0
  ret float %r
}

define float @fmul_undef_op1_constant(float %x) {
; CHECK-LABEL: @fmul_undef_op1_constant(
; CHECK-NEXT:    ret float 0x7FF8000000000000
;
  %r = fmul float 6.0, undef
  ret float %r
}

define float @fdiv_undef_op0_fast_constant(float %x) {
; CHECK-LABEL: @fdiv_undef_op0_fast_constant(
; CHECK-NEXT:    ret float 0x7FF8000000000000
;
  %r = fdiv fast float undef, 7.0
  ret float %r
}

define float @fdiv_undef_op1_constant(float %x) {
; CHECK-LABEL: @fdiv_undef_op1_constant(
; CHECK-NEXT:    ret float 0x7FF8000000000000
;
  %r = fdiv float 8.0, undef
  ret float %r
}

define float @frem_undef_op0_nnan_constant(float %x) {
; CHECK-LABEL: @frem_undef_op0_nnan_constant(
; CHECK-NEXT:    ret float 0x7FF8000000000000
;
  %r = frem nnan float undef, 9.0
  ret float %r
}

define float @frem_undef_op1_constant(float %x) {
; CHECK-LABEL: @frem_undef_op1_constant(
; CHECK-NEXT:    ret float 0x7FF8000000000000
;
  %r = frem float 10.0, undef
  ret float %r
}

; Constant folding - special constants: 0.0.

define double @fadd_undef_op0_constant_0(double %x) {
; CHECK-LABEL: @fadd_undef_op0_constant_0(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = fadd double undef, 0x0000000000000000
  ret double %r
}

define double @fadd_undef_op1_constant_0(double %x) {
; CHECK-LABEL: @fadd_undef_op1_constant_0(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = fadd double 0x0000000000000000, undef
  ret double %r
}

define double @fsub_undef_op0_constant_0(double %x) {
; CHECK-LABEL: @fsub_undef_op0_constant_0(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = fsub double undef, 0x0000000000000000
  ret double %r
}

define double @fsub_undef_op1_constant_0(double %x) {
; CHECK-LABEL: @fsub_undef_op1_constant_0(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = fsub double 0x0000000000000000, undef
  ret double %r
}

define double @fmul_undef_op0_constant_0(double %x) {
; CHECK-LABEL: @fmul_undef_op0_constant_0(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = fmul double undef, 0x0000000000000000
  ret double %r
}

define double @fmul_undef_op1_constant_0(double %x) {
; CHECK-LABEL: @fmul_undef_op1_constant_0(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = fmul double 0x0000000000000000, undef
  ret double %r
}

define double @fdiv_undef_op0_constant_0(double %x) {
; CHECK-LABEL: @fdiv_undef_op0_constant_0(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = fdiv double undef, 0x0000000000000000
  ret double %r
}

define double @fdiv_undef_op1_constant_0(double %x) {
; CHECK-LABEL: @fdiv_undef_op1_constant_0(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = fdiv double 0x0000000000000000, undef
  ret double %r
}

define double @frem_undef_op0_constant_0(double %x) {
; CHECK-LABEL: @frem_undef_op0_constant_0(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = frem double undef, 0x0000000000000000
  ret double %r
}

define double @frem_undef_op1_constant_0(double %x) {
; CHECK-LABEL: @frem_undef_op1_constant_0(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = frem double 0x0000000000000000, undef
  ret double %r
}

; Constant folding - special constants: -0.0.

define double @fadd_undef_op0_constant_neg0(double %x) {
; CHECK-LABEL: @fadd_undef_op0_constant_neg0(
; CHECK-NEXT:    ret double undef
;
  %r = fadd double undef, 0x8000000000000000
  ret double %r
}

define double @fadd_undef_op1_constant_neg0(double %x) {
; CHECK-LABEL: @fadd_undef_op1_constant_neg0(
; CHECK-NEXT:    ret double undef
;
  %r = fadd double 0x8000000000000000, undef
  ret double %r
}

define double @fsub_undef_op0_constant_neg0(double %x) {
; CHECK-LABEL: @fsub_undef_op0_constant_neg0(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = fsub double undef, 0x8000000000000000
  ret double %r
}

define double @fsub_undef_op1_constant_neg0(double %x) {
; CHECK-LABEL: @fsub_undef_op1_constant_neg0(
; CHECK-NEXT:    ret double undef
;
  %r = fsub double 0x8000000000000000, undef
  ret double %r
}

define double @fmul_undef_op0_constant_neg0(double %x) {
; CHECK-LABEL: @fmul_undef_op0_constant_neg0(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = fmul double undef, 0x8000000000000000
  ret double %r
}

define double @fmul_undef_op1_constant_neg0(double %x) {
; CHECK-LABEL: @fmul_undef_op1_constant_neg0(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = fmul double 0x8000000000000000, undef
  ret double %r
}

define double @fdiv_undef_op0_constant_neg0(double %x) {
; CHECK-LABEL: @fdiv_undef_op0_constant_neg0(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = fdiv double undef, 0x8000000000000000
  ret double %r
}

define double @fdiv_undef_op1_constant_neg0(double %x) {
; CHECK-LABEL: @fdiv_undef_op1_constant_neg0(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = fdiv double 0x8000000000000000, undef
  ret double %r
}

define double @frem_undef_op0_constant_neg0(double %x) {
; CHECK-LABEL: @frem_undef_op0_constant_neg0(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = frem double undef, 0x8000000000000000
  ret double %r
}

define double @frem_undef_op1_constant_neg0(double %x) {
; CHECK-LABEL: @frem_undef_op1_constant_neg0(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = frem double 0x8000000000000000, undef
  ret double %r
}

; Constant folding - special constants: NaN.

define double @fadd_undef_op0_constant_nan(double %x) {
; CHECK-LABEL: @fadd_undef_op0_constant_nan(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = fadd double undef, 0x7FF8000000000000
  ret double %r
}

define double @fadd_undef_op1_fast_constant_nan(double %x) {
; CHECK-LABEL: @fadd_undef_op1_fast_constant_nan(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = fadd fast double 0xFFF0000000000001, undef
  ret double %r
}

define double @fsub_undef_op0_constant_nan(double %x) {
; CHECK-LABEL: @fsub_undef_op0_constant_nan(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = fsub double undef, 0xFFF8000000000010
  ret double %r
}

define double @fsub_undef_op1_nnan_constant_nan(double %x) {
; CHECK-LABEL: @fsub_undef_op1_nnan_constant_nan(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = fsub nnan double 0x7FF0000000000011, undef
  ret double %r
}

define double @fmul_undef_op0_constant_nan(double %x) {
; CHECK-LABEL: @fmul_undef_op0_constant_nan(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = fmul double undef, 0x7FF8000000000100
  ret double %r
}

define double @fmul_undef_op1_fast_constant_nan(double %x) {
; CHECK-LABEL: @fmul_undef_op1_fast_constant_nan(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = fmul fast double 0xFFF0000000000101, undef
  ret double %r
}

define double @fdiv_undef_op0_constant_nan(double %x) {
; CHECK-LABEL: @fdiv_undef_op0_constant_nan(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = fdiv double undef, 0xFFF8000000000110
  ret double %r
}

define double @fdiv_undef_op1_nnan_constant_nan(double %x) {
; CHECK-LABEL: @fdiv_undef_op1_nnan_constant_nan(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = fdiv nnan double 0x7FF0000000000111, undef
  ret double %r
}

define double @frem_undef_op0_constant_nan(double %x) {
; CHECK-LABEL: @frem_undef_op0_constant_nan(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = frem double undef, 0x7FF8000000001000
  ret double %r
}

define double @frem_undef_op1_fast_constant_nan(double %x) {
; CHECK-LABEL: @frem_undef_op1_fast_constant_nan(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = frem fast double 0xFFF0000000001001, undef
  ret double %r
}

; Constant folding - special constants: Inf.

define double @fadd_undef_op0_constant_inf(double %x) {
; CHECK-LABEL: @fadd_undef_op0_constant_inf(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = fadd double undef, 0x7FF0000000000000
  ret double %r
}

define double @fadd_undef_op1_fast_constant_inf(double %x) {
; CHECK-LABEL: @fadd_undef_op1_fast_constant_inf(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = fadd fast double 0xFFF0000000000000, undef
  ret double %r
}

define double @fsub_undef_op0_constant_inf(double %x) {
; CHECK-LABEL: @fsub_undef_op0_constant_inf(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = fsub double undef, 0xFFF0000000000000
  ret double %r
}

define double @fsub_undef_op1_ninf_constant_inf(double %x) {
; CHECK-LABEL: @fsub_undef_op1_ninf_constant_inf(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = fsub ninf double 0x7FF0000000000000, undef
  ret double %r
}

define double @fmul_undef_op0_constant_inf(double %x) {
; CHECK-LABEL: @fmul_undef_op0_constant_inf(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = fmul double undef, 0x7FF0000000000000
  ret double %r
}

define double @fmul_undef_op1_fast_constant_inf(double %x) {
; CHECK-LABEL: @fmul_undef_op1_fast_constant_inf(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = fmul fast double 0xFFF0000000000000, undef
  ret double %r
}

define double @fdiv_undef_op0_constant_inf(double %x) {
; CHECK-LABEL: @fdiv_undef_op0_constant_inf(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = fdiv double undef, 0xFFF0000000000000
  ret double %r
}

define double @fdiv_undef_op1_ninf_constant_inf(double %x) {
; CHECK-LABEL: @fdiv_undef_op1_ninf_constant_inf(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = fdiv ninf double 0x7FF0000000000000, undef
  ret double %r
}

define double @frem_undef_op0_constant_inf(double %x) {
; CHECK-LABEL: @frem_undef_op0_constant_inf(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = frem double undef, 0x7FF0000000000000
  ret double %r
}

define double @frem_undef_op1_fast_constant_inf(double %x) {
; CHECK-LABEL: @frem_undef_op1_fast_constant_inf(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %r = frem fast double 0xFFF0000000000000, undef
  ret double %r
}

define <2 x double> @fadd_undef_op1_constant_vec(<2 x double> %x) {
; CHECK-LABEL: @fadd_undef_op1_constant_vec(
; CHECK-NEXT:    ret <2 x double> <double 0x7FF8000000000000, double undef>
;
  %r = fadd <2 x double> <double 42.0, double undef>, undef
  ret <2 x double> %r
}

define <2 x double> @fadd_undef_op0_constant_vec(<2 x double> %x) {
; CHECK-LABEL: @fadd_undef_op0_constant_vec(
; CHECK-NEXT:    ret <2 x double> <double undef, double 0x7FF8000000000000>
;
  %r = fadd <2 x double> undef, <double undef, double 42.0>
  ret <2 x double> %r
}

define <2 x double> @fsub_undef_op1_constant_vec(<2 x double> %x) {
; CHECK-LABEL: @fsub_undef_op1_constant_vec(
; CHECK-NEXT:    ret <2 x double> <double undef, double 0x7FF8000000000000>
;
  %r = fsub <2 x double> <double undef, double 42.0>, undef
  ret <2 x double> %r
}

define <2 x double> @fsub_undef_op0_constant_vec(<2 x double> %x) {
; CHECK-LABEL: @fsub_undef_op0_constant_vec(
; CHECK-NEXT:    ret <2 x double> <double 0x7FF8000000000000, double undef>
;
  %r = fsub <2 x double> undef, <double 42.0, double undef>
  ret <2 x double> %r
}

define <2 x double> @fmul_undef_op1_constant_vec(<2 x double> %x) {
; CHECK-LABEL: @fmul_undef_op1_constant_vec(
; CHECK-NEXT:    ret <2 x double> <double 0x7FF8000000000000, double undef>
;
  %r = fmul <2 x double> <double 42.0, double undef>, undef
  ret <2 x double> %r
}

define <2 x double> @fmul_undef_op0_constant_vec(<2 x double> %x) {
; CHECK-LABEL: @fmul_undef_op0_constant_vec(
; CHECK-NEXT:    ret <2 x double> <double undef, double 0x7FF8000000000000>
;
  %r = fmul <2 x double> undef, <double undef, double 42.0>
  ret <2 x double> %r
}

define <2 x double> @fdiv_undef_op1_constant_vec(<2 x double> %x) {
; CHECK-LABEL: @fdiv_undef_op1_constant_vec(
; CHECK-NEXT:    ret <2 x double> <double 0x7FF8000000000000, double undef>
;
  %r = fdiv <2 x double> <double 42.0, double undef>, undef
  ret <2 x double> %r
}

define <2 x double> @fdiv_undef_op0_constant_vec(<2 x double> %x) {
; CHECK-LABEL: @fdiv_undef_op0_constant_vec(
; CHECK-NEXT:    ret <2 x double> <double undef, double 0x7FF8000000000000>
;
  %r = fdiv <2 x double> undef, <double undef, double 42.0>
  ret <2 x double> %r
}

define <2 x double> @frem_undef_op1_constant_vec(<2 x double> %x) {
; CHECK-LABEL: @frem_undef_op1_constant_vec(
; CHECK-NEXT:    ret <2 x double> <double undef, double 0x7FF8000000000000>
;
  %r = frem <2 x double> <double undef, double 42.0>, undef
  ret <2 x double> %r
}

define <2 x double> @frem_undef_op0_constant_vec(<2 x double> %x) {
; CHECK-LABEL: @frem_undef_op0_constant_vec(
; CHECK-NEXT:    ret <2 x double> <double 0x7FF8000000000000, double undef>
;
  %r = frem <2 x double> undef, <double 42.0, double undef>
  ret <2 x double> %r
}

define <2 x double> @maximum_nan_op0_vec_partial_undef_op1_undef(<2 x double> %x) {
; CHECK-LABEL: @maximum_nan_op0_vec_partial_undef_op1_undef(
; CHECK-NEXT:    ret <2 x double> <double 0x7FF8000000000000, double 0x7FF8000000000000>
;
  %r = call <2 x double> @llvm.maximum.v2f64(<2 x double> <double 0x7ff8000000000000, double undef>, <2 x double> undef)
  ret <2 x double> %r
}

define <2 x double> @maximum_nan_op1_vec_partial_undef_op0_undef(<2 x double> %x) {
; CHECK-LABEL: @maximum_nan_op1_vec_partial_undef_op0_undef(
; CHECK-NEXT:    ret <2 x double> <double 0x7FF8000000000000, double undef>
;
  %r = call <2 x double> @llvm.maximum.v2f64(<2 x double> undef, <2 x double> <double 0x7ff8000000000000, double undef>)
  ret <2 x double> %r
}

define <2 x double> @minimum_nan_op0_vec_partial_undef_op1_undef(<2 x double> %x) {
; CHECK-LABEL: @minimum_nan_op0_vec_partial_undef_op1_undef(
; CHECK-NEXT:    ret <2 x double> <double 0x7FF8000000000000, double 0x7FF8000000000000>
;
  %r = call <2 x double> @llvm.minimum.v2f64(<2 x double> <double 0x7ff8000000000000, double undef>, <2 x double> undef)
  ret <2 x double> %r
}

define <2 x double> @minimum_nan_op1_vec_partial_undef_op0_undef(<2 x double> %x) {
; CHECK-LABEL: @minimum_nan_op1_vec_partial_undef_op0_undef(
; CHECK-NEXT:    ret <2 x double> <double 0x7FF8000000000000, double undef>
;
  %r = call <2 x double> @llvm.minimum.v2f64(<2 x double> undef, <2 x double> <double 0x7ff8000000000000, double undef>)
  ret <2 x double> %r
}

define <2 x double> @maxnum_nan_op0_vec_partial_undef_op1_undef(<2 x double> %x) {
; CHECK-LABEL: @maxnum_nan_op0_vec_partial_undef_op1_undef(
; CHECK-NEXT:    ret <2 x double> undef
;
  %r = call <2 x double> @llvm.maxnum.v2f64(<2 x double> <double 0x7ff8000000000000, double undef>, <2 x double> undef)
  ret <2 x double> %r
}

define <2 x double> @maxnum_nan_op1_vec_partial_undef_op0_undef(<2 x double> %x) {
; CHECK-LABEL: @maxnum_nan_op1_vec_partial_undef_op0_undef(
; CHECK-NEXT:    ret <2 x double> <double 0x7FF8000000000000, double undef>
;
  %r = call <2 x double> @llvm.maxnum.v2f64(<2 x double> undef, <2 x double> <double 0x7ff8000000000000, double undef>)
  ret <2 x double> %r
}

define <2 x double> @minnum_nan_op0_vec_partial_undef_op1_undef(<2 x double> %x) {
; CHECK-LABEL: @minnum_nan_op0_vec_partial_undef_op1_undef(
; CHECK-NEXT:    ret <2 x double> undef
;
  %r = call <2 x double> @llvm.minnum.v2f64(<2 x double> <double 0x7ff8000000000000, double undef>, <2 x double> undef)
  ret <2 x double> %r
}

define <2 x double> @minnum_nan_op1_vec_partial_undef_op0_undef(<2 x double> %x) {
; CHECK-LABEL: @minnum_nan_op1_vec_partial_undef_op0_undef(
; CHECK-NEXT:    ret <2 x double> <double 0x7FF8000000000000, double undef>
;
  %r = call <2 x double> @llvm.minnum.v2f64(<2 x double> undef, <2 x double> <double 0x7ff8000000000000, double undef>)
  ret <2 x double> %r
}
