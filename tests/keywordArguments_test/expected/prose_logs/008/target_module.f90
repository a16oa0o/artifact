MODULE target_module
USE auxiliary_module, ONLY : right_wrapper_4xx_to_880
USE auxiliary_module, ONLY : right_wrapper_840_to_880
USE auxiliary_module, ONLY : right_wrapper_44x_to_880
USE auxiliary_module, ONLY : right_wrapper_440_to_880
USE auxiliary_module, ONLY : right_wrapper_4xx_to_880
USE auxiliary_module, ONLY : generic_name
IMPLICIT NONE
public target_subroutine_wrapper_8_to_4
INTERFACE target_subroutine_wrapper_8_to_4
MODULE PROCEDURE target_subroutine_wrapper_8_to_4
END INTERFACE 
CONTAINS
SUBROUTINE target_subroutine(result)
REAL(kind=4) :: result
REAL(kind=4) :: result1
REAL(kind=4) :: result2
REAL(kind=4) :: result3
REAL(kind=8) :: result4
CALL right_wrapper_4xx_to_880(result1)
CALL right_wrapper_440_to_880(result2,1,result1)
CALL right_wrapper_44x_to_880(result3,multiplicand=result2)
CALL right_wrapper_840_to_880(result4,multiplicand=result3,iterations=2)
CALL right_wrapper_4xx_to_880(result)
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

