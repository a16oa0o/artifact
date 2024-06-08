MODULE target_module
IMPLICIT NONE
REAL :: a1 = 4.0, b1 = 5.0, c1 = 6.0
REAL(kind=4) :: a0 = 1.0, b0 = 2.0, c0 = 3.0
CONTAINS
SUBROUTINE target_subroutine(result)
REAL :: a2, b2, c2
REAL(kind=16) :: result
INTEGER :: i
a2 = a0 + a1
b2 = b0 + b1
c2 = c0 + c1
DO i = 0, 10
result = result + a2 + b2 + c2
END DO
END SUBROUTINE 

END MODULE target_module

