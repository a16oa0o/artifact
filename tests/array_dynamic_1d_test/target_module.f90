module target_module
    implicit none
    real, allocatable :: array(:)
    
    contains

    subroutine target_subroutine(result)

        real (kind=4)   :: a0=1.0, b0=2.0, c0=3.0
        real            :: a1=4.0, b1=5.0, c1=6.0
        real (kind=16)  :: result

        allocate( array(3) )

        array(1) = a0 + a1       
        array(2) = b0 + b1
        array(3) = c0 + c1

        result = array(1) + array(2) + array(3)

        deallocate( array )
        
    end subroutine
    
end module target_module