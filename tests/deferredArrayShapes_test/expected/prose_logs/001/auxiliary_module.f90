MODULE auxiliary_module
IMPLICIT NONE
public construct_array_target_wrapper_4_to_8
INTERFACE construct_array_target_wrapper_4_to_8
MODULE PROCEDURE construct_array_target_wrapper_4_to_8
END INTERFACE 
public construct_array
INTERFACE construct_array
MODULE PROCEDURE construct_array_dummy
MODULE PROCEDURE construct_array_target
END INTERFACE 
CONTAINS
SUBROUTINE construct_array_target(array)
REAL(kind=8), DIMENSION(:) :: array
INTEGER :: i
DO i = 1, size(array)
array(i) = 2 ** (i - 1)
END DO
END SUBROUTINE 

SUBROUTINE construct_array_dummy(array)
REAL(kind=16), DIMENSION(:) :: array
INTEGER :: i
DO i = 1, size(array)
array(i) = 2 ** (i - 1)
END DO
END SUBROUTINE 

SUBROUTINE construct_array_target_wrapper_4_to_8(array)
REAL(kind=4), DIMENSION(:) :: array
REAL(kind=8), DIMENSION(:), ALLOCATABLE :: array_temp
array_temp = array
CALL construct_array_target(array=array_temp)
array = array_temp
END SUBROUTINE 

END MODULE auxiliary_module

