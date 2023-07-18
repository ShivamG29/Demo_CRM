USE [master]
GO
/****** Object:  Database [CRM]    Script Date: 14-07-2023 09:52:14 ******/
CREATE DATABASE [CRM]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CRM', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\CRM.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'CRM_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\CRM_log.ldf' , SIZE = 784KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [CRM] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CRM].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CRM] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CRM] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CRM] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CRM] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CRM] SET ARITHABORT OFF 
GO
ALTER DATABASE [CRM] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [CRM] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CRM] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CRM] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CRM] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CRM] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CRM] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CRM] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CRM] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CRM] SET  ENABLE_BROKER 
GO
ALTER DATABASE [CRM] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CRM] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CRM] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CRM] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CRM] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CRM] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CRM] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CRM] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CRM] SET  MULTI_USER 
GO
ALTER DATABASE [CRM] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CRM] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CRM] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CRM] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [CRM]
GO
/****** Object:  Table [dbo].[User_Login]    Script Date: 14-07-2023 09:52:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Login](
	[Fk_Userid] [int] NULL,
	[Punch_In] [datetime] NULL,
	[Punch_Out] [datetime] NULL,
	[End_Break] [datetime] NULL,
	[Lunch_Break] [datetime] NULL,
	[Get_Current_Date] [datetime] NULL,
	[Remark] [nvarchar](500) NULL,
	[Leave] [bit] NULL,
	[Status] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User_Table]    Script Date: 14-07-2023 09:52:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Table](
	[User_id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
 CONSTRAINT [PK_User_Table] PRIMARY KEY CLUSTERED 
(
	[User_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vW_Work_Status]    Script Date: 14-07-2023 09:52:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[vW_Work_Status]
as
select *,case when L.Leave=1 then 'Onleave' end As LeaveStatus,
case when isnull(L.Punch_In,'')<>'' and isnull(Punch_Out,'')='' and isnull(Lunch_Break,'')='' and Status=1 then 'OnWork'
	 when isnull(L.Punch_In,'')='' then 'On Leave'
	 when isnull(l.Punch_In,'')<>'' and isnull(l.Lunch_Break,'')<>'' and isnull(l.End_Break,'')='' then 'On Lunch'
	 when isnull(l.Punch_In,'')<>'' and isnull(l.Lunch_Break,'')<>'' and isnull(l.End_Break,'')<>'' and Leave=0 and isnull(l.Punch_Out,'')<>'' and Status=0 then 'Check Out'
	 else 'OnWork'
	 --when L.Punch_In<>null and Punch_Out=null and Lunch_Break<>null and End_Break=null then 'OnBreak'
end As WorkStatus
from User_Login L
inner join user_Table T On L.Fk_Userid=T.user_id
GO
INSERT [dbo].[User_Login] ([Fk_Userid], [Punch_In], [Punch_Out], [End_Break], [Lunch_Break], [Get_Current_Date], [Remark], [Leave], [Status]) VALUES (1, CAST(N'2023-07-12T16:25:21.370' AS DateTime), CAST(N'2023-07-12T16:25:26.670' AS DateTime), NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[User_Login] ([Fk_Userid], [Punch_In], [Punch_Out], [End_Break], [Lunch_Break], [Get_Current_Date], [Remark], [Leave], [Status]) VALUES (2, CAST(N'2023-07-12T12:53:42.893' AS DateTime), CAST(N'2023-07-12T12:53:42.893' AS DateTime), NULL, NULL, NULL, N'Feaver', 0, 0)
INSERT [dbo].[User_Login] ([Fk_Userid], [Punch_In], [Punch_Out], [End_Break], [Lunch_Break], [Get_Current_Date], [Remark], [Leave], [Status]) VALUES (3, CAST(N'2023-07-12T12:53:42.893' AS DateTime), NULL, NULL, CAST(N'2023-07-12T12:53:42.893' AS DateTime), NULL, N'Urgent Work', 0, 1)
INSERT [dbo].[User_Login] ([Fk_Userid], [Punch_In], [Punch_Out], [End_Break], [Lunch_Break], [Get_Current_Date], [Remark], [Leave], [Status]) VALUES (4, CAST(N'2023-07-12T12:53:42.897' AS DateTime), NULL, CAST(N'2023-07-12T12:53:42.897' AS DateTime), CAST(N'2023-07-12T12:53:42.897' AS DateTime), NULL, N'Not Felling Well', 0, 1)
INSERT [dbo].[User_Login] ([Fk_Userid], [Punch_In], [Punch_Out], [End_Break], [Lunch_Break], [Get_Current_Date], [Remark], [Leave], [Status]) VALUES (5, NULL, NULL, NULL, NULL, NULL, N'Out Of Station', 1, 0)
INSERT [dbo].[User_Login] ([Fk_Userid], [Punch_In], [Punch_Out], [End_Break], [Lunch_Break], [Get_Current_Date], [Remark], [Leave], [Status]) VALUES (6, CAST(N'2023-07-12T13:15:48.777' AS DateTime), NULL, CAST(N'2023-07-12T13:33:15.547' AS DateTime), CAST(N'2023-07-12T13:33:15.547' AS DateTime), CAST(N'2023-07-12T13:29:05.540' AS DateTime), N'Cold', 0, 1)
INSERT [dbo].[User_Login] ([Fk_Userid], [Punch_In], [Punch_Out], [End_Break], [Lunch_Break], [Get_Current_Date], [Remark], [Leave], [Status]) VALUES (7, CAST(N'2023-07-12T13:15:48.783' AS DateTime), NULL, NULL, NULL, NULL, N'Headach', 0, 1)
INSERT [dbo].[User_Login] ([Fk_Userid], [Punch_In], [Punch_Out], [End_Break], [Lunch_Break], [Get_Current_Date], [Remark], [Leave], [Status]) VALUES (8, CAST(N'2023-07-12T13:15:48.787' AS DateTime), NULL, NULL, CAST(N'2023-07-12T13:38:26.380' AS DateTime), NULL, N'Feaver', 0, 1)
INSERT [dbo].[User_Login] ([Fk_Userid], [Punch_In], [Punch_Out], [End_Break], [Lunch_Break], [Get_Current_Date], [Remark], [Leave], [Status]) VALUES (9, CAST(N'2023-07-12T13:17:58.983' AS DateTime), CAST(N'2023-07-12T13:17:58.983' AS DateTime), CAST(N'2023-07-12T13:17:58.983' AS DateTime), CAST(N'2023-07-12T13:17:58.983' AS DateTime), CAST(N'2023-07-12T13:17:58.983' AS DateTime), NULL, 0, 0)
INSERT [dbo].[User_Login] ([Fk_Userid], [Punch_In], [Punch_Out], [End_Break], [Lunch_Break], [Get_Current_Date], [Remark], [Leave], [Status]) VALUES (10, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0)
GO
SET IDENTITY_INSERT [dbo].[User_Table] ON 

INSERT [dbo].[User_Table] ([User_id], [Name]) VALUES (1, N'Shivam')
INSERT [dbo].[User_Table] ([User_id], [Name]) VALUES (2, N'Shivangi')
INSERT [dbo].[User_Table] ([User_id], [Name]) VALUES (3, N'Ravi')
INSERT [dbo].[User_Table] ([User_id], [Name]) VALUES (4, N'Shikha')
INSERT [dbo].[User_Table] ([User_id], [Name]) VALUES (5, N'Pankaj')
INSERT [dbo].[User_Table] ([User_id], [Name]) VALUES (6, N'Vivek')
INSERT [dbo].[User_Table] ([User_id], [Name]) VALUES (7, N'Mohit')
INSERT [dbo].[User_Table] ([User_id], [Name]) VALUES (8, N'Rohit')
INSERT [dbo].[User_Table] ([User_id], [Name]) VALUES (9, N'Vikky')
INSERT [dbo].[User_Table] ([User_id], [Name]) VALUES (10, N'ABC')
SET IDENTITY_INSERT [dbo].[User_Table] OFF
GO
ALTER TABLE [dbo].[User_Login] ADD  CONSTRAINT [DF_User__Login_Leave]  DEFAULT ((0)) FOR [Leave]
GO
ALTER TABLE [dbo].[User_Login] ADD  CONSTRAINT [DF_User__Login_Status]  DEFAULT ((0)) FOR [Status]
GO
/****** Object:  StoredProcedure [dbo].[sp_Checkin]    Script Date: 14-07-2023 09:52:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_Checkin] 
@Checkin int=null
as
begin 
if(@Checkin=1)
	begin
	update [User_Login] set Punch_In=getdate() where Fk_Userid=1 
	select 'Check-in SuccessFully....' as msg
	end
else
	begin
		select 'Please Try Agin' as msg
	end
end
GO
/****** Object:  StoredProcedure [dbo].[sp_Details]    Script Date: 14-07-2023 09:52:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE proc [dbo].[sp_Details] 
  @action int =null
  as
  begin
  if(@action=1)
  begin
     select u.name +'  ...Not-connected' as name from User_Login ul join user_Table u on u.USER_ID=ul.Fk_Userid
  end
  end
GO
/****** Object:  StoredProcedure [dbo].[Sp_UserLogin]    Script Date: 14-07-2023 09:52:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
CREATE proc [dbo].[Sp_UserLogin]    
  @action int =null,    
@Checkin int=null,    
@Fk_Userid nvarchar(50)=null    
as    
begin    
if(@action=1)--select    
   begin    
     select u.name from User_Login ul join user_Table u on u.USER_ID=ul.Fk_Userid
   end    
else if(@action=2)--Punch-In Update    
   begin    
   update [User_Login] set Punch_In=getdate(),Status=1 where Fk_Userid=1    
   select 'Check-in SuccessFully....' as msg   
   end    
else if(@action=5)--Punch_Out Update    
   begin    
   update [User_Login] set Punch_Out=getdate(),Status=0 where Fk_Userid=1  
   select 'Check-Out SuccessFully....' as msg   
   end    
else if(@action=4)--End_Break Update    
   begin    
   update [User_Login] set End_Break=getdate() where Fk_Userid=1  
   select 'End your breck Time....' as msg   
   end    
else if(@action=3)--Lunch_Break start   
   begin    
   update [User_Login] set Lunch_Break=getdate() where Fk_Userid=1
   select 'Start Lunch Time....' as msg   
   end    
else    
   begin    
    select 'Please Try Agin' as msg    
   end    
 end  
GO
/****** Object:  StoredProcedure [dbo].[SpStatusUpdate]    Script Date: 14-07-2023 09:52:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[SpStatusUpdate]

@Status int output
as
begin
update [User_Login] set Punch_In=getdate(),Status=1 where Fk_Userid=9     
select @Status=Status from [User_Login] where Fk_Userid =9
end
GO
USE [master]
GO
ALTER DATABASE [CRM] SET  READ_WRITE 
GO
