MODULE target_module
IMPLICIT NONE
CONTAINS
SUBROUTINE target_subroutine(result)
REAL(kind=4) :: a0 = 1.0
REAL(kind=8) :: a1 = 4.0
REAL(kind=4) :: a2
REAL(kind=16) :: result
a2 = a0 + a1
result = a2 + sign(2.718_4,a2) + 2.718_4 + 2.718_4 + 2.718_4
END SUBROUTINE 

END MODULE target_module

