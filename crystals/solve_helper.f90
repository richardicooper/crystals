module solve_helper
contains 

!> code for the inversion of the normal matrix using eigen decomposition
!! Small eigen values are filtered out based on a condtion number threshold
subroutine eigen_inversion(nmatrix, nmsize, eigcutoff, nrejected, condition, filtered_condition)
use m_mrgrnk
implicit none
!> On input symmetric real matrix stored in packed format (lower triangle)
!! aij is stored in AP( i+(2n-j)(j-1)/2) for j <= i.
!! On output the inverse of the matrix is return
real, dimension(:), intent(inout) :: nmatrix
!> Value for the condition number cutoff
real, intent(in) :: eigcutoff
!> Leading dimension of the matrix nmatrix
integer, intent(in) :: nmsize
!> condition number of matrix
real, intent(out) :: condition
!> condition number of filtered_condition
real, intent(out) :: filtered_condition
!> number of eigenvalues filtered out during inversion
integer, intent(out) :: nrejected

real, dimension(:), allocatable :: preconditioner, eigvalues, work
integer, dimension(:), allocatable :: iwork
real, dimension(:,:), allocatable :: eigvectors, invert
logical truncated
integer :: starttime
integer, dimension(8) :: measuredtime
integer i, j, k, info
real, dimension(1) :: lwork
integer, dimension(1) :: liwork

! preconditioning using diagonal terms
! Allocate diagonal vector
allocate(preconditioner(nmsize))
do i=1,nmsize
    j = ((i-1)*(2*(nmsize)-i+2))/2
    if(nmatrix(1+j)/=0.0) then
        preconditioner(i)=nmatrix(1+j)
    else
        preconditioner(i)=1.0
    end if
end do      
preconditioner = 1.0/sqrt(preconditioner) 

! Applying C N C
! N: normal matrix
! C: diagonal matrix with elements from the N diagonal
do i=1,nmsize
    j = ((i-1)*(2*(nmsize)-i+2))/2
    k = j + nmsize - i
    nmatrix(1+j:1+k)=preconditioner(i)*preconditioner(i:nmsize)*nmatrix(1+j:1+k)
end do              
       
! unpacking normal matrix
! not necessary but unpacked data operations are better
! optimised in lapack
! unpacking + invert + packing is faster
allocate(eigvectors(nmsize, nmsize))
do i=1, nmsize
    j = ((i-1)*(2*(nmsize)-i+2))/2
    k = j + nmsize - i
    eigvectors(i:nmsize, i)=nmatrix(1+j:1+k)
    eigvectors(i, i:nmsize)=nmatrix(1+j:1+k)
end do

! eigen value filtering
allocate(eigvalues(nmsize))
!call date_and_time(VALUES=measuredtime)
!starttime=((measuredtime(5)*3600+measuredtime(6)*60)+ &
!    measuredtime(7))+measuredtime(8)/1000.0
! query buffer size
call ssyevd ('V', 'L', nmsize, eigvectors, nmsize, eigvalues, &
    lwork, -1, liwork, -1, info)
allocate(work(nint(lwork(1))))
allocate(iwork(liwork(1)))

call ssyevd ('V', 'L', nmsize, eigvectors, nmsize, eigvalues, &
    work, nint(lwork(1)), iwork, liwork(1), info)

!print *, 'PP* eigen value info (SSPEVD)', info
!call date_and_time(VALUES=measuredtime)
!print *, 'PP* eigen decomp done in (s): ', &
!    ((measuredtime(5)*3600+measuredtime(6)*60)+ &
!    measuredtime(7))+measuredtime(8)/1000.0-starttime
!call flush
deallocate(iwork)
deallocate(work)

! eigen values cutoff
!print *, 'PP* cond number cut off', eigcutoff, &
!    'max eigen value', eigvalues(nmsize)
!print *, 'PP* smallest eigen values', eigvalues(1:3)
              
truncated=.false.
i=1
nrejected = 0
allocate(iwork(nmsize))
do while(eigvalues(nmsize)/max(0.00001,eigvalues(i))>eigcutoff)
!    print *, 'PP* Value', eigvalues(i), 'removed, ', &
!        'old conditioned number:', eigvalues(nmsize)/eigvalues(i)
    call mrgrnk(abs(eigvectors(:,i)), iwork)
!    print *, 'PP* Highest eigenvectors components'
!    do j=nmsize,nmsize-10,-1
!        print *, iwork(j), eigvectors(iwork(j),i)
!    end do
    truncated=.true.
    !print *, 'sum of components**2', sum(svdVT(:,i)**2)
    i=i+1
end do
nrejected = i - 1
condition = eigvalues(nmsize)/max(0.00001,eigvalues(1))
filtered_condition = condition 
deallocate(iwork)
if(truncated) then
!    write(123,*) 'PP* condition number on the ',  &
!        'remaining eigen values ', eigvalues(nmsize)/eigvalues(i)
    eigvalues(1:i-1)=0.0
    eigvalues(i:nmsize)=1.0/sqrt(eigvalues(i:nmsize))
    filtered_condition = eigvalues(nmsize)/max(0.00001,eigvalues(i))
else
!    print *, 'PP* condition number ', eigvalues(nmsize)/eigvalues(1)
   eigvalues=1.0/sqrt(eigvalues)
end if


! Inverting (C N C) matrix using eigen decomposition + filtered eigen values
allocate(invert(nmsize,nmsize))
! N^-1 = V E V^t
!      = V E^0.5 E^0.5 V^t
!      = (V E^0.5) (V E^0.5)^t
!               invert = matmul((eigvectors), matmul(eigvalues, 
!                   transpose(eigvectors)))

do i=1, nmsize
   eigvectors(:,i)=eigvectors(:,i)*eigvalues(i)
end do
invert=0.0
call SSYRK('L','N',nmsize,nmsize,1.0,eigvectors,nmsize,1.0,invert,nmsize)

! Pack normal matrix back into original crystals storage
do i=1,nmsize
    j = ((i-1)*(2*nmsize-i+2))/2
    k = j + nmsize - i
    nmatrix(1+j:1+k)=invert(i:nmsize,i)
end do             

deallocate(invert)
deallocate(eigvectors)
deallocate(eigvalues)                      
   
! revert pre conditioning                   
! Applying C (C N C)^-1 C to get N^-1
! N: normal matrix
! C: diagonal matrix with elements from the N diagonal
do i=1,nmsize
    j = ((i-1)*(2*(nmsize)-i+2))/2
    k = j + nmsize - i
    nmatrix(1+j:1+k)=preconditioner(i)*preconditioner(i:nmsize)* &
        nmatrix(1+j:1+k)
end do              
deallocate(preconditioner)

end subroutine

subroutine cholesky_inversion(nmatrix, nmsize)
implicit none
!> On input symmetric real matrix stored in packed format (lower triangle)
!! aij is stored in AP( i+(2n-j)(j-1)/2) for j <= i.
!! On output the inverse of the matrix is return
real, dimension(nmsize*(nmsize+1)/2), intent(inout) :: nmatrix
!> Leading dimension of the matrix nmatrix
integer, intent(in) :: nmsize

real, dimension(:), allocatable :: preconditioner
integer i, j, k, info
real, dimension(:,:), allocatable :: unpacked

!integer :: starttime
!integer, dimension(8) :: measuredtime

! preconditioning using diagonal terms
! Allocate diagonal vector
allocate(preconditioner(nmsize))
do i=1,nmsize
    j = ((i-1)*(2*(nmsize)-i+2))/2
    if(nmatrix(1+j)/=0.0) then
        preconditioner(i)=nmatrix(1+j)
    else
        preconditioner(i)=1.0
    end if
end do      
preconditioner = 1.0/sqrt(preconditioner) 

! Applying C N C
! N: normal matrix
! C: diagonal matrix with elements from the N diagonal
do i=1,nmsize
    j = ((i-1)*(2*(nmsize)-i+2))/2
    k = j + nmsize - i
    nmatrix(1+j:1+k)=preconditioner(i)*preconditioner(i:nmsize)*nmatrix(1+j:1+k)
end do              

! unpacking normal matrix
! not necessary but unpacked data operations are better
! optimised in lapack
! unpacking + invert + packing is faster
allocate(unpacked(nmsize, nmsize))
do i=1, nmsize
    j = ((i-1)*(2*(nmsize)-i+2))/2
    k = j + nmsize - i
    unpacked(i:nmsize, i)=nmatrix(1+j:1+k)
    unpacked(i, i:nmsize)=nmatrix(1+j:1+k)
end do

!call date_and_time(VALUES=measuredtime)
!starttime=((measuredtime(5)*3600+measuredtime(6)*60)+measuredtime(7))*1000+measuredtime(8)
call SPOTRF( 'L', nmsize, unpacked, nmsize, INFO )
!call date_and_time(VALUES=measuredtime)
!print *, 'PP* ****** U factor ok? ', info, &
!&       ((measuredtime(5)*3600+measuredtime(6)*60)+measuredtime(7))*1000+measuredtime(8)-starttime, 'ms'

!call date_and_time(VALUES=measuredtime)
!starttime=((measuredtime(5)*3600+measuredtime(6)*60)+measuredtime(7))*1000+measuredtime(8)
call SPOTRI( 'L', nmsize, unpacked, nmsize, INFO )
!call date_and_time(VALUES=measuredtime)
!print *, 'PP* ***** single Inverse ok? ', info  , &
!&       ((measuredtime(5)*3600+measuredtime(6)*60)+measuredtime(7))*1000+measuredtime(8)-starttime, 'ms'

! Pack normal matrix back into original crystals storage
! plus preconditioning
do i=1,nmsize
    j = ((i-1)*(2*nmsize-i+2))/2
    k = j + nmsize - i
    nmatrix(1+j:1+k)=preconditioner(i)*preconditioner(i:nmsize)*unpacked(i:nmsize,i)
end do    
            
deallocate(preconditioner)

end subroutine

end module
