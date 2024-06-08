MODULE target_module
USE auxiliary_module, ONLY : right_wrapper_84x_to_88g
USE auxiliary_module, ONLY : right_wrapper_44g_to_88g
USE auxiliary_module, ONLY : right_wrapper_4xx_to_88g
USE auxiliary_module, ONLY : foo
IMPLICIT NONE
CONTAINS
SUBROUTINE target_subroutine(result)
REAL(kind=8) :: result
REAL(kind=4) :: result1 = 1.0
REAL(kind=4) :: result2 = 2.0
REAL(kind=8) :: result3 = 3.0
REAL(kind=8) :: result4 = 4.0
REAL(kind=16) :: i_in
i_in = 2.0_16
CALL right_wrapper_4xx_to_88g(result1)
CALL right_wrapper_44g_to_88g(result2,i_in,result1)
CALL right_wrapper_84x_to_88g(result3,op2_in=result2)
CALL foo(result4,op2_in=result3,op1_in=i_in)
CALL foo(result)
result = result1 + result2 + result3 + result4
END SUBROUTINE 

END MODULE target_module

