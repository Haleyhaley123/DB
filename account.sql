USE [dev_Rino]
GO
/****** Object:  StoredProcedure [dbo].[sec_AccountGuest_FindByPhoneNumber]    Script Date: 16/6/2022 10:18:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
***************************************************************************
	-- Author:			VuongNX
	-- Description:		delete collection type
	-- Parent:			Internal
	-- Date				PIC					Update record
	-- 2020/2/25		VuongNX				Delete Category	
***************************************************************************
*/
ALTER PROCEDURE [dbo].[sec_AccountGuest_FindByPhoneNumber]
	@Phone								nvarchar(255),
	@UserId								bigint,
	@StatusID							int out
as

begin try

	set		@StatusID					= 0
	if exists (	select 1 
				from	[sec_AccountGuest] cct (nolock)
				where	cct.PhoneNumber		= @Phone
				and isnull(IsDelete, 0) = 0
			)
	begin

		set		@StatusID               = 1
	end

end try
begin catch

	declare	@ErrorNum				int,
			@ErrorMsg				varchar(200),
			@ErrorProc				varchar(50),
			@AddlInfo				varchar(500),
			@SessionID				int

	set @ErrorNum					= error_number()
	set @ErrorMsg					= 'cat_Category_FindByName: ' + error_message()
	set @ErrorProc					= error_procedure()
	set	@AddlInfo					= '@PhoneNumber=' + convert(varchar,@Phone)
		
	exec utl_Insert_ErrorLog @ErrorNum, @ErrorMsg, @ErrorProc, 'cat_Category_FindByName', '', @SessionID, @AddlInfo

end catch


USE [dev_Rino]
GO
/****** Object:  StoredProcedure [dbo].[sec_AccountGuest_FindByEmail]    Script Date: 16/6/2022 10:18:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
***************************************************************************
	-- Author:			VuongNX
	-- Description:		delete collection type
	-- Parent:			Internal
	-- Date				PIC					Update record
	-- 2020/2/25		VuongNX				Delete Category	
***************************************************************************
*/
ALTER PROCEDURE [dbo].[sec_AccountGuest_FindByEmail]
	@Email								nvarchar(255),
	@UserId								bigint,
	@StatusID							int out
as

begin try

	set		@StatusID					= 0
	if exists (	select 1 
				from	[sec_AccountGuest] cct (nolock)
				where	cct.Email		= @Email
				and isnull(IsDelete, 0) = 0
			)
	begin

		set		@StatusID               = 1
	end

end try
begin catch

	declare	@ErrorNum				int,
			@ErrorMsg				varchar(200),
			@ErrorProc				varchar(50),
			@AddlInfo				varchar(500),
			@SessionID				int

	set @ErrorNum					= error_number()
	set @ErrorMsg					= 'cat_Category_FindByName: ' + error_message()
	set @ErrorProc					= error_procedure()
	set	@AddlInfo					= '@Email=' + convert(varchar,@Email)
		
	exec utl_Insert_ErrorLog @ErrorNum, @ErrorMsg, @ErrorProc, 'cat_Category_FindByName', '', @SessionID, @AddlInfo

end catch
USE [dev_Rino]
GO
/****** Object:  StoredProcedure [dbo].[sec_AccountGuest_GetById]    Script Date: 16/6/2022 10:18:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sec_AccountGuest_GetById]
    @Id                           bigint	
as	

begin try
	declare @UserId int  = 0
	select 
        [AccountGuestId]                      = uus.[AccountGuestId],
        [UserName]                    = uus.[UserName],
        [NormalizedUserName]          = uus.[NormalizedUserName],
        [Email]                       = uus.[Email],
        [NormalizedEmail]             = uus.[NormalizedEmail],
        [EmailConfirmed]              = uus.[EmailConfirmed],
        [LastName]					  = uus.[LastName],
        [PhoneNumber]                 = uus.[PhoneNumber],
        [PhoneNumberConfirmed]        = uus.[PhoneNumberConfirmed],
        [FirstName]                   = uus.[FirstName],
        [Birthday]                    = uus.[Birthday],
        [FullName]                    = uus.[FullName],
        [Avatar]                      = uus.[Avatar],
        [Status]                      = uus.[Status],
        [Address]                     = uus.[Address]
	from  [dbo].[sec_AccountGuest] uus (nolock)		 
	where uus.AccountGuestId                    = @Id and isnull(uus.IsDelete,0) = 0
	
end try

begin catch

	declare	@ErrorNum                 int,
			@ErrorMsg                 varchar(200),
			@ErrorProc                varchar(50),
			@AddlInfo                 varchar(500)

	set @ErrorNum                     = error_number()
	set @ErrorMsg                     = 'sec_AccountGuest_GetById: ' + error_message()
	set @ErrorProc                    = error_procedure()
	set	@AddlInfo                     = '@Id=' + convert(nvarchar, @Id)

	exec utl_Insert_ErrorLog @ErrorNum, @ErrorMsg, @ErrorProc, '[sec_AccountGuest]', 'GET', null, @AddlInfo

end catch
USE [dev_Rino]
GO
/****** Object:  StoredProcedure [dbo].[sec_AccountGuest_GetByName]    Script Date: 16/6/2022 10:19:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sec_AccountGuest_GetByName]
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
        --[TwoFactorEnabled]            = uus.[TwoFactorEnabled],
        --[LockoutEnd]                  = uus.[LockoutEnd],
        --[LockoutEnabled]              = uus.[LockoutEnabled],
        [AccessFailedCount]           = uus.[AccessFailedCount],
        [Status]					  = uus.[Status],
        [FullName]					  = uus.[FullName]
	from  [dbo].[sec_User] uus (nolock)
	left join sec_User_Roles sur on sur.UserId=uus.UserId
	where uus.UserName                    = @UserName and isnull(uus.IsDelete,0) = 0 
	and sur.RoleId=1
	--select
 --   [ModuleFunctionId]            = mf.ModuleFunctionId,
 --   [Name]                        = mf.[Name],
 --   [ParentId]                    = mf.[ParentId],
	--[AllowRead]                   = rp.[AllowRead],
	--[AllowWrite]                  = rp.[AllowWrite],
	--[AllowDelete]                 = rp.[AllowDelete],
 --   [RolePermissionId]            = rp.[RolePermissionId],
 --   [ArrUserPermisstion]          = (
 --       select
 --             [UserId]                   = ssu.[UserId],
 --             [RefId]                    = ssu.[RefId],
 --             [RolePermissionId]         = ssu.[RolePermissionId],
 --             [ModuleFunctionId]         = ssu.[ModuleFunctionId],
 --             [ModuleType]               = ssu.[ModuleType]                   
 --         from sec_User_Permission ssu
	--	  inner join sec_User u
	--				on u.UserId          = ssu.UserId
 --         where ssu.[ModuleFunctionId] = rp.[ModuleFunctionId] and u.[UserName] = @UserName
 --         FOR XML RAW('UserPermissionModel'), ROOT('UserPermisstions'), Elements
 --   )
	--from  [dbo].[sec_Module_Function] mf (nolock)
	--inner join [dbo].[sec_Role_Permission] rp
	--	on rp.ModuleFunctionId    = mf.ModuleFunctionId
	--inner join [dbo].[sec_Role] r
	--	on rp.RoleId              = r.RoleId
	--inner join [dbo].[sec_User_Roles] ur
	--	on r.RoleId               = ur.RoleId
	--inner join [sec_User] u
	--	on u.UserId               = ur.UserId
	--where u.UserName                 = @UserName and isnull(u.IsDelete,0) = 0
	
end try

begin catch

	declare	@ErrorNum                 int,
			@ErrorMsg                 varchar(200),
			@ErrorProc                varchar(50),
			@AddlInfo                 varchar(500)

	set @ErrorNum                     = error_number()
	set @ErrorMsg                     = 'sec_AccountGuest_GetByName: ' + error_message()
	set @ErrorProc                    = error_procedure()
	set	@AddlInfo                     = '@UserName=' + convert(nvarchar, @UserName)

	exec utl_Insert_ErrorLog @ErrorNum, @ErrorMsg, @ErrorProc, 'sec_AccountGuest', 'GET', null, @AddlInfo

end catch
USE [dev_Rino]
GO
/****** Object:  StoredProcedure [dbo].[sec_AccountGuest_GetByNameInfo]    Script Date: 16/6/2022 10:19:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sec_AccountGuest_GetByNameInfo]
    @UserName                           nvarchar(255)	
as	

begin try
	declare @UserId int  = 0
	select 
        [UserId]                      = uus.[UserId],
        [UserName]                    = uus.[UserName],
        [NormalizedUserName]          = uus.[NormalizedUserName],
        [Email]                       = uus.[Email],
        [NormalizedEmail]             = uus.[NormalizedEmail],
        [EmailConfirmed]              = uus.[EmailConfirmed],
        [FullName]					  = uus.[FullName],
        [PhoneNumber]                 = uus.[PhoneNumber],
        [PhoneNumberConfirmed]        = uus.[PhoneNumberConfirmed],
        [Birthday]                    = uus.[Birthday],
        [Avatar]                      = uus.[Avatar],
        [Status]                      = uus.[Status],
        [Address]                     = uus.[Address],
		[IdCardLeft]                  = uus.[IdCardLeft],
		[IdCardRight]                 = uus.[IdCardRight],
		[PassPort]                    = uus.[PassPort],
		[FirstLogin]                  = uus.[FirstLogin],
		[LoanMoney]                   = mu.LoanMoney,
		[Bonus]                       = mu.Bonus,
		FaceSelfieCard                = uus.[FaceSelfieCard],
	    FaceSelfiePassport            = uus.[FaceSelfiePassport],
		Lever                         = isnull(mu.Lever,1),
		[RinoApproval]                = isnull(uus.[RinoApproval],0),
		ProvinceId                    = uus.ProvinceId,
		DistrictId                    = uus.DistrictId,
		WardId                        = uus.WardId,
		ProvinceName                  = PV.Name,
		DistrictName                  = DT.Name,
		WardName                      = W.Name,
		UserType                      =ro.RoleId
	
	from  [dbo].[sec_User] uus (nolock)		 
	left join cat_Moey_User_Xref mu on mu.UserId = uus.UserId 
		left join cat_Province pv on pv.ProvinceId = uus.ProvinceId
	left join cat_District dt on dt.DistrictId = uus.DistrictId
	left join cat_Ward W on W.WardId = uus.WardId
	left join sec_User_Roles ro on ro.UserId=uus.UserId
	where uus.UserName                    = @UserName and isnull(uus.IsDelete,0) = 0

end try

begin catch

	declare	@ErrorNum                 int,
			@ErrorMsg                 varchar(200),
			@ErrorProc                varchar(50),
			@AddlInfo                 varchar(500)

	set @ErrorNum                     = error_number()
	set @ErrorMsg                     = 'sec_AccountGuest_GetByNameInfo: ' + error_message()
	set @ErrorProc                    = error_procedure()
	set	@AddlInfo                     = '@UserName=' + convert(nvarchar, @UserName)

	exec utl_Insert_ErrorLog @ErrorNum, @ErrorMsg, @ErrorProc, 'sec_AccountGuest', 'GET', null, @AddlInfo

end catch
USE [dev_Rino]
GO
/****** Object:  StoredProcedure [dbo].[sec_AccountGuest_GetByNameInfo_Admin]    Script Date: 16/6/2022 10:19:32 AM ******/
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
		and sur.RoleId >=3 and uus.Status = 1

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
USE [dev_Rino]
GO
/****** Object:  StoredProcedure [dbo].[sec_AccountGuest_GetByUserName]    Script Date: 16/6/2022 10:19:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sec_AccountGuest_GetByUserName]
    @UserName							nvarchar(256)
    
as	

begin try

	select  
	                [UserId]				           =x.[UserId],	
	                [UserName]					       =x.[UserName],				
					[NormalizedUserName]			   =x.[NormalizedUserName],	
					[Email]						       =x.[Email],				
					[NormalizedEmail]				   =x.[NormalizedEmail],		
					[EmailConfirmed]				   =x.[EmailConfirmed],		
					[LastName]						   =x.[LastName],				
					[FirstName]					       =x.[FirstName],			
					[Birthday]						   =x.[Birthday],				
					[FullName]						   =x.[FullName],				
					[Avatar]						   =x.[Avatar],				
					[PasswordHash]					   =x.[PasswordHash],			
					[SecurityStamp]				       =x.[SecurityStamp],		
					[ConcurrencyStamp]				   =x.[ConcurrencyStamp],		
					[PhoneNumber]					   =x.[PhoneNumber],			
					[PhoneNumberConfirmed]			   =x.[PhoneNumberConfirmed],	
					[AccessFailedCount]			       =x.[AccessFailedCount],	
					[Status]						   =x.[Status],	
					[CreateTime]					   =x.[CreateTime],		
					[UpdateBy]	                       =x.[UpdateBy],	
				    [UpdateTime]                       =x.[UpdateTime],		
					[IsDelete]					       =x.[IsDelete],				
					[Address]						   =x.[Address]				
				
				
	from  [dbo].[sec_User] x (nolock)
	   
	where x.[UserName]							=  @UserName
     and  ISNULL( x.[IsDelete] ,0)              = 0 


end try
begin catch

	declare	@ErrorNum                 int,
			@ErrorMsg                 varchar(200),
			@ErrorProc                varchar(50),
			@AddlInfo                 varchar(500)

	set @ErrorNum                     = error_number()
	set @ErrorMsg                     = 'sec_AccountGuest_GetByUserName: ' + error_message()
	set @ErrorProc                    = error_procedure()
	set	@AddlInfo                     = '@UserName=' + convert(nvarchar,@UserName)

	exec utl_Insert_ErrorLog @ErrorNum, @ErrorMsg, @ErrorProc, 'sec_AccountGuest_Get', 'GET', null, @AddlInfo

end catch
USE [dev_Rino]
GO
/****** Object:  StoredProcedure [dbo].[sec_AccountGuest_GetByUserOtherId]    Script Date: 16/6/2022 10:19:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sec_AccountGuest_GetByUserOtherId]
    @UserOtherId					    nvarchar(256),
    @TypeOther							nvarchar(256)
    
as	

begin try

	select  
	                [AccountGuestId]				   =x.[AccountGuestId],	
	                [UserName]					       =x.[UserName],				
					[NormalizedUserName]			   =x.[NormalizedUserName],	
					[Email]						       =x.[Email],				
					[NormalizedEmail]				   =x.[NormalizedEmail],		
					[EmailConfirmed]				   =x.[EmailConfirmed],		
					[LastName]						   =x.[LastName],				
					[FirstName]					       =x.[FirstName],			
					[Birthday]						   =x.[Birthday],				
					[FullName]						   =x.[FullName],				
					[Avatar]						   =x.[Avatar],				
					[PasswordHash]					   =x.[PasswordHash],			
					[SecurityStamp]				       =x.[SecurityStamp],		
					[ConcurrencyStamp]				   =x.[ConcurrencyStamp],		
					[PhoneNumber]					   =x.[PhoneNumber],			
					[PhoneNumberConfirmed]			   =x.[PhoneNumberConfirmed],	
					[TwoFactorEnabled]				   =x.[TwoFactorEnabled],		
					--[LockoutEnd]					   =x.[LockoutEnd],			
					[LockoutEnabled]				   =x.[LockoutEnabled],		
					[AccessFailedCount]			       =x.[AccessFailedCount],	
					[Status]						   =x.[Status],	
					[CreateBy]					       =x.[CreateBy],				
					[CreateTime]					   =x.[CreateTime],		
					[UpdateBy]	                       =x.[UpdateBy],	
				    [UpdateTime]                       =x.[UpdateTime],		
					[IsDelete]					       =x.[IsDelete],				
					[Address]						   =x.[Address],				
					[Sex]							   =x.[Sex],
				    [Ward]                             =w.[Name],
					[City]                             =p.[Name],
				    [District]                         =d.[Name]
	from  [dbo].[sec_AccountGuest] x (nolock)
	    left join cat_Province p on x.City =p.ProvinceId 
		left join cat_District d on x.District =d.DistrictId 
		left join cat_Ward w on w.WardId =x.Ward 
	where ((@TypeOther = 'FB' and x.UserFBId = @UserOtherId) or (@TypeOther = 'GG' and x.UserGGId = @UserOtherId))
     and  ISNULL( x.[IsDelete] ,0)              = 0 
end try
begin catch

	declare	@ErrorNum                 int,
			@ErrorMsg                 varchar(200),
			@ErrorProc                varchar(50),
			@AddlInfo                 varchar(500)

	set @ErrorNum                     = error_number()
	set @ErrorMsg                     = 'sec_AccountGuest_GetByUserOtherId: ' + error_message()
	set @ErrorProc                    = error_procedure()
	set	@AddlInfo                     = '@UserOtherId=' + convert(nvarchar,@UserOtherId)

	exec utl_Insert_ErrorLog @ErrorNum, @ErrorMsg, @ErrorProc, 'sec_AccountGuest_Get', 'GET', null, @AddlInfo

end catch
USE [dev_Rino]
GO
/****** Object:  StoredProcedure [dbo].[sec_AccountGuest_GetFireBaseToken_ByChatGroupId]    Script Date: 16/6/2022 10:20:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sec_AccountGuest_GetFireBaseToken_ByChatGroupId]
    @ChatGroupId					            int
    
as	

begin try
	
	select top 1
	    FireBaseToken = cct.DeviceToken
	from  [dbo].[sec_User_Device] cct (nolock)
	inner join cat_ChatGroup cg on cg.AccountGuestId = cct.UserID and (cct.DeviceType = 1 or cct.DeviceType = 2)
	where cg.ChatGroupId = @ChatGroupId	
     and  ISNULL( cg.[IsDelete] ,0)              = 0 


end try
begin catch

	declare	@ErrorNum                 int,
			@ErrorMsg                 varchar(200),
			@ErrorProc                varchar(50),
			@AddlInfo                 varchar(500)

	set @ErrorNum                     = error_number()
	set @ErrorMsg                     = 'sec_AccountGuest_GetFireBaseToken_ByChatGroupId: ' + error_message()
	set @ErrorProc                    = error_procedure()
	set	@AddlInfo                     = '@ChatGroupId=' + convert(nvarchar, @ChatGroupId)

	exec utl_Insert_ErrorLog @ErrorNum, @ErrorMsg, @ErrorProc, 'sec_User_Device', 'GET', null, @AddlInfo

end catch
USE [dev_Rino]
GO
/****** Object:  StoredProcedure [dbo].[sec_AccountRino_GetByUserName]    Script Date: 16/6/2022 10:20:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sec_AccountRino_GetByUserName]
    @UserName							nvarchar(256)
    
as	

begin try

	select  
	                [UserId]				           =x.[UserId],	
	                [UserName]					       =x.[UserName],				
					[NormalizedUserName]			   =x.[NormalizedUserName],	
					[Email]						       =x.[Email],				
					[NormalizedEmail]				   =x.[NormalizedEmail],		
					[EmailConfirmed]				   =x.[EmailConfirmed],		
					[LastName]						   =x.[LastName],				
					[FirstName]					       =x.[FirstName],			
					[Birthday]						   =x.[Birthday],				
					[FullName]						   =x.[FullName],				
					[Avatar]						   =x.[Avatar],				
					[PasswordHash]					   =x.[PasswordHash],			
					[SecurityStamp]				       =x.[SecurityStamp],		
					[ConcurrencyStamp]				   =x.[ConcurrencyStamp],		
					[PhoneNumber]					   =x.[PhoneNumber],			
					[PhoneNumberConfirmed]			   =x.[PhoneNumberConfirmed],	
					[AccessFailedCount]			       =x.[AccessFailedCount],	
					[Status]						   =x.[Status],	
					[CreateTime]					   =x.[CreateTime],		
					[UpdateBy]	                       =x.[UpdateBy],	
				    [UpdateTime]                       =x.[UpdateTime],		
					[IsDelete]					       =x.[IsDelete],				
					[Address]						   =x.[Address]				
			
				
	from  [dbo].[sec_User] x (nolock)
	   
	where x.[UserName]							=  @UserName
     and  ISNULL( x.[IsDelete] ,0)              = 0 


end try
begin catch

	declare	@ErrorNum                 int,
			@ErrorMsg                 varchar(200),
			@ErrorProc                varchar(50),
			@AddlInfo                 varchar(500)

	set @ErrorNum                     = error_number()
	set @ErrorMsg                     = 'sec_AccountRino_GetByUserName: ' + error_message()
	set @ErrorProc                    = error_procedure()
	set	@AddlInfo                     = '@UserName=' + convert(nvarchar,@UserName)

	exec utl_Insert_ErrorLog @ErrorNum, @ErrorMsg, @ErrorProc, 'sec_AccountRino_GetByUserName', 'GET', null, @AddlInfo

end catch
USE [dev_Rino]
GO
/****** Object:  StoredProcedure [dbo].[sec_AccountGuest_CheckExist_User]    Script Date: 16/6/2022 10:20:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sec_AccountGuest_CheckExist_User]
-- Add the parameters for the stored procedure here
	@UserName nvarchar(100),
	@Id bigint,
	@IsExists smallint out
AS
begin try
		set	@IsExists					= 0
	
		if(@Id != 0)
			begin
				if exists (	select	1
							from	[sec_AccountGuest] u
							where	UPPER(u.UserName)=UPPER(@UserName) and u.AccountGuestId != @Id
							)
					begin
						set		@IsExists					= 1
					end
			end
		else
			begin
				if exists (	select	1
							from	[sec_AccountGuest] u
							where	UPPER(u.UserName)=UPPER(@UserName)
							)
					begin
						set		@IsExists					= 1
					end
			end
end try
begin catch

	declare	@ErrorNum                 int,
			@ErrorMsg                 varchar(200),
			@ErrorProc                varchar(50),
			@AddlInfo                 varchar(500)

	set @ErrorNum                     = error_number()
	set @ErrorMsg                     = 'sec_AccountGuest_CheckExist_User: ' + error_message()
	set @ErrorProc                    = error_procedure()
	set	@AddlInfo                     = '@Id=' + convert(nvarchar, @Id)

	exec utl_Insert_ErrorLog @ErrorNum, @ErrorMsg, @ErrorProc, '[sec_AccountGuest]', 'GET', null, @AddlInfo

end catch
USE [dev_Rino]
GO
/****** Object:  StoredProcedure [dbo].[sec_AccountGuest_ChangeLock]    Script Date: 16/6/2022 10:21:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Created By: vuongnx
-- Created Time: 2021/02/25
-- methor : post
ALTER PROCEDURE [dbo].[sec_AccountGuest_ChangeLock]
	@AccountGuestId         bigint,
	@UserId					int,
	@StatusID                int out
as

	begin try
		set		@AccountGuestId                = isnull(@AccountGuestId, 0)
		--set @StatusID = 0
		if exists (	select 1 
					from	[sec_AccountGuest] r (nolock)
					where	r.AccountGuestId		= @AccountGuestId and r.IsDelete = 0
				)
		begin
			declare @a int
			set	@a = (Select u.[LockoutEnabled] from sec_AccountGuest u where u.AccountGuestId = @AccountGuestId)

			if(@a = 0)
			begin
				Update	r
				Set		r.[LockoutEnabled] = 1 ,r.UpdateBy = @UserId,r.UpdateTime = GETDATE()
				from	sec_AccountGuest r (nolock)
				where	r.AccountGuestId			= @AccountGuestId
				Select Code = 0, [Message] = 'Status success'
				--set @StatusID = 1
			end

			else
			begin
				Update	r
				Set		r.[LockoutEnabled] = 0,r.UpdateBy = @UserId,
				r.UpdateTime = GETDATE()
				from	sec_AccountGuest r (nolock)
				where	r.AccountGuestId			= @AccountGuestId
				Select Code = 0, [Message] = 'Status success'
			end
			set @StatusID = 1
		end
		else
		begin
			Select Code = 404, [Message] = 'Recored not found'
			set @StatusID = -1
		end
	end try
	begin catch

		declare	@ErrorNum				int,
				@ErrorMsg				varchar(200),
				@ErrorProc				varchar(50),
				@AddlInfo				varchar(500),
				@SessionID				int

		set @ErrorNum					= error_number()
		set @ErrorMsg					= 'sec_AccountGuest_ChangeLock: ' + error_message()
		set @ErrorProc					= error_procedure()
		set	@AddlInfo					= '@AccountGuestId=' + convert(varchar,@AccountGuestId)
		
		exec utl_Insert_ErrorLog @ErrorNum, @ErrorMsg, @ErrorProc, 'sec_AccountGuest_ChangeLock', 'DEL', @SessionID, @AddlInfo

	end catch
USE [dev_Rino]
GO
/****** Object:  StoredProcedure [dbo].[CMS_Create_Account_Admin_InsertUpdate]    Script Date: 16/6/2022 10:21:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
***************************************************************************
	-- Author:			vuopngnx	
	-- Description:		create account admin rino
	-- Parent:			Internal
	-- Date				PIC					Update record
	-- 2022/5/26		vuongnx				InsertUpdate	
***************************************************************************
*/


ALTER PROCEDURE [dbo].[CMS_Create_Account_Admin_InsertUpdate]
    @AccountAdmin						bigint out,
	@RoleId                             int,
    @UserId								bigint,
	@XMLID								int
as

begin try

		if @AccountAdmin <= 0
			begin
				--Insert user
				insert into [sec_User]
						(       
			            [UserName],
			            [NormalizedUserName],       
			            [Email],       
			            [NormalizedEmail],       
			            [EmailConfirmed],       
			            [PasswordHash],       
			            [SecurityStamp],       
			            [PhoneNumber],       
			            [PhoneNumberConfirmed],       
			           	[FullName],
						[CreateTime],
						[Status]
					
						)
				select	       
			            [UserName]                    =x.[Email],       
			            [NormalizedUserName]          =UPPER(x.Email),       
			            [Email]                       =x.[Email],       
			            [NormalizedEmail]             =UPPER(x.Email),       
			            [EmailConfirmed]              =x.[EmailConfirmed],       
			            [PasswordHash]                =x.[PasswordHash],       
			            [SecurityStamp]               =x.[SecurityStamp],       
			            [PhoneNumber]                 =x.[PhoneNumber],       
			            [PhoneNumberConfirmed]        =1,       
			            
						[FullName]					  =x.[FullName],
						[CreateTime]				  = GetDate(),							
						[Status]                      =x.[Status]
						
						

				from	openxml(@XMLID, '/AccountAdmin', 2) 
				with	(
			            [UserName]                    nvarchar(255),
			            [NormalizedUserName]          nvarchar(255),
			            [Email]                       nvarchar(255),
			            [NormalizedEmail]             nvarchar(255),
			            [EmailConfirmed]              bit,
			            [PasswordHash]                nvarchar(255),
			            [SecurityStamp]               nvarchar(255),
			            [PhoneNumber]                 nvarchar(50),
			            [PhoneNumberConfirmed]        bit,
			            [FullName]					  nvarchar(255),
						[CreateTime]                  datetime,
					    [Status]                      bit
						
						) x
					
				set		@AccountAdmin                        = scope_identity()

				-- insert role
				 insert into [sec_User_Roles]([UserId],[RoleId]) Values (@AccountAdmin,@RoleId) 





				if exists (select 1
					from	openxml(@XMLID, '/AccountAdmin/ListProvinceId/int',0) 
					With (ProvinceId int '.') z
					
					)
				begin
				  insert into [dbo].[cat_User_Admin_Adress]
							(       
							   [UserId]
							  ,[ProvinceId]
							 
							)
					select	       
							[UserId]                  =@AccountAdmin,       
							[ProvinceId]              =z.[ProvinceId]
							
					from	openxml(@XMLID, '/AccountAdmin/ListProvinceId/int',0)
						With (ProvinceId int '.') z
				end
			end
		else    --update
		    begin

			-- update thông tin bảng user - (name hoặc trạng thái hoạt động)
			 UPDATE [sec_User] 
				SET
				[Status]          = z.[Status]		,
				[FullName]		  = z.[FullName]		
				

				FROM OPENXML(@XMLID, '/AccountAdmin', 2)
				WITH
						(
						[Status]		   bit,
						[FullName]		   nvarchar(255)
					
					
						) z
				INNER JOIN [sec_User] r (nolock)
				ON r.UserId = @AccountAdmin
				WHERE
						   ISNULL(r.[Status],0)					            <> ISNULL(z.[Status],0)
						or isnull(r.[FullName],'')								<>isnull(z.[FullName],'')
						
             -- update bảng khu vực quản lý
			 delete from cat_User_Admin_Adress where UserId = @AccountAdmin

			 if exists (select 1
					from	openxml(@XMLID, '/AccountAdmin/ListProvinceId/int',0) 
					With (ProvinceId int '.') z
					
					)
				begin
				  insert into [dbo].[cat_User_Admin_Adress]
							(       
							   [UserId]
							  ,[ProvinceId]
							 
							)
					select	       
							[UserId]                  =@AccountAdmin,       
							[ProvinceId]              =z.[ProvinceId]
							
					from	openxml(@XMLID, '/AccountAdmin/ListProvinceId/int',0)
						With (ProvinceId int '.') z
				end



			end


end try

begin catch

	declare	@ErrorNum				int,
			@ErrorMsg				nvarchar(200),
			@ErrorProc				varchar(50),
			@SessionID				int,
			@AddlInfo				varchar(max)

	set @ErrorNum					= error_number()
	set @ErrorMsg					= 'CMS_Create_Account_Admin_InsertUpdate: ' + error_message()
	set @ErrorProc					= error_procedure()
	set @AddlInfo					= '@AccountAdmin=' + convert(nvarchar, @AccountAdmin)

	exec utl_Insert_ErrorLog @ErrorNum, @ErrorMsg, @ErrorProc, 'CMS_Create_Account_Admin_InsertUpdate', 'UPD', @SessionID, @AddlInfo

end catch
USE [dev_Rino]
GO
/****** Object:  StoredProcedure [dbo].[cat_User_Device_AccountGuest_GetAll]    Script Date: 16/6/2022 10:21:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[cat_User_Device_AccountGuest_GetAll]
    @Lang                               nvarchar(50),
	@ListClinicId                      nvarchar(max)
as	

begin try
	begin
 
 SELECT	    distinct
			[UserId]                 	  =x.UserID,        
            [DeviceToken]                 =x.[DeviceToken],       
            [DeviceType]                  =x.[DeviceType],
            [Lang]						  =x.[Lang]
		from sec_User_Device x
		left join cat_Clinic cl on cl.UserId = x.UserID 


		where (isnull(@Lang, '') = '' or x.Lang = @Lang)
	    and cl.ClinicId IN (SELECT id FROM convert_string_to_table (@ListClinicId, ',') )
		end
		
   end try

begin catch

	declare	@ErrorNum                 int,
			@ErrorMsg                 varchar(200),
			@ErrorProc                varchar(50),
			@AddlInfo                 varchar(500)

	set @ErrorNum                     = error_number()
	set @ErrorMsg                     = 'cat_User_Device_AccountGuest_GetAll: ' + error_message()
	set @ErrorProc                    = error_procedure()
	set	@AddlInfo                     = '@Lang=' + convert(nvarchar, @Lang)

	exec utl_Insert_ErrorLog @ErrorNum, @ErrorMsg, @ErrorProc, 'sec_User_Device', 'GET', null, @AddlInfo

end catch
USE [dev_Rino]
GO
/****** Object:  StoredProcedure [dbo].[CMS_Create_Account_Admin_InsertUpdate]    Script Date: 16/6/2022 10:22:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
***************************************************************************
	-- Author:			vuopngnx	
	-- Description:		create account admin rino
	-- Parent:			Internal
	-- Date				PIC					Update record
	-- 2022/5/26		vuongnx				InsertUpdate	
***************************************************************************
*/


ALTER PROCEDURE [dbo].[CMS_Create_Account_Admin_InsertUpdate]
    @AccountAdmin						bigint out,
	@RoleId                             int,
    @UserId								bigint,
	@XMLID								int
as

begin try

		if @AccountAdmin <= 0
			begin
				--Insert user
				insert into [sec_User]
						(       
			            [UserName],
			            [NormalizedUserName],       
			            [Email],       
			            [NormalizedEmail],       
			            [EmailConfirmed],       
			            [PasswordHash],       
			            [SecurityStamp],       
			            [PhoneNumber],       
			            [PhoneNumberConfirmed],       
			           	[FullName],
						[CreateTime],
						[Status]
					
						)
				select	       
			            [UserName]                    =x.[Email],       
			            [NormalizedUserName]          =UPPER(x.Email),       
			            [Email]                       =x.[Email],       
			            [NormalizedEmail]             =UPPER(x.Email),       
			            [EmailConfirmed]              =x.[EmailConfirmed],       
			            [PasswordHash]                =x.[PasswordHash],       
			            [SecurityStamp]               =x.[SecurityStamp],       
			            [PhoneNumber]                 =x.[PhoneNumber],       
			            [PhoneNumberConfirmed]        =1,       
			            
						[FullName]					  =x.[FullName],
						[CreateTime]				  = GetDate(),							
						[Status]                      =x.[Status]
						
						

				from	openxml(@XMLID, '/AccountAdmin', 2) 
				with	(
			            [UserName]                    nvarchar(255),
			            [NormalizedUserName]          nvarchar(255),
			            [Email]                       nvarchar(255),
			            [NormalizedEmail]             nvarchar(255),
			            [EmailConfirmed]              bit,
			            [PasswordHash]                nvarchar(255),
			            [SecurityStamp]               nvarchar(255),
			            [PhoneNumber]                 nvarchar(50),
			            [PhoneNumberConfirmed]        bit,
			            [FullName]					  nvarchar(255),
						[CreateTime]                  datetime,
					    [Status]                      bit
						
						) x
					
				set		@AccountAdmin                        = scope_identity()

				-- insert role
				 insert into [sec_User_Roles]([UserId],[RoleId]) Values (@AccountAdmin,@RoleId) 





				if exists (select 1
					from	openxml(@XMLID, '/AccountAdmin/ListProvinceId/int',0) 
					With (ProvinceId int '.') z
					
					)
				begin
				  insert into [dbo].[cat_User_Admin_Adress]
							(       
							   [UserId]
							  ,[ProvinceId]
							 
							)
					select	       
							[UserId]                  =@AccountAdmin,       
							[ProvinceId]              =z.[ProvinceId]
							
					from	openxml(@XMLID, '/AccountAdmin/ListProvinceId/int',0)
						With (ProvinceId int '.') z
				end
			end
		else    --update
		    begin

			-- update thông tin bảng user - (name hoặc trạng thái hoạt động)
			 UPDATE [sec_User] 
				SET
				[Status]          = z.[Status]		,
				[FullName]		  = z.[FullName]		
				

				FROM OPENXML(@XMLID, '/AccountAdmin', 2)
				WITH
						(
						[Status]		   bit,
						[FullName]		   nvarchar(255)
					
					
						) z
				INNER JOIN [sec_User] r (nolock)
				ON r.UserId = @AccountAdmin
				WHERE
						   ISNULL(r.[Status],0)					            <> ISNULL(z.[Status],0)
						or isnull(r.[FullName],'')								<>isnull(z.[FullName],'')
						
             -- update bảng khu vực quản lý
			 delete from cat_User_Admin_Adress where UserId = @AccountAdmin

			 if exists (select 1
					from	openxml(@XMLID, '/AccountAdmin/ListProvinceId/int',0) 
					With (ProvinceId int '.') z
					
					)
				begin
				  insert into [dbo].[cat_User_Admin_Adress]
							(       
							   [UserId]
							  ,[ProvinceId]
							 
							)
					select	       
							[UserId]                  =@AccountAdmin,       
							[ProvinceId]              =z.[ProvinceId]
							
					from	openxml(@XMLID, '/AccountAdmin/ListProvinceId/int',0)
						With (ProvinceId int '.') z
				end



			end


end try

begin catch

	declare	@ErrorNum				int,
			@ErrorMsg				nvarchar(200),
			@ErrorProc				varchar(50),
			@SessionID				int,
			@AddlInfo				varchar(max)

	set @ErrorNum					= error_number()
	set @ErrorMsg					= 'CMS_Create_Account_Admin_InsertUpdate: ' + error_message()
	set @ErrorProc					= error_procedure()
	set @AddlInfo					= '@AccountAdmin=' + convert(nvarchar, @AccountAdmin)

	exec utl_Insert_ErrorLog @ErrorNum, @ErrorMsg, @ErrorProc, 'CMS_Create_Account_Admin_InsertUpdate', 'UPD', @SessionID, @AddlInfo

end catch
