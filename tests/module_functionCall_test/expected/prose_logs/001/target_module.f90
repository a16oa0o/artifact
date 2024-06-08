MODULE target_module
IMPLICIT NONE
public target_subroutine_wrapper_g_to_a
INTERFACE target_subroutine_wrapper_g_to_a
MODULE PROCEDURE target_subroutine_wrapper_g_to_a
END INTERFACE 
REAL(kind=4) :: c0
REAL(kind=4) :: b0
REAL(kind=4) :: a0
REAL(kind=4), DIMENSION(3,2) :: array = reshape((/1.0_4,2.0_4,3.0_4,4.0_4,5.0_4,6.0_4/),(shape(array)),order=(/2,1/))
CONTAINS
SUBROUTINE target_subroutine(result)
REAL(kind=10) :: result
a0 = array(1,1) + array(1,2)
b0 = array(2,1) + array(2,2)
c0 = array(3,1) + array(3,2)
result = a0 + b0 + c0
END SUBROUTINE 

SUBROUTINE target_subroutine_wrapper_g_to_a(result)
REAL(kind=16) :: result
REAL(kind=10) :: result_temp
result_temp = result
CALL target_subroutine(result=result_temp)
result = result_temp
END SUBROUTINE 

END MODULE target_module

