MODULE target_module
USE auxiliary_module, ONLY : my_array_sum
IMPLICIT NONE
CONTAINS
SUBROUTINE target_subroutine(result)
REAL(kind=4) :: a0 = 1.0, b0 = 2.0, c0 = 3.0
REAL :: a1 = 4.0, b1 = 5.0, c1 = 6.0
REAL(kind=16) :: result
REAL, DIMENSION(3) :: array
array(1) = a0 + a1
array(2) = b0 + b1
array(3) = c0 + c1
result = my_array_sum(array,b1)
END SUBROUTINE 

END MODULE target_module

