MODULE TARGET_MODULE
   IMPLICIT NONE

   CONTAINS

   SUBROUTINE target_subroutine( result, pconstant )

       IMPLICIT NONE 
       REAL(KIND=16) :: pconstant
       REAL(KIND=16) :: p1, p2, p3
       REAL(KIND=16) :: p4, p5, p6
       REAL(KIND=8) :: result

       p1 = 3.0
       p2 = 4.0
       p3 = 111.0
       p4 = 3.0
       p5 = 4.0
       p6 = 111.0

       result = sub_subroutine( pconstant, p1, p2, p3 ) + sub_subroutine(pconstant, p4, p5, p6)

   END SUBROUTINE target_subroutine

   REAL(KIND=8) FUNCTION sub_subroutine( pconstant, p1, p2, p3) 

       IMPLICIT NONE 
       REAL(KIND=16) :: p1, p2, p3
       REAL(KIND=16) :: pconstant

       p3 = p1 + p2 + pconstant + sub_subroutine2( pconstant )

       sub_subroutine = p3

    END FUNCTION sub_subroutine

    REAL(KIND=8) FUNCTION sub_subroutine2( pconstant )

        IMPLICIT NONE
        REAL(KIND=16) :: pconstant

        sub_subroutine2 = pconstant + 4.0

    END FUNCTION sub_subroutine2

END MODULE TARGET_MODULE
