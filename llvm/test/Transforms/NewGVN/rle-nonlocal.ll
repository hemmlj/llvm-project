; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -basic-aa -newgvn -S | FileCheck %s

define i32 @main(i32** %p, i32 %x, i32 %y) {
; CHECK-LABEL: @main(
; CHECK-NEXT:  block1:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[BLOCK2:%.*]], label [[BLOCK3:%.*]]
; CHECK:       block2:
; CHECK-NEXT:    [[A:%.*]] = load i32*, i32** [[P:%.*]]
; CHECK-NEXT:    br label [[BLOCK4:%.*]]
; CHECK:       block3:
; CHECK-NEXT:    [[B:%.*]] = load i32*, i32** [[P]]
; CHECK-NEXT:    br label [[BLOCK4]]
; CHECK:       block4:
; CHECK-NEXT:    [[EXISTINGPHI:%.*]] = phi i32* [ [[A]], [[BLOCK2]] ], [ [[B]], [[BLOCK3]] ]
; CHECK-NEXT:    [[C:%.*]] = load i32, i32* [[EXISTINGPHI]]
; CHECK-NEXT:    [[E:%.*]] = add i32 [[C]], [[C]]
; CHECK-NEXT:    ret i32 [[E]]
;
block1:
  %cmp = icmp eq i32 %x, %y
  br i1 %cmp , label %block2, label %block3

block2:
  %a = load i32*, i32** %p
  br label %block4

block3:
  %b = load i32*, i32** %p
  br label %block4

block4:
  %existingPHI = phi i32* [ %a, %block2 ], [ %b, %block3 ]
  %DEAD = load i32*, i32** %p
  %c = load i32, i32* %DEAD
  %d = load i32, i32* %existingPHI
  %e = add i32 %c, %d
  ret i32 %e
}
