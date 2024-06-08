module auxiliary_module

    implicit none

    public  ::  generic_name

    interface generic_name
        module procedure right
        module procedure wrong
    end interface

    contains

    subroutine right(result, iterations, multiplicand)
        real(kind=8)        :: result
        real(kind=8), optional      :: multiplicand
        real(kind=8)                :: m
        integer, optional   :: iterations
        integer             :: j, i


        if (present(multiplicand)) then
            m = multiplicand
        else
            m = 1.0
        endif

        if (present(iterations)) then
            i = iterations
        else
            i = 1
        endif

        result = 1.0
        do j = 1,i
            result = result + result * m
        end do        

    end subroutine

    subroutine wrong(result)
        real(kind=16) :: result

        result = 0.0
        
    end subroutine

end module auxiliary_module