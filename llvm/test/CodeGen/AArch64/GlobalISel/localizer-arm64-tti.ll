; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -o - -verify-machineinstrs -O0 -global-isel -stop-after=localizer %s | FileCheck %s
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-ios5.0.0"

@var1 = common global i32 0, align 4
@var2 = common global i32 0, align 4
@var3 = common global i32 0, align 4
@var4 = common global i32 0, align 4

; This is an ll test instead of MIR because -run-pass doesn't seem to support
; initializing the target TTI which we need for this test.

; Some of the instructions in entry block are dead after this pass so don't
; strictly need to be checked for.

define i32 @foo() {
  ; CHECK-LABEL: name: foo
  ; CHECK: bb.1.entry:
  ; CHECK:   successors: %bb.2(0x40000000), %bb.3(0x40000000)
  ; CHECK:   [[GV:%[0-9]+]]:gpr(p0) = G_GLOBAL_VALUE @var1
  ; CHECK:   [[C:%[0-9]+]]:gpr(s32) = G_CONSTANT i32 2
  ; CHECK:   [[GV1:%[0-9]+]]:gpr(p0) = G_GLOBAL_VALUE @var2
  ; CHECK:   [[C1:%[0-9]+]]:gpr(s32) = G_CONSTANT i32 3
  ; CHECK:   [[GV2:%[0-9]+]]:gpr(p0) = G_GLOBAL_VALUE @var3
  ; CHECK:   [[C2:%[0-9]+]]:gpr(s32) = G_CONSTANT i32 0
  ; CHECK:   [[LOAD:%[0-9]+]]:gpr(s32) = G_LOAD [[GV]](p0) :: (load 4 from @var1)
  ; CHECK:   [[C3:%[0-9]+]]:gpr(s32) = G_CONSTANT i32 1
  ; CHECK:   [[ICMP:%[0-9]+]]:gpr(s32) = G_ICMP intpred(ne), [[LOAD]](s32), [[C3]]
  ; CHECK:   [[TRUNC:%[0-9]+]]:gpr(s1) = G_TRUNC [[ICMP]](s32)
  ; CHECK:   G_BRCOND [[TRUNC]](s1), %bb.3
  ; CHECK: bb.2.if.then:
  ; CHECK:   successors: %bb.3(0x80000000)
  ; CHECK:   [[GV3:%[0-9]+]]:gpr(p0) = G_GLOBAL_VALUE @var2
  ; CHECK:   [[C4:%[0-9]+]]:gpr(s32) = G_CONSTANT i32 2
  ; CHECK:   G_STORE [[C4]](s32), [[GV3]](p0) :: (store 4 into @var2)
  ; CHECK:   [[C5:%[0-9]+]]:gpr(s32) = G_CONSTANT i32 3
  ; CHECK:   G_STORE [[C5]](s32), [[GV]](p0) :: (store 4 into @var1)
  ; CHECK:   [[GV4:%[0-9]+]]:gpr(p0) = G_GLOBAL_VALUE @var3
  ; CHECK:   G_STORE [[C4]](s32), [[GV4]](p0) :: (store 4 into @var3)
  ; CHECK:   G_STORE [[C5]](s32), [[GV]](p0) :: (store 4 into @var1)
  ; CHECK: bb.3.if.end:
  ; CHECK:   [[C6:%[0-9]+]]:gpr(s32) = G_CONSTANT i32 0
  ; CHECK:   $w0 = COPY [[C6]](s32)
  ; CHECK:   RET_ReallyLR implicit $w0
entry:
  %0 = load i32, i32* @var1, align 4
  %cmp = icmp eq i32 %0, 1
  br i1 %cmp, label %if.then, label %if.end

if.then:
  store i32 2, i32* @var2, align 4
  store i32 3, i32* @var1, align 4
  store i32 2, i32* @var3, align 4
  store i32 3, i32* @var1, align 4
  br label %if.end

if.end:
  ret i32 0
}

