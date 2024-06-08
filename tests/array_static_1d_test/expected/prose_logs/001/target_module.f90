MODULE target_module
IMPLICIT NONE
public target_subroutine_wrapper_g_to_a
INTERFACE target_subroutine_wrapper_g_to_a
MODULE PROCEDURE target_subroutine_wrapper_g_to_a
END INTERFACE 
CONTAINS
SUBROUTINE target_subroutine(result)
REAL(kind=4) :: c0 = 3.0
REAL(kind=4) :: b0 = 2.0
REAL(kind=4) :: a0 = 1.0
REAL(kind=4) :: c1 = 6.0
REAL(kind=4) :: b1 = 5.0
REAL(kind=4) :: a1 = 4.0
REAL(kind=10) :: result
REAL(kind=4), DIMENSION(3) :: array
array(1) = a0 + a1
array(2) = b0 + b1
array(3) = c0 + c1
result = array(1) + array(2) + array(3)
END SUBROUTINE 

SUBROUTINE target_subroutine_wrapper_g_to_a(result)
REAL(kind=16) :: result
REAL(kind=10) :: result_temp
result_temp = result
CALL target_subroutine(result=result_temp)
result = result_temp
END SUBROUTINE 

END MODULE target_module

