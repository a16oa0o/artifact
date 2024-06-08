module target_module
    use auxiliary_module, only  : external_foo, external_bar

    implicit none
    
    contains

    subroutine target_subroutine(result)

        real    :: result
        real    :: ib = 3.0, eb = 4.0, eifr=5.0, eebr=6.0
        integer :: eefi = 7, eibi = 8

        result = implicit_bar(ib) + explicit_bar(eb) + external_foo(eifr)
        result = result + external_foo(eefi) + external_bar(eibi) + external_bar(eebr)

    end subroutine

    real function implicit_bar(x)
        real    :: x
        implicit_bar = 2.718281828459045 * x

    end function

    function explicit_bar(x) result(bar_return)
        real    :: x
        real    :: bar_return

        bar_return = 2.718281828459045 * x
    end function
    
end module target_module