MODULE target_module
IMPLICIT NONE
CONTAINS
SUBROUTINE target_subroutine(result)
REAL(kind=4) :: c0 = 3.0
REAL(kind=4) :: b0 = 2.0
REAL(kind=4) :: a0 = 1.0
REAL(kind=8) :: c1 = 6.0
REAL(kind=8) :: b1 = 5.0
REAL(kind=8) :: a1 = 4.0
REAL(kind=16) :: result
REAL(kind=8), DIMENSION(3) :: array
array(1) = a0 + a1
array(2) = b0 + b1
array(3) = c0 + c1
result = array(1) + array(2) + array(3)
END SUBROUTINE 

END MODULE target_module

