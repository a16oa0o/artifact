MODULE auxiliary_module
IMPLICIT NONE
public my_array_sum_wrapper_44_to_88
INTERFACE my_array_sum_wrapper_44_to_88
MODULE PROCEDURE my_array_sum_wrapper_44_to_88
END INTERFACE 
CONTAINS
 FUNCTION my_array_sum(array,scalar)
REAL(kind=8), DIMENSION(1:), INTENT(IN) :: array
REAL(kind=8), INTENT(IN) :: scalar
REAL(kind=8) :: my_array_sum
INTEGER :: i
my_array_sum = 0
DO i = 1, size(array)
my_array_sum = my_array_sum + array(i) * scalar
END DO
END  FUNCTION 

REAL FUNCTION my_array_sum_wrapper_44_to_88(array,scalar) result(returnValue)
REAL(kind=4), DIMENSION(1:), INTENT(IN) :: array
REAL(kind=8), DIMENSION(:), ALLOCATABLE :: array_temp
REAL(kind=4), INTENT(IN) :: scalar
REAL(kind=8) :: scalar_temp
array_temp = array
scalar_temp = scalar
returnValue = my_array_sum(array=array_temp,scalar=scalar_temp)
END  FUNCTION 

END MODULE auxiliary_module

