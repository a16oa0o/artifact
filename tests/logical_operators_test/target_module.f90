module target_module
    implicit none
    
    contains

    subroutine target_subroutine(result, dummy1, dummy2)

        real (kind=4)   :: a0=1.0, b0=2.0, c0=3.0
        real            :: a1=4.0, b1=5.0, c1=6.0
        real (kind=16)  :: result
        real, optional  :: dummy1, dummy2
        logical         :: t=.TRUE., f=.FALSE.

        if (a0 .NE. a1) result = c0
        if (t .NEQV. f) result = c1
        if (present(dummy1) .NEQV. present(dummy2)) result = 2.0
        if (b1 /= b0) result = 1.0
        
    end subroutine
    
end module target_module