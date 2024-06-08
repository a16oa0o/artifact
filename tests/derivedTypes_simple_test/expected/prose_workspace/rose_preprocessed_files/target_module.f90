MODULE target_module
IMPLICIT NONE
TYPE , PUBLIC :: my_derived_type
private
INTEGER :: array_dim
REAL :: scalar
END TYPE my_derived_type
CONTAINS
SUBROUTINE target_subroutine(result)
REAL(kind=16) :: result
TYPE ( my_derived_type )  :: dt
REAL, DIMENSION(:), ALLOCATABLE :: array
INTEGER :: i
dt%array_dim = 3
dt%scalar = 2.0
allocate( array(dt%array_dim) )
CALL construct_array(array,dt)
result = 0
DO i = 1, dt%array_dim
result = result + array(i)
END DO
deallocate( array )
END SUBROUTINE 

SUBROUTINE construct_array(array,dt)
TYPE ( my_derived_type )  :: dt
REAL, DIMENSION(dt%array_dim) :: array
INTEGER :: i
DO i = 1, dt%array_dim
array(i) = dt%scalar ** (i - 1)
END DO
END SUBROUTINE 

END MODULE target_module

