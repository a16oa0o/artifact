   integer, parameter :: MPAS_DECOMP_NOERR = 1000, &
                         MPAS_DECOMP_ERROR = 1001

#ifndef ROSE_COMP
   abstract interface
      function mpas_decomp_function(block, manager, globalDimSize, numBlocks, ownedIndices) result(iErr)
         import block_type
         import mpas_streamManager_type

         type (block_type), intent(in) :: block
         type (mpas_streamManager_type), intent(inout) :: manager
         integer, intent(in) :: globalDimSize
         integer, intent(in) :: numBlocks
         integer, dimension(:), pointer :: ownedIndices
         integer :: iErr
      end function
   end interface
#endif

   type mpas_decomp_list
      integer :: nameLen
      character (len=StrKIND) :: decompName
#ifndef ROSE_COMP
      procedure (mpas_decomp_function), pointer, nopass :: decompFunc => null()
#endif
      type (mpas_decomp_list), pointer :: next => null()
   end type mpas_decomp_list
