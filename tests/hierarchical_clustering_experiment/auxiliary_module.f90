! the function foo assigns all negative kind8 reals a performance
! penalty and assigns all positive kind4 reals an accuracy penalty.
! Thus, the best possible configuration is the one in which all negative
! reals are kind4 and all positive reals are kind8

module auxiliary_module
    interface prose_foo
        module procedure prose_foo4, prose_foo8
    end interface

    contains

    function prose_foo4(x)
        real(kind=4) :: x
        real(kind=4) :: prose_foo4

        if ( x > 0.0 ) then
            prose_foo4 = x * 2
        else
            prose_foo4 = x
        end if

    end function

    function prose_foo8(x)
        real(kind=8) :: x
        real(kind=8) :: prose_foo8

        if ( x < 0.0 ) then
            call sleep(1)
        end if

        prose_foo8 = x

    end function

end module auxiliary_module