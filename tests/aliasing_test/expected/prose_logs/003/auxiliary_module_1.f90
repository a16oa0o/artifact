MODULE auxiliary_module_1
IMPLICIT NONE
public foo_wrapper_4_to_8
INTERFACE foo_wrapper_4_to_8
MODULE PROCEDURE foo_wrapper_4_to_8
END INTERFACE 
private 
public foo
CONTAINS
 FUNCTION foo(x)
REAL(kind=8) :: x
INTEGER :: foo
IF (x > 0.0_8) THEN
foo = 1
ELSE
foo = - 1
END IF
END  FUNCTION 

INTEGER FUNCTION foo_wrapper_4_to_8(x) result(returnValue)
REAL(kind=4) :: x
REAL(kind=8) :: x_temp
x_temp = x
returnValue = foo(x=x_temp)
x = x_temp
END  FUNCTION 

END MODULE auxiliary_module_1

