; ModuleID = 'flip.bc'

@.str = private unnamed_addr constant [18 x i8] c"hello world - %d\0A\00", align 1

declare i32 @printf(i8*, ...)
declare i32* @fopen(i8*, i8*)


%ort = type i8*
%func2 = type { %ort, %ort }
%func3 = type { %ort, %ort, %ort }

define i32 @main() nounwind {
; TODO: Setup GC
; TODO: Handle calling curried functions generically.

  %arg1 = alloca i32
  %arg2 = alloca i32
  store i32 1, i32* %arg1
  store i32 2, i32* %arg2
  
  %1 = bitcast i32* %arg1 to %ort
  %2 = bitcast i32* %arg2 to %ort
  
  %3 = call %ort @testFunc(%ort %1, %ort %2)
  
  %4 = tail call %func3 @flip(%ort (%ort, %ort)* @testFunc)
  %5 = tail call %func3 @flip1(%func3 %4, %ort %1)
  %6 = tail call %ort @flip2(%func3 %5, %ort %2)
  
  ret i32 0
}

define %ort @testFunc(%ort %xArg, %ort %yArg) nounwind {
  %1 = bitcast %ort %xArg to i32*
  %2 = bitcast %ort %yArg to i32*
  %x = load i32* %1
  %y = load i32* %2

  %3 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str, i32 0, i32 0), i32 %x)
  %4 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str, i32 0, i32 0), i32 %y)
  ret %ort %xArg
}

define %func3 @flip(%ort (%ort, %ort)* %f) {
  %1 = bitcast %ort (%ort, %ort)* %f to %ort
  %2 = insertvalue %func3 undef, %ort %1, 0
  ret %func3 %2
}

define %func3 @flip1(%func3 %struct, %ort %arg) {
    %1 = insertvalue %func3 %struct, %ort %arg, 1
	ret %func3 %1
}

define %ort @flip2(%func3 %struct, %ort %arg) {
	%1 = insertvalue %func3 %struct, %ort %arg, 2
	
	%2 = extractvalue %func3 %1, 0
	%f = bitcast %ort %2 to %ort (%ort, %ort)*
	%x = extractvalue %func3 %1, 1
	%y = extractvalue %func3 %1, 2
	
	%ret = tail call %ort %f(%ort %y, %ort %x)
	ret %ort %ret
}
