MODULE TARGET_MODULE
IMPLICIT NONE
CONTAINS
SUBROUTINE target_subroutine(result,pconstant)
IMPLICIT NONE
REAL(kind=16), INTENT(IN) :: pconstant
REAL(kind=16) :: p3
REAL(kind=16) :: p2
REAL(kind=16) :: p1
REAL(kind=16) :: p6
REAL(kind=16) :: p5
REAL(kind=16) :: p4
REAL(kind=8) :: result
p1 = 3.0_16
p2 = 4.0_16
p3 = 111.0_16
p4 = 3.0_16
p5 = 4.0_16
p6 = 111.0_16
result = sub_subroutine(pconstant,p1,p2,p3) + sub_subroutine(pconstant,p4,p5,p6)
END SUBROUTINE target_subroutine

REAL(kind=8) FUNCTION sub_subroutine(pconstant,p1,p2,p3)
IMPLICIT NONE
REAL(kind=16) :: p3
REAL(kind=16) :: p2
REAL(kind=16) :: p1
REAL(kind=16), INTENT(IN) :: pconstant
p3 = p1 + p2 + pconstant + sub_subroutine2(pconstant)
sub_subroutine = p3
END  FUNCTION sub_subroutine

REAL(kind=8) FUNCTION sub_subroutine2(pconstant)
IMPLICIT NONE
REAL(kind=16), INTENT(IN) :: pconstant
sub_subroutine2 = pconstant + 4.0_16
END  FUNCTION sub_subroutine2

END MODULE TARGET_MODULE

