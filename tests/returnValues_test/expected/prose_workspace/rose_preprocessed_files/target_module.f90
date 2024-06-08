MODULE target_module
USE auxiliary_module, ONLY : external_foo , external_bar
IMPLICIT NONE
CONTAINS
SUBROUTINE target_subroutine(result)
REAL :: result
REAL :: ib = 3.0, eb = 4.0, eifr = 5.0, eebr = 6.0
INTEGER :: eefi = 7, eibi = 8
result = implicit_bar(ib) + explicit_bar(eb) + external_foo(eifr)
result = result + external_foo(eefi) + external_bar(eibi) + external_bar(eebr)
END SUBROUTINE 

REAL FUNCTION implicit_bar(x)
REAL :: x
implicit_bar = 2.718281828459045 * x
END  FUNCTION 

 FUNCTION explicit_bar(x) result(bar_return)
REAL :: x
REAL :: bar_return
bar_return = 2.718281828459045 * x
END  FUNCTION 

END MODULE target_module

