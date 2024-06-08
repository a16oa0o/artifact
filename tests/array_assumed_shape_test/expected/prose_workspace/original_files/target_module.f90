module target_module
    use auxiliary_module, only  : my_array_sum

    implicit none
    
    contains

    subroutine target_subroutine(result)

        real (kind=4)       :: a0=1.0, b0=2.0, c0=3.0
        real                :: a1=4.0, b1=5.0, c1=6.0
        real (kind=16)      :: result
        real, dimension(3)  :: array

        array(1) = a0 + a1
        array(2) = b0 + b1
        array(3) = c0 + c1

        result = my_array_sum(array, b1)
        
    end subroutine
    
end module target_module