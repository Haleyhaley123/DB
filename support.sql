USE [dev_Rino]
GO
/****** Object:  StoredProcedure [dbo].[cms_Support_GetList]    Script Date: 16/6/2022 2:43:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[cms_Support_GetList]
    @IsClinic                           bit,
	@ListCity                           nvarchar(max),
    @UserId							    bigint,
    @Keyword							nvarchar(255),
	@PageIndex							int,
    @PageSize							int,
    @TotalRecord						bigint out,
    @Sort								nvarchar(100),
	@Direction							nvarchar(100)
as	

begin try

	declare @RoleId int 
	set @RoleId = (select RoleId from sec_User_Roles ur	where ur.UserId = @UserId	)

	-- Quyền quản lý doanh nghiệp
	if(@RoleId = 5)
	begin
					select 
						[SupportId]			= s.[SupportId],
						[SupportIssue]		= s.[SupportIssue],
						[Solution]			= s.[Solution],
						[CreateBy]			= s.[CreateBy],
						[CreateAt]			= s.[CreateAt],
						[Supporter]			= s.[Supporter],
						[StatusSupport]		= s.[StatusSupport],
						[Name]              = iif(@IsClinic=1,isnull(cl.Name,'{"en":"","vi":""}'),isnull(u.FullName,'{"en":"","vi":""}')),
						[DateSupport]	    = s.[DateSupport],
						[IsClinic]			=s.[IsClinic],
						Email               =iif(@IsClinic=1,cl.Email,u.Email),
						Phone               =iif(@IsClinic=1,cl.Phone,u.PhoneNumber)
						

					from  [dbo].[sec_Support] s (nolock)
					left join cat_Clinic cl on cl.UserId = s.CreateBy 
					left join sec_User u on u.UserId= s.CreateBy 
				
					where
					
					(@IsClinic =2 or Isnull(s.IsClinic,0)=@IsClinic )
					and
					([SupportIssue] like Concat('%',@Keyword,'%'))
					
					

						
					order by 
				CASE WHEN @Sort = ''		AND  @Direction = 'asc'		THEN [SupportId] END DESC,
				CASE WHEN @Sort = ''		AND  @Direction = 'desc'	THEN [SupportId] END DESC,
				CASE WHEN @Sort = ''		AND  @Direction = ''		THEN [SupportId] END DESC
				

						offset @PageSize * (@PageIndex - 1) ROWS
					fetch next @PageSize ROWS ONLY;

					
					select
						@TotalRecord                  = count([SupportId])
					from  [dbo].[sec_Support] s (nolock)
					left join cat_Clinic cl on cl.UserId = s.CreateBy 
					left join sec_User u on u.UserId= s.CreateBy 
									
					where
					
					(@IsClinic =2 or Isnull(s.IsClinic,0)=@IsClinic)
					and
					([SupportIssue] like Concat('%',@Keyword,'%')) 





					select 
						[SupportId]			= s.[SupportId],
						[SupportImageId]    = spi.[SupportImageId],
						[ImageUrl]			= spi.[ImageUrl]
					

					from  [dbo].[sec_Support] s (nolock)
					left join cat_Clinic cl on cl.UserId = s.CreateBy 
					left join sec_User u on u.UserId= s.CreateBy 
				     join cat_Support_Image spi on spi.SupportId = s.SupportId and isnull(spi.IsDelete,0)=0
									
					where
					
					(@IsClinic =2 or Isnull(s.IsClinic,0)=@IsClinic)
					and
					([SupportIssue] like Concat('%',@Keyword,'%')) 
						
	end	
	if(@RoleId = 4)
	begin
					select 
						[SupportId]			= s.[SupportId],
						[SupportIssue]		= s.[SupportIssue],
						[Solution]			= s.[Solution],
						[CreateBy]			= s.[CreateBy],
						[CreateAt]			= s.[CreateAt],
						[Supporter]			= s.[Supporter],
						[StatusSupport]		= s.[StatusSupport],
						[Name]              =isnull(cl.Name,'{"en":"","vi":""}'),
						[DateSupport]	    = s.[DateSupport],
						[IsClinic]			=s.[IsClinic],
						Email               =cl.Email,
						Phone               =cl.Phone
						

					from  [dbo].[sec_Support] s (nolock)
					left join cat_Clinic cl on cl.UserId = s.CreateBy and cl.City in (SELECT id FROM convert_string_to_table (@ListCity, ',') )					
							
					where
					
					@IsClinic =2
					and
					([SupportIssue] like Concat('%',@Keyword,'%'))
					
					

						
					order by 
				CASE WHEN @Sort = ''		AND  @Direction = 'asc'		THEN [SupportId] END DESC,
				CASE WHEN @Sort = ''		AND  @Direction = 'desc'	THEN [SupportId] END DESC,
				CASE WHEN @Sort = ''		AND  @Direction = ''		THEN [SupportId] END DESC
				

						offset @PageSize * (@PageIndex - 1) ROWS
					fetch next @PageSize ROWS ONLY;

					
					select
						@TotalRecord                  = count([SupportId])
					from  [dbo].[sec_Support] s (nolock)
					left join cat_Clinic cl on cl.UserId = s.CreateBy and cl.City in (SELECT id FROM convert_string_to_table (@ListCity, ',') )
					
									
					where
					
					@IsClinic =2
					and
					([SupportIssue] like Concat('%',@Keyword,'%')) 





					select 
						[SupportId]			= s.[SupportId],
						[SupportImageId]    = spi.[SupportImageId],
						[ImageUrl]			= spi.[ImageUrl]
					

					from  [dbo].[sec_Support] s (nolock)
					left join cat_Clinic cl on cl.UserId = s.CreateBy and cl.City in (SELECT id FROM convert_string_to_table (@ListCity, ',') )
					
				     join cat_Support_Image spi on spi.SupportId = s.SupportId and isnull(spi.IsDelete,0)=0
									
					where
					
					@IsClinic =2
					and
					([SupportIssue] like Concat('%',@Keyword,'%')) 
						
	end	
	--Quyền quản lý người dùng
	if(@RoleId = 3)
	begin
					select 
						[SupportId]			= s.[SupportId],
						[SupportIssue]		= s.[SupportIssue],
						[Solution]			= s.[Solution],
						[CreateBy]			= s.[CreateBy],
						[CreateAt]			= s.[CreateAt],
						[Supporter]			= s.[Supporter],
						[StatusSupport]		= s.[StatusSupport],
						[Name]              = isnull(u.FullName,'{"en":"","vi":""}'),
						[DateSupport]	    = s.[DateSupport],
						[IsClinic]			=s.[IsClinic],
						Email               =u.Email,
						Phone               =u.PhoneNumber
						

					from  [dbo].[sec_Support] s (nolock)
					
					left join sec_User u on u.UserId= s.CreateBy and u.ProvinceId in (SELECT id FROM convert_string_to_table (@ListCity, ','))
							
					where
					
					 Isnull(s.IsClinic,0)=@IsClinic 
					and
					([SupportIssue] like Concat('%',@Keyword,'%'))
					
					

						
					order by 
				CASE WHEN @Sort = ''		AND  @Direction = 'asc'		THEN [SupportId] END DESC,
				CASE WHEN @Sort = ''		AND  @Direction = 'desc'	THEN [SupportId] END DESC,
				CASE WHEN @Sort = ''		AND  @Direction = ''		THEN [SupportId] END DESC
				

						offset @PageSize * (@PageIndex - 1) ROWS
					fetch next @PageSize ROWS ONLY;

					
					select
						@TotalRecord                  = count([SupportId])
					from  [dbo].[sec_Support] s (nolock)
					
					left join sec_User u on u.UserId= s.CreateBy and u.ProvinceId in (SELECT id FROM convert_string_to_table (@ListCity, ','))
									
					where
					
					 Isnull(s.IsClinic,0)=@IsClinic
					and
					([SupportIssue] like Concat('%',@Keyword,'%')) 





					select 
						[SupportId]			= s.[SupportId],
						[SupportImageId]    = spi.[SupportImageId],
						[ImageUrl]			= spi.[ImageUrl]
					

					from  [dbo].[sec_Support] s (nolock)
					
					left join sec_User u on u.UserId= s.CreateBy and u.ProvinceId in (SELECT id FROM convert_string_to_table (@ListCity, ','))
				     join cat_Support_Image spi on spi.SupportId = s.SupportId and isnull(spi.IsDelete,0)=0
									
					where
					
					 Isnull(s.IsClinic,0)=@IsClinic
					and
					([SupportIssue] like Concat('%',@Keyword,'%')) 
						
	end	

end try

begin catch

	declare	@ErrorNum                 int,
			@ErrorMsg                 varchar(200),
			@ErrorProc                varchar(50),
			@AddlInfo                 varchar(500)

	set @ErrorNum                     = error_number()
	set @ErrorMsg                     = 'cms_Support_GetList: ' + error_message()
	set @ErrorProc                    = error_procedure()
	set	@AddlInfo                     = '' 

	exec utl_Insert_ErrorLog @ErrorNum, @ErrorMsg, @ErrorProc, 'cms_Support_GetList', 'GET', null, @AddlInfo

end catch
