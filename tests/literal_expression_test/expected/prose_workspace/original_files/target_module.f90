module target_module
    implicit none
    real           :: a1=4.0, b1=5.0, c1=6.0
    real           :: a0=1.0, b0=2.0, c0=3.0
    
    contains

    subroutine target_subroutine(result)

        real            :: a2, b2, c2
        integer         :: i = 3
        real (kind=8), intent(inout)  :: result

        a2 = a0 + a1
        b2 = b0 + b1
        c2 = c0 + c1

        result = a2 + b2 + c2

        call power(result, i)

        result = sum(90. - result, b1)

    end subroutine


    real function sum(x, y)
 
        real(kind=8), intent(in) :: x
        real, intent(in) :: y

        sum = x + y

    end function
    

    subroutine power(x, y)

        real (kind=8), intent(inout)  :: x
        integer  :: k,y

        do k=1,y
            x = x * x
        end do

    end subroutine
    
end module target_module