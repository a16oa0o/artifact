MODULE target_module
IMPLICIT NONE
public target_subroutine_wrapper_g_to_a
INTERFACE target_subroutine_wrapper_g_to_a
MODULE PROCEDURE target_subroutine_wrapper_g_to_a
END INTERFACE 
CONTAINS
SUBROUTINE target_subroutine(result)
REAL(kind=4) :: a0 = 1.0
REAL(kind=4) :: a1 = 4.0
REAL(kind=4) :: a2
REAL(kind=10) :: result
a2 = a0 + a1
result = a2 + sign(2.718_4,a2) + 2.718_4 + 2.718_4 + 2.718_4
END SUBROUTINE 

SUBROUTINE target_subroutine_wrapper_g_to_a(result)
REAL(kind=16) :: result
REAL(kind=10) :: result_temp
result_temp = result
CALL target_subroutine(result=result_temp)
result = result_temp
END SUBROUTINE 

END MODULE target_module

