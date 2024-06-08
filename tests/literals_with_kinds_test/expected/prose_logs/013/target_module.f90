MODULE target_module
IMPLICIT NONE
public target_subroutine_wrapper_g_to_8
INTERFACE target_subroutine_wrapper_g_to_8
MODULE PROCEDURE target_subroutine_wrapper_g_to_8
END INTERFACE 
CONTAINS
SUBROUTINE target_subroutine(result)
REAL(kind=4) :: a0 = 1.0
REAL(kind=8) :: a1 = 4.0
REAL(kind=8) :: a2
REAL(kind=8) :: result
a2 = a0 + a1
result = a2 + sign(2.718_8,a2) + 2.718_8 + 2.718_8 + 2.718_8
END SUBROUTINE 

SUBROUTINE target_subroutine_wrapper_g_to_8(result)
REAL(kind=16) :: result
REAL(kind=8) :: result_temp
result_temp = result
CALL target_subroutine(result=result_temp)
result = result_temp
END SUBROUTINE 

END MODULE target_module

