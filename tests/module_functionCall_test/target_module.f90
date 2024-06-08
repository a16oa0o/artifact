module target_module
    implicit none
    real       :: a0, b0, c0
    real, dimension(3,2)  :: array=reshape((/1.0, 2.0, 3.0, 4.0, 5.0, 6.0/), shape(array), order=(/2,1/))    
    contains

    subroutine target_subroutine(result)

        real (kind=16)      :: result

        a0 = array(1,1) + array(1,2)
        b0 = array(2,1) + array(2,2)
        c0 = array(3,1) + array(3,2)

        result = a0 + b0 + c0
        
    end subroutine
    
end module target_module