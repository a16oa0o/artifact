MODULE auxiliary_module
IMPLICIT NONE
public foo
INTERFACE foo
MODULE PROCEDURE right
MODULE PROCEDURE wrong
END INTERFACE 
CONTAINS
SUBROUTINE right(result,op1_in,op2_in)
REAL(kind=8), INTENT(INOUT) :: result
REAL(kind=8), INTENT(IN), OPTIONAL :: op2_in
REAL(kind=16), INTENT(IN), OPTIONAL :: op1_in
REAL(kind=16) :: op1
REAL(kind=8) :: op2
IF (present(op2_in)) THEN
op2 = op2_in
ELSE
op2 = 3.14159_8
END IF
IF (present(op1_in)) THEN
op1 = op1_in
ELSE
op1 = 2.718281828459045235360_16
END IF
result = result + op1 + op2
END SUBROUTINE 

SUBROUTINE wrong(result)
REAL(kind=16) :: result
result = 0.0_16
END SUBROUTINE 

END MODULE auxiliary_module

