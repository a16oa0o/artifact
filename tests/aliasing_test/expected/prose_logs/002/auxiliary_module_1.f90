MODULE auxiliary_module_1
IMPLICIT NONE
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

END MODULE auxiliary_module_1

