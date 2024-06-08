MODULE auxiliary_module
IMPLICIT NONE
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

END MODULE auxiliary_module

