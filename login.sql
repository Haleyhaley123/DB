USE [dev_Rino]
GO
/****** Object:  StoredProcedure [dbo].[sec_AccountGuest_GetByNameInfo_Admin]    Script Date: 14/6/2022 2:46:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sec_AccountGuest_GetByNameInfo_Admin]
    @UserName                           nvarchar(255)	
as	

begin try
	select 
        [UserId]                      = uus.UserId,
        [UserName]                    = uus.[UserName],
        [NormalizedUserName]          = uus.[NormalizedUserName],
        [Email]                       = uus.[Email],
        [NormalizedEmail]             = uus.[NormalizedEmail],
        [EmailConfirmed]              = uus.[EmailConfirmed],
        [PasswordHash]                = uus.[PasswordHash],
        [SecurityStamp]               = uus.[SecurityStamp],
        [ConcurrencyStamp]            = uus.[ConcurrencyStamp],
        [PhoneNumber]                 = uus.[PhoneNumber],
        [PhoneNumberConfirmed]        = uus.[PhoneNumberConfirmed],
            [AccessFailedCount]           = uus.[AccessFailedCount],
        [Status]					  = uus.[Status],
        [FullName]					  = uus.[FullName]
	from  [dbo].[sec_User] uus (nolock)
	left join sec_User_Roles sur on sur.UserId=uus.UserId
	where uus.UserName                    = @UserName and isnull(uus.IsDelete,0) = 0 
		and sur.RoleId >=3

end try

begin catch

	declare	@ErrorNum                 int,
			@ErrorMsg                 varchar(200),
			@ErrorProc                varchar(50),
			@AddlInfo                 varchar(500)

	set @ErrorNum                     = error_number()
	set @ErrorMsg                     = 'sec_AccountGuest_GetByNameInfo_Admin: ' + error_message()
	set @ErrorProc                    = error_procedure()
	set	@AddlInfo                     = '@UserName=' + convert(nvarchar, @UserName)

	exec utl_Insert_ErrorLog @ErrorNum, @ErrorMsg, @ErrorProc, 'sec_AccountGuest_GetByNameInfo_Admin', 'GET', null, @AddlInfo

end catch
