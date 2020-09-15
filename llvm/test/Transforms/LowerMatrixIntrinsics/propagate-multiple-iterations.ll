; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -lower-matrix-intrinsics -S < %s | FileCheck %s
; RUN: opt -passes='lower-matrix-intrinsics' -S < %s | FileCheck %s


; Make sure we propagate in multiple iterations. First, we back-propagate the
; shape information from the transpose to %A, in the next iteration we
; forward-propagate it to %Mul, and then back to %B.
define <16 x double> @backpropagation_iterations(<16 x double>* %A.Ptr, <16 x double>* %B.Ptr) {
; CHECK-LABEL: @backpropagation_iterations(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <16 x double>* [[A_PTR:%.*]] to double*
; CHECK-NEXT:    [[VEC_CAST:%.*]] = bitcast double* [[TMP1]] to <4 x double>*
; CHECK-NEXT:    [[COL_LOAD:%.*]] = load <4 x double>, <4 x double>* [[VEC_CAST]], align 8
; CHECK-NEXT:    [[VEC_GEP:%.*]] = getelementptr double, double* [[TMP1]], i64 4
; CHECK-NEXT:    [[VEC_CAST1:%.*]] = bitcast double* [[VEC_GEP]] to <4 x double>*
; CHECK-NEXT:    [[COL_LOAD2:%.*]] = load <4 x double>, <4 x double>* [[VEC_CAST1]], align 8
; CHECK-NEXT:    [[VEC_GEP3:%.*]] = getelementptr double, double* [[TMP1]], i64 8
; CHECK-NEXT:    [[VEC_CAST4:%.*]] = bitcast double* [[VEC_GEP3]] to <4 x double>*
; CHECK-NEXT:    [[COL_LOAD5:%.*]] = load <4 x double>, <4 x double>* [[VEC_CAST4]], align 8
; CHECK-NEXT:    [[VEC_GEP6:%.*]] = getelementptr double, double* [[TMP1]], i64 12
; CHECK-NEXT:    [[VEC_CAST7:%.*]] = bitcast double* [[VEC_GEP6]] to <4 x double>*
; CHECK-NEXT:    [[COL_LOAD8:%.*]] = load <4 x double>, <4 x double>* [[VEC_CAST7]], align 8
; CHECK-NEXT:    [[TMP2:%.*]] = extractelement <4 x double> [[COL_LOAD]], i64 0
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <4 x double> undef, double [[TMP2]], i64 0
; CHECK-NEXT:    [[TMP4:%.*]] = extractelement <4 x double> [[COL_LOAD2]], i64 0
; CHECK-NEXT:    [[TMP5:%.*]] = insertelement <4 x double> [[TMP3]], double [[TMP4]], i64 1
; CHECK-NEXT:    [[TMP6:%.*]] = extractelement <4 x double> [[COL_LOAD5]], i64 0
; CHECK-NEXT:    [[TMP7:%.*]] = insertelement <4 x double> [[TMP5]], double [[TMP6]], i64 2
; CHECK-NEXT:    [[TMP8:%.*]] = extractelement <4 x double> [[COL_LOAD8]], i64 0
; CHECK-NEXT:    [[TMP9:%.*]] = insertelement <4 x double> [[TMP7]], double [[TMP8]], i64 3
; CHECK-NEXT:    [[TMP10:%.*]] = extractelement <4 x double> [[COL_LOAD]], i64 1
; CHECK-NEXT:    [[TMP11:%.*]] = insertelement <4 x double> undef, double [[TMP10]], i64 0
; CHECK-NEXT:    [[TMP12:%.*]] = extractelement <4 x double> [[COL_LOAD2]], i64 1
; CHECK-NEXT:    [[TMP13:%.*]] = insertelement <4 x double> [[TMP11]], double [[TMP12]], i64 1
; CHECK-NEXT:    [[TMP14:%.*]] = extractelement <4 x double> [[COL_LOAD5]], i64 1
; CHECK-NEXT:    [[TMP15:%.*]] = insertelement <4 x double> [[TMP13]], double [[TMP14]], i64 2
; CHECK-NEXT:    [[TMP16:%.*]] = extractelement <4 x double> [[COL_LOAD8]], i64 1
; CHECK-NEXT:    [[TMP17:%.*]] = insertelement <4 x double> [[TMP15]], double [[TMP16]], i64 3
; CHECK-NEXT:    [[TMP18:%.*]] = extractelement <4 x double> [[COL_LOAD]], i64 2
; CHECK-NEXT:    [[TMP19:%.*]] = insertelement <4 x double> undef, double [[TMP18]], i64 0
; CHECK-NEXT:    [[TMP20:%.*]] = extractelement <4 x double> [[COL_LOAD2]], i64 2
; CHECK-NEXT:    [[TMP21:%.*]] = insertelement <4 x double> [[TMP19]], double [[TMP20]], i64 1
; CHECK-NEXT:    [[TMP22:%.*]] = extractelement <4 x double> [[COL_LOAD5]], i64 2
; CHECK-NEXT:    [[TMP23:%.*]] = insertelement <4 x double> [[TMP21]], double [[TMP22]], i64 2
; CHECK-NEXT:    [[TMP24:%.*]] = extractelement <4 x double> [[COL_LOAD8]], i64 2
; CHECK-NEXT:    [[TMP25:%.*]] = insertelement <4 x double> [[TMP23]], double [[TMP24]], i64 3
; CHECK-NEXT:    [[TMP26:%.*]] = extractelement <4 x double> [[COL_LOAD]], i64 3
; CHECK-NEXT:    [[TMP27:%.*]] = insertelement <4 x double> undef, double [[TMP26]], i64 0
; CHECK-NEXT:    [[TMP28:%.*]] = extractelement <4 x double> [[COL_LOAD2]], i64 3
; CHECK-NEXT:    [[TMP29:%.*]] = insertelement <4 x double> [[TMP27]], double [[TMP28]], i64 1
; CHECK-NEXT:    [[TMP30:%.*]] = extractelement <4 x double> [[COL_LOAD5]], i64 3
; CHECK-NEXT:    [[TMP31:%.*]] = insertelement <4 x double> [[TMP29]], double [[TMP30]], i64 2
; CHECK-NEXT:    [[TMP32:%.*]] = extractelement <4 x double> [[COL_LOAD8]], i64 3
; CHECK-NEXT:    [[TMP33:%.*]] = insertelement <4 x double> [[TMP31]], double [[TMP32]], i64 3
; CHECK-NEXT:    [[TMP34:%.*]] = bitcast <16 x double>* [[B_PTR:%.*]] to double*
; CHECK-NEXT:    [[VEC_CAST9:%.*]] = bitcast double* [[TMP34]] to <4 x double>*
; CHECK-NEXT:    [[COL_LOAD10:%.*]] = load <4 x double>, <4 x double>* [[VEC_CAST9]], align 8
; CHECK-NEXT:    [[VEC_GEP11:%.*]] = getelementptr double, double* [[TMP34]], i64 4
; CHECK-NEXT:    [[VEC_CAST12:%.*]] = bitcast double* [[VEC_GEP11]] to <4 x double>*
; CHECK-NEXT:    [[COL_LOAD13:%.*]] = load <4 x double>, <4 x double>* [[VEC_CAST12]], align 8
; CHECK-NEXT:    [[VEC_GEP14:%.*]] = getelementptr double, double* [[TMP34]], i64 8
; CHECK-NEXT:    [[VEC_CAST15:%.*]] = bitcast double* [[VEC_GEP14]] to <4 x double>*
; CHECK-NEXT:    [[COL_LOAD16:%.*]] = load <4 x double>, <4 x double>* [[VEC_CAST15]], align 8
; CHECK-NEXT:    [[VEC_GEP17:%.*]] = getelementptr double, double* [[TMP34]], i64 12
; CHECK-NEXT:    [[VEC_CAST18:%.*]] = bitcast double* [[VEC_GEP17]] to <4 x double>*
; CHECK-NEXT:    [[COL_LOAD19:%.*]] = load <4 x double>, <4 x double>* [[VEC_CAST18]], align 8
; CHECK-NEXT:    [[TMP35:%.*]] = fmul <4 x double> [[COL_LOAD]], [[COL_LOAD10]]
; CHECK-NEXT:    [[TMP36:%.*]] = fmul <4 x double> [[COL_LOAD2]], [[COL_LOAD13]]
; CHECK-NEXT:    [[TMP37:%.*]] = fmul <4 x double> [[COL_LOAD5]], [[COL_LOAD16]]
; CHECK-NEXT:    [[TMP38:%.*]] = fmul <4 x double> [[COL_LOAD8]], [[COL_LOAD19]]
; CHECK-NEXT:    [[TMP39:%.*]] = shufflevector <4 x double> [[TMP35]], <4 x double> [[TMP36]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    [[TMP40:%.*]] = shufflevector <4 x double> [[TMP37]], <4 x double> [[TMP38]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    [[TMP41:%.*]] = shufflevector <8 x double> [[TMP39]], <8 x double> [[TMP40]], <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
; CHECK-NEXT:    ret <16 x double> [[TMP41]]
;
  %A = load <16 x double>, <16 x double>* %A.Ptr, align 8
  %A.trans = tail call <16 x double> @llvm.matrix.transpose.v16f64(<16 x double> %A, i32 4, i32 4)
  %B = load <16 x double>, <16 x double>* %B.Ptr, align 8
  %Mul = fmul <16 x double> %A, %B
  ret <16 x double> %Mul
}

declare <16 x double> @llvm.matrix.multiply.v16f64.v16f64.v16f64(<16 x double>, <16 x double>, i32 immarg, i32 immarg, i32 immarg)
declare <16 x double> @llvm.matrix.transpose.v16f64(<16 x double>, i32 immarg, i32 immarg)
