MODULE TARGET_MODULE
IMPLICIT NONE
public target_subroutine_wrapper_g8_to_a4
INTERFACE target_subroutine_wrapper_g8_to_a4
MODULE PROCEDURE target_subroutine_wrapper_g8_to_a4
END INTERFACE 
CONTAINS
SUBROUTINE target_subroutine(result,pconstant)
IMPLICIT NONE
REAL(kind=10), INTENT(IN) :: pconstant
REAL(kind=10) :: p3
REAL(kind=10) :: p2
REAL(kind=10) :: p1
REAL(kind=10) :: p6
REAL(kind=10) :: p5
REAL(kind=10) :: p4
REAL(kind=4) :: result
p1 = 3.0_10
p2 = 4.0_10
p3 = 111.0_10
p4 = 3.0_10
p5 = 4.0_10
p6 = 111.0_10
result = sub_subroutine(pconstant,p1,p2,p3) + sub_subroutine(pconstant,p4,p5,p6)
END SUBROUTINE target_subroutine

REAL(kind=4) FUNCTION sub_subroutine(pconstant,p1,p2,p3)
IMPLICIT NONE
REAL(kind=10) :: p3
REAL(kind=10) :: p2
REAL(kind=10) :: p1
REAL(kind=10), INTENT(IN) :: pconstant
p3 = p1 + p2 + pconstant + sub_subroutine2(pconstant)
sub_subroutine = p3
END  FUNCTION sub_subroutine

REAL(kind=4) FUNCTION sub_subroutine2(pconstant)
IMPLICIT NONE
REAL(kind=10), INTENT(IN) :: pconstant
sub_subroutine2 = pconstant + 4.0_10
END  FUNCTION sub_subroutine2

SUBROUTINE target_subroutine_wrapper_g8_to_a4(result,pconstant)
REAL(kind=16), INTENT(IN) :: pconstant
REAL(kind=10) :: pconstant_temp
REAL(kind=8) :: result
REAL(kind=4) :: result_temp
pconstant_temp = pconstant
result_temp = result
CALL target_subroutine(result=result_temp,pconstant=pconstant_temp)
result = result_temp
END SUBROUTINE 

END MODULE TARGET_MODULE

