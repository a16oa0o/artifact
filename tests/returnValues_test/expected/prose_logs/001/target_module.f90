MODULE target_module
USE auxiliary_module, ONLY : external_explicit_bar_real_wrapper_4_to_8
USE auxiliary_module, ONLY : external_implicit_foo_real_wrapper_4_to_8
USE auxiliary_module, ONLY : external_foo , external_bar
IMPLICIT NONE
public target_subroutine_wrapper_8_to_4
INTERFACE target_subroutine_wrapper_8_to_4
MODULE PROCEDURE target_subroutine_wrapper_8_to_4
END INTERFACE 
CONTAINS
SUBROUTINE target_subroutine(result)
REAL(kind=4) :: result
REAL(kind=4) :: eebr = 6.0
REAL(kind=4) :: eifr = 5.0
REAL(kind=4) :: eb = 4.0
REAL(kind=4) :: ib = 3.0
INTEGER :: eefi = 7, eibi = 8
result = implicit_bar(ib) + explicit_bar(eb) + external_implicit_foo_real_wrapper_4_to_8(eifr)
result = result + external_foo(eefi) + external_bar(eibi) + external_explicit_bar_real_wrapper_4_to_8(eebr)
END SUBROUTINE 

REAL(kind=4) FUNCTION implicit_bar(x)
REAL(kind=4) :: x
implicit_bar = 2.718281828459045_4 * x
END  FUNCTION 

 FUNCTION explicit_bar(x) result(bar_return)
REAL(kind=4) :: x
REAL(kind=4) :: bar_return
bar_return = 2.718281828459045_4 * x
END  FUNCTION 

SUBROUTINE target_subroutine_wrapper_8_to_4(result)
REAL(kind=8) :: result
REAL(kind=4) :: result_temp
result_temp = result
CALL target_subroutine(result=result_temp)
result = result_temp
END SUBROUTINE 

END MODULE target_module

