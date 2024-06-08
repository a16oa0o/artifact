MODULE target_module
USE auxiliary_module, ONLY : external_foo , external_bar
IMPLICIT NONE
public explicit_bar_wrapper_8_to_4
INTERFACE explicit_bar_wrapper_8_to_4
MODULE PROCEDURE explicit_bar_wrapper_8_to_4
END INTERFACE 
CONTAINS
SUBROUTINE target_subroutine(result)
REAL(kind=8) :: result
REAL(kind=8) :: eebr = 6.0
REAL(kind=8) :: eifr = 5.0
REAL(kind=8) :: eb = 4.0
REAL(kind=8) :: ib = 3.0
INTEGER :: eefi = 7, eibi = 8
result = implicit_bar(ib) + explicit_bar_wrapper_8_to_4(eb) + external_foo(eifr)
result = result + external_foo(eefi) + external_bar(eibi) + external_bar(eebr)
END SUBROUTINE 

REAL(kind=4) FUNCTION implicit_bar(x)
REAL(kind=8) :: x
implicit_bar = 2.718281828459045_8 * x
END  FUNCTION 

 FUNCTION explicit_bar(x) result(bar_return)
REAL(kind=4) :: x
REAL(kind=4) :: bar_return
bar_return = 2.718281828459045_4 * x
END  FUNCTION 

REAL FUNCTION explicit_bar_wrapper_8_to_4(x) result(returnValue)
REAL(kind=8) :: x
REAL(kind=4) :: x_temp
x_temp = x
returnValue = explicit_bar(x=x_temp)
x = x_temp
END  FUNCTION 

END MODULE target_module

