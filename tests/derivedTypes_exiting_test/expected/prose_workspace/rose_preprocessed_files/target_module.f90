MODULE target_module
USE auxiliary_module, ONLY : construct_array
USE auxiliary_type, ONLY : my_derived_type
IMPLICIT NONE
CONTAINS
SUBROUTINE target_subroutine(result,dt)
REAL(kind=16) :: result
TYPE ( my_derived_type )  :: dt
REAL(kind=8), DIMENSION(dt%array_dim) :: array
INTEGER :: i
dt%scalar = 2.0
CALL construct_array(array,dt)
result = 0
DO i = 1, dt%array_dim
result = result + array(i)
END DO
END SUBROUTINE 

END MODULE target_module

