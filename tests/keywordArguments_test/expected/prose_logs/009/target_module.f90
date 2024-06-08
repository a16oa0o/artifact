MODULE target_module
USE auxiliary_module, ONLY : right_wrapper_480_to_880
USE auxiliary_module, ONLY : generic_name
IMPLICIT NONE
CONTAINS
SUBROUTINE target_subroutine(result)
REAL(kind=8) :: result
REAL(kind=8) :: result1
REAL(kind=8) :: result2
REAL(kind=8) :: result3
REAL(kind=4) :: result4
CALL generic_name(result1)
CALL generic_name(result2,1,result1)
CALL generic_name(result3,multiplicand=result2)
CALL right_wrapper_480_to_880(result4,multiplicand=result3,iterations=2)
CALL generic_name(result)
result = result1 + result2 + result3 + result4
END SUBROUTINE 

END MODULE target_module

