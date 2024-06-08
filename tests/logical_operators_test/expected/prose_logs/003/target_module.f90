MODULE target_module
IMPLICIT NONE
CONTAINS
SUBROUTINE target_subroutine(result,dummy1,dummy2)
REAL(kind=4) :: c0 = 3.0
REAL(kind=4) :: b0 = 2.0
REAL(kind=4) :: a0 = 1.0
REAL(kind=8) :: c1 = 6.0
REAL(kind=4) :: b1 = 5.0
REAL(kind=4) :: a1 = 4.0
REAL(kind=16) :: result
REAL(kind=8), OPTIONAL :: dummy2
REAL(kind=8), OPTIONAL :: dummy1
LOGICAL :: t = .TRUE., f = .FALSE.
IF (a0 .NE. a1) result = c0
IF (t .NEQV. f) result = c1
IF (present(dummy1) .NEQV. present(dummy2)) result = 2.0_16
IF (b1 .NE. b0) result = 1.0_16
END SUBROUTINE 

END MODULE target_module

