MODULE auxiliary_module
USE auxiliary_type, ONLY : my_derived_type
IMPLICIT NONE
public construct_array_target_wrapper_04_to_08
INTERFACE construct_array_target_wrapper_04_to_08
MODULE PROCEDURE construct_array_target_wrapper_04_to_08
END INTERFACE 
public construct_array
INTERFACE construct_array
MODULE PROCEDURE construct_array_dummy
MODULE PROCEDURE construct_array_target
END INTERFACE 
CONTAINS
SUBROUTINE construct_array_target(array,dt)
TYPE ( my_derived_type )  :: dt
REAL(kind=8), DIMENSION(dt%array_dim) :: array
INTEGER :: i
DO i = 1, dt%array_dim
array(i) = dt%scalar ** (i - 1)
END DO
END SUBROUTINE 

SUBROUTINE construct_array_dummy(array,dt)
TYPE ( my_derived_type )  :: dt
REAL(kind=16), DIMENSION(dt%array_dim) :: array
INTEGER :: i
DO i = 1, dt%array_dim
array(i) = dt%scalar ** (i - 1)
END DO
END SUBROUTINE 

SUBROUTINE construct_array_target_wrapper_04_to_08(array,dt)
TYPE ( my_derived_type )  :: dt
REAL(kind=4), DIMENSION(dt%array_dim) :: array
REAL(kind=8), DIMENSION(dt%array_dim) :: array_temp
array_temp = array
CALL construct_array_target(array=array_temp,dt=dt)
array = array_temp
END SUBROUTINE 

END MODULE auxiliary_module

