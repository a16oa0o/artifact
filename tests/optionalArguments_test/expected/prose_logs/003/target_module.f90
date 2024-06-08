MODULE target_module
USE auxiliary_module, ONLY : right_wrapper_4xx_to_88g
USE auxiliary_module, ONLY : right_wrapper_88a_to_88g
USE auxiliary_module, ONLY : right_wrapper_84a_to_88g
USE auxiliary_module, ONLY : right_wrapper_4xx_to_88g
USE auxiliary_module, ONLY : foo
IMPLICIT NONE
public target_subroutine_wrapper_8_to_4
INTERFACE target_subroutine_wrapper_8_to_4
MODULE PROCEDURE target_subroutine_wrapper_8_to_4
END INTERFACE 
CONTAINS
SUBROUTINE target_subroutine(result)
REAL(kind=4) :: result
REAL(kind=4) :: result1 = 1.0
REAL(kind=8) :: result2 = 2.0
REAL(kind=8) :: result3 = 3.0
REAL(kind=8) :: result4 = 4.0
REAL(kind=10) :: i_in
i_in = 2.0_10
CALL right_wrapper_4xx_to_88g(result1)
CALL right_wrapper_84a_to_88g(result2,i_in,result1)
CALL foo(result3,op2_in=result2)
CALL right_wrapper_88a_to_88g(result4,op2_in=result3,op1_in=i_in)
CALL right_wrapper_4xx_to_88g(result)
result = result1 + result2 + result3 + result4
END SUBROUTINE 

SUBROUTINE target_subroutine_wrapper_8_to_4(result)
REAL(kind=8) :: result
REAL(kind=4) :: result_temp
result_temp = result
CALL target_subroutine(result=result_temp)
result = result_temp
END SUBROUTINE 

END MODULE target_module

