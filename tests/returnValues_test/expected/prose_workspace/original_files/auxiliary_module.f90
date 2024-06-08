module auxiliary_module
    implicit none

    public external_foo, external_bar

    interface external_foo
        module procedure external_implicit_foo_real
        module procedure external_explicit_foo_int
    end interface

    interface external_bar
        module procedure external_implicit_bar_int
        module procedure external_explicit_bar_real
    end interface

    contains 

    real function external_implicit_foo_real(x)
        real    :: x
        
        external_implicit_foo_real = 3.141592653589793 * x

    end function

    function external_explicit_foo_int(x) result(foo_return)
        integer    :: x
        real    :: foo_return

        foo_return = 3.141592653589793 * x
    end function

    real function external_implicit_bar_int(x)
        integer    :: x
        
        external_implicit_bar_int = 2.718281828459045 * x

    end function

    function external_explicit_bar_real(x) result(bar_return)
        real    :: x
        real    :: bar_return

        bar_return = 2.718281828459045 * x
    end function


end module auxiliary_module