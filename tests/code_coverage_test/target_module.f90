module target_module
    implicit none
    real           :: a1=4.0, b1=5.0, c1=6.0
    real (kind=4)  :: a0=1.0, b0=2.0, c0=3.0
    
    contains

    subroutine target_subroutine(result)

        real            :: a2, b2, c2
        real (kind=16)  :: result
        integer         :: i

        a2 = a0 + a1
        b2 = b0 + b1
        c2 = c0 + c1

        do i = 0, 10
            result = result + a2 + b2 + c2
        end do

    end subroutine
    
end module target_module