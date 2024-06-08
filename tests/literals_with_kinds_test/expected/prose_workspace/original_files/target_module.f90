module target_module
    implicit none
    
    contains

    subroutine target_subroutine(result)

        real (kind=4)   :: a0=1.0
        real            :: a1=4.0
        real            :: a2
        real (kind=16)  :: result

        a2 = a0 + a1

        result = a2 + sign(2.718,a2) + 2.718_4 + 2.718_8 + 2.718_16
        
    end subroutine
    
end module target_module