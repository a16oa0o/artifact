MODULE target_module
IMPLICIT NONE
public target_subroutine_wrapper_g_to_a
INTERFACE target_subroutine_wrapper_g_to_a
MODULE PROCEDURE target_subroutine_wrapper_g_to_a
END INTERFACE 
REAL(kind=4) :: c1 = 6.0
REAL(kind=4) :: b1 = 5.0
REAL(kind=4) :: a1 = 4.0
REAL(kind=4) :: c0 = 3.0
REAL(kind=4) :: b0 = 2.0
REAL(kind=4) :: a0 = 1.0
CONTAINS
SUBROUTINE target_subroutine(result)
REAL(kind=4) :: c2
REAL(kind=4) :: b2
REAL(kind=4) :: a2
REAL(kind=10) :: result
INTEGER :: i
a2 = a0 + a1
b2 = b0 + b1
c2 = c0 + c1
DO i = 0, 10
result = result + a2 + b2 + c2
END DO
END SUBROUTINE 

SUBROUTINE target_subroutine_wrapper_g_to_a(result)
REAL(kind=16) :: result
REAL(kind=10) :: result_temp
result_temp = result
CALL target_subroutine(result=result_temp)
result = result_temp
END SUBROUTINE 

END MODULE target_module

