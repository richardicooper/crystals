! The module formatnumbers_mod contains subroutine to handle number formating as xxx(yy)
module formatnumber_mod
!> Default number of digit for esd
integer, parameter :: default_esd=2
integer, parameter :: buffer_length=1024

private print_value_sp, print_value_dp, default_esd, print_value_core

interface print_value
    module procedure print_value_sp, print_value_dp
end interface

contains

!> Format a number with its esd 
!! Single precision front end
function print_value_sp(num, esd, opt_fixedform, opt_precision, opt_length, opt_decimal_pos) result(formatted_output)
implicit none
real, intent(in) :: num, esd
!> flag to outuput fixed format (leading space for minus sign)
logical, optional, intent(in) :: opt_fixedform
!> number of digit to keep for the esd
integer, optional, intent(in) :: opt_precision
!> fix a length for the return of the value. Padded with blanks
integer, optional, intent(in) :: opt_length
!> Position of the decimal point
integer, optional, intent(in) :: opt_decimal_pos
character(len=:), allocatable :: formatted_output

character(len=buffer_length) :: buffer
integer length
logical :: arg_fixedform
integer :: arg_precision
integer :: arg_length
integer :: arg_decimal_pos

    if(esd<0.0d0) then
        print *, 'negative esd'
        call abort()
    end if

    arg_length=-1
    if(present(opt_length)) then
        if(opt_length>buffer_length) then
            print *, 'Error: overflow of string buffer'
            call abort()
        else
            arg_length=opt_length
        end if
    else
    end if

    arg_fixedform=.false.
    if(present(opt_fixedform)) then
        if(opt_fixedform) then        
            arg_fixedform=.true.
        end if
    end if

    if(present(opt_precision)) then
        arg_precision=opt_precision
    else
        arg_precision=default_esd
    end if

    arg_decimal_pos=-1
    if(present(opt_decimal_pos)) then
        if(opt_decimal_pos<0) then
            print *, 'negative decimal point position index'
            call abort()
        else
            arg_decimal_pos=opt_decimal_pos
        end if
    end if

    call print_value_core(real(num, kind(1.0d0)), real(esd,kind(1.0d0)), &
    &   arg_fixedform, arg_precision, arg_length, arg_decimal_pos, &
    &   buffer, length)
    allocate(character(len=length) :: formatted_output)
    formatted_output=buffer(1:length)
end function

!> Format a number with its esd 
!! double precision front end
function print_value_dp(num, esd, opt_fixedform, opt_precision, opt_length, opt_decimal_pos) result(formatted_output)
implicit none
double precision, intent(in) :: num, esd
!> flag to outuput fixed format (leading space for minus sign)
logical, optional, intent(in) :: opt_fixedform
!> number of digit to keep for the esd
integer, optional, intent(in) :: opt_precision
!> fix a length for the return of the value. Padded with blanks
integer, optional, intent(in) :: opt_length
!> Position of the decimal point
integer, optional, intent(in) :: opt_decimal_pos
character(len=:), allocatable :: formatted_output

character(len=buffer_length) :: buffer
integer length
logical :: arg_fixedform
integer :: arg_precision
integer :: arg_length
integer :: arg_decimal_pos

    if(esd<0.0d0) then
        print *, 'negative esd'
        call abort()
    end if

    arg_length=-1
    if(present(opt_length)) then
        if(opt_length>buffer_length) then
            print *, 'Error: overflow of string buffer'
            call abort()
        else
            arg_length=opt_length
        end if
    else
    end if

    arg_fixedform=.false.
    if(present(opt_fixedform)) then
        if(opt_fixedform) then        
            arg_fixedform=.true.
        end if
    end if

    if(present(opt_precision)) then
        arg_precision=opt_precision
    else
        arg_precision=default_esd
    end if

    arg_decimal_pos=-1
    if(present(opt_decimal_pos)) then
        if(opt_decimal_pos<0) then
            print *, 'negative decimal point position index'
            call abort()
        else
            arg_decimal_pos=opt_decimal_pos
        end if
    end if

    call print_value_core(num, esd, &
    &   arg_fixedform, arg_precision, arg_length, arg_decimal_pos, &
    &   buffer, length)
    allocate(character(len=length) :: formatted_output)
    formatted_output=buffer(1:length)
end function

!> Format a number with its esd (double precision)
!! Core function, should only be called from print_value_(sp,dp)
subroutine print_value_core(num, esd, arg_fixedform, arg_precision, arg_length, arg_decimal_pos, formatted_output, length)
implicit none
double precision, intent(in) :: num, esd
!> flag to outuput fixed format (leading space for minus sign)
logical, intent(in) :: arg_fixedform
!> number of digit to keep for the esd
integer, intent(in) :: arg_precision
!> fix a length for the return of the value. Padded with blanks
integer, intent(in) :: arg_length
!> Position of the decimal point
integer, intent(in) :: arg_decimal_pos
!> formatted string
character(len=buffer_length), intent(out) :: formatted_output
!> length of string
integer, intent(out) :: length
character(len=buffer_length) :: buffer
integer digit, total, i
character(len=buffer_length) :: formatstr

    if(esd>=10.0d0) then
        if(arg_fixedform .and. num>0.0d0) then
            write(buffer, "(' ',I0,'(',I0,')')") nint(num), nint(esd)
        else
            write(buffer, "(I0,'(',I0,')')") nint(num), nint(esd)
        end if
    else if(esd>=1.0d0) then
        ! rule of 19
        if(nint(esd*10.0d0)>2*10**(arg_precision-1)-1) then
            if(arg_fixedform .and. num>0.0d0) then
                write(buffer, "(' ',I0,'(',I0,')')") nint(num), nint(esd)
            else
                write(buffer, "(I0,'(',I0,')')") nint(num), nint(esd)
            end if
        else
            if(arg_fixedform .and. num>0.0d0) then
                write(buffer, "(' ',F0.1,'(',I0,')')") num, nint(esd*10.0d0)
            else
                write(buffer, "(F0.1,'(',I0,')')") num, nint(esd*10.0d0)
            end if
        end if
    else
        ! number of zeros before any digit
        digit=ceiling(-log10(esd))-1
        ! rule of 19
        if(arg_precision>1) then
            if(esd*10**(digit+arg_precision)>2.0d0*10**(arg_precision-1)-1.0d0) then
                digit=digit-1
            end if
        end if
        if(arg_fixedform) then
            if(abs(num)<1.0d0) then
                total=digit+arg_precision+4
            else
                total=digit+arg_precision+3+nint(log10(abs(num)))
            end if
        else
            total=0
        end if
        write(formatstr, "(a,I0,a,I0,a)") '(F',total,'.',digit+arg_precision, "'(',I0,')')"
        write(buffer, formatstr) num, nint(esd*10**(digit+arg_precision))
    end if
    if(arg_length/=-1) then
        if(len_trim(buffer)>arg_length) then
            print *, 'Number cannot be represented, arg_length too small'
            call abort()
        end if
        if(arg_decimal_pos/=-1) then
            i=index(buffer, '.')
            if(i>arg_decimal_pos) then
                print *, 'Warning: decimal point cannot be aligned'
                formatted_output=buffer(1:arg_length)
            else            
                if(len_trim(buffer)+arg_decimal_pos-i>arg_length) then
                    print *, 'Number cannot be represented, arg_length too small'
                    call abort()
                end if
                formatted_output(1+(arg_decimal_pos-i):arg_length)=buffer(1:arg_length-(arg_decimal_pos-i))
                formatted_output(1:arg_decimal_pos-i)=repeat(' ', arg_decimal_pos-i)
            end if
        else
            formatted_output=buffer(1:arg_length)    
        end if     
       length=arg_length
    else
        if(arg_decimal_pos/=-1) then
            i=index(buffer, '.')
            if(i>arg_decimal_pos) then
                print *, 'Warning: decimal point cannot be aligned'
                formatted_output=trim(buffer)
                length=len_trim(buffer)
            else            
                formatted_output(arg_decimal_pos-i+1:len_trim(buffer)+arg_decimal_pos-i+1)=trim(buffer)
                formatted_output(1:arg_decimal_pos-i)=repeat(' ', arg_decimal_pos-i)
                length=len_trim(buffer)+(arg_decimal_pos-i)
            end if
        else            
            formatted_output=trim(buffer)
            length=len_trim(buffer)
        end if        
    end if

end subroutine

end module