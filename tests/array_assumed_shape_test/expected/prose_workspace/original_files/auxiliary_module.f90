module auxiliary_module
    implicit none
    
    contains

    function my_array_sum(array, scalar)
        real, dimension(1:), intent(in)  :: array
        real, intent(in)                :: scalar
        real                :: my_array_sum
        integer             :: i

        my_array_sum = 0

        do i = 1,size(array)
            my_array_sum = my_array_sum + array(i) * scalar
        end do
    end function

end module auxiliary_module