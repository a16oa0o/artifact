MODULE target_module
USE auxiliary_module, ONLY : construct_array_target_wrapper_04_to_08
USE auxiliary_module, ONLY : construct_array
USE auxiliary_type, ONLY : my_derived_type
IMPLICIT NONE
CONTAINS
SUBROUTINE target_subroutine(result)
REAL(kind=16) :: result
TYPE ( my_derived_type )  :: dt
REAL(kind=4), DIMENSION(:), ALLOCATABLE :: array
INTEGER :: i
dt%array_dim = 3
dt%scalar = 2.0_8
allocate( array(dt%array_dim) )
CALL construct_array_target_wrapper_04_to_08(array,dt)
result = 0
DO i = 1, dt%array_dim
result = result + array(i)
END DO
deallocate( array )
END SUBROUTINE 

END MODULE target_module

