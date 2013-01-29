; ModuleID = 'hello.bc'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S32"
target triple = "i386-pc-cygwin"

@.str = private unnamed_addr constant [18 x i8] c"hello world - %d\0A\00", align 1

define i32 @testFunc(i32 %x, i32 %y) nounwind {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 %x, i32* %1, align 4
  store i32 %y, i32* %2, align 4
  %3 = load i32* %1, align 4
  %4 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str, i32 0, i32 0), i32 %3)
  %5 = load i32* %2, align 4
  %6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str, i32 0, i32 0), i32 %5)
  %7 = load i32* %1, align 4
  %8 = load i32* %2, align 4
  %9 = add nsw i32 %7, %8
  ret i32 %9
}

declare i32 @printf(i8*, ...)

define i32 @main() nounwind {
  %1 = alloca i32, align 4
  store i32 0, i32* %1
  %2 = call i32 @testFunc(i32 1, i32 2)
  ret i32 0
}
