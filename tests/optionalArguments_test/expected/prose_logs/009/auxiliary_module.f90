MODULE auxiliary_module
IMPLICIT NONE
public right_wrapper_44g_to_88g
INTERFACE right_wrapper_44g_to_88g
MODULE PROCEDURE right_wrapper_44g_to_88g
END INTERFACE 
public right_wrapper_48x_to_88g
INTERFACE right_wrapper_48x_to_88g
MODULE PROCEDURE right_wrapper_48x_to_88g
END INTERFACE 
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

SUBROUTINE right_wrapper_48x_to_88g(result,op2_in)
REAL(kind=4), INTENT(INOUT) :: result
REAL(kind=8) :: result_temp
REAL(kind=8), INTENT(IN), OPTIONAL :: op2_in
result_temp = result
CALL right(result=result_temp,op2_in=op2_in)
result = result_temp
END SUBROUTINE 

SUBROUTINE right_wrapper_44g_to_88g(result,op1_in,op2_in)
REAL(kind=4), INTENT(INOUT) :: result
REAL(kind=8) :: result_temp
REAL(kind=4), INTENT(IN), OPTIONAL :: op2_in
REAL(kind=8), POINTER :: op2_in_temp
REAL(kind=16), INTENT(IN), OPTIONAL :: op1_in
IF (PRESENT(op2_in)) THEN
allocate( op2_in_temp )
op2_in_temp = op2_in
ELSE
op2_in_temp => NULL()
END IF
result_temp = result
CALL right(result=result_temp,op1_in=op1_in,op2_in=op2_in_temp)
IF (PRESENT(op2_in)) THEN
deallocate( op2_in_temp )
END IF
result = result_temp
END SUBROUTINE 

END MODULE auxiliary_module

