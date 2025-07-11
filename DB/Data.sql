USE [PhanNgocAnhAssiment]
GO
/****** Object:  Table [dbo].[Departments]    Script Date: 6/23/2025 10:52:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[department_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[description] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[department_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Features]    Script Date: 6/23/2025 10:52:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Features](
	[feature_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[feature_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Request_Status]    Script Date: 6/23/2025 10:52:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Request_Status](
	[status_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](20) NOT NULL,
	[description] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[status_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Request_Status_History]    Script Date: 6/23/2025 10:52:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Request_Status_History](
	[history_id] [int] IDENTITY(1,1) NOT NULL,
	[request_id] [int] NOT NULL,
	[from_status_id] [int] NOT NULL,
	[to_status_id] [int] NOT NULL,
	[changed_by] [int] NOT NULL,
	[changed_at] [datetime2](3) NOT NULL,
	[comment] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[history_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Requests]    Script Date: 6/23/2025 10:52:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Requests](
	[request_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[title] [nvarchar](150) NULL,
	[start_date] [date] NOT NULL,
	[end_date] [date] NOT NULL,
	[reason] [nvarchar](max) NOT NULL,
	[status_id] [int] NOT NULL,
	[created_at] [datetime2](3) NOT NULL,
	[updated_at] [datetime2](3) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[request_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role_Features]    Script Date: 6/23/2025 10:52:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role_Features](
	[role_id] [int] NOT NULL,
	[feature_id] [int] NOT NULL,
 CONSTRAINT [PK_Role_Features] PRIMARY KEY CLUSTERED 
(
	[role_id] ASC,
	[feature_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 6/23/2025 10:52:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[role_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User_Roles]    Script Date: 6/23/2025 10:52:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Roles](
	[user_id] [int] NOT NULL,
	[role_id] [int] NOT NULL,
 CONSTRAINT [PK_User_Roles] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 6/23/2025 10:52:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[password_hash] [nvarchar](255) NOT NULL,
	[full_name] [nvarchar](100) NOT NULL,
	[email] [nvarchar](100) NOT NULL,
	[department_id] [int] NOT NULL,
	[manager_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Departments] ON 

INSERT [dbo].[Departments] ([department_id], [name], [description]) VALUES (1, N'HR', N'Human Resources')
INSERT [dbo].[Departments] ([department_id], [name], [description]) VALUES (2, N'Sales', N'Sales Department')
INSERT [dbo].[Departments] ([department_id], [name], [description]) VALUES (3, N'IT', N'Information Technology')
INSERT [dbo].[Departments] ([department_id], [name], [description]) VALUES (4, N'Marketing', N'Marketing Department')
INSERT [dbo].[Departments] ([department_id], [name], [description]) VALUES (5, N'Finance', N'Finance Department')
SET IDENTITY_INSERT [dbo].[Departments] OFF
GO
SET IDENTITY_INSERT [dbo].[Features] ON 

INSERT [dbo].[Features] ([feature_id], [name], [description]) VALUES (1, N'CreateRequest', N'Tạo đơn xin nghỉ phép')
INSERT [dbo].[Features] ([feature_id], [name], [description]) VALUES (2, N'ViewRequest', N'Xem đơn xin nghỉ phép')
INSERT [dbo].[Features] ([feature_id], [name], [description]) VALUES (3, N'ApproveRequest', N'Duyệt đơn xin nghỉ phép')
INSERT [dbo].[Features] ([feature_id], [name], [description]) VALUES (4, N'RejectRequest', N'Từ chối đơn xin nghỉ phép')
INSERT [dbo].[Features] ([feature_id], [name], [description]) VALUES (5, N'ViewAgenda', N'Xem agenda phòng ban')
SET IDENTITY_INSERT [dbo].[Features] OFF
GO
SET IDENTITY_INSERT [dbo].[Request_Status] ON 

INSERT [dbo].[Request_Status] ([status_id], [name], [description]) VALUES (1, N'InProgress', N'Đơn mới, chờ xử lý')
INSERT [dbo].[Request_Status] ([status_id], [name], [description]) VALUES (2, N'Approved', N'Đã duyệt')
INSERT [dbo].[Request_Status] ([status_id], [name], [description]) VALUES (3, N'Rejected', N'Đã từ chối')
SET IDENTITY_INSERT [dbo].[Request_Status] OFF
GO
SET IDENTITY_INSERT [dbo].[Request_Status_History] ON 

INSERT [dbo].[Request_Status_History] ([history_id], [request_id], [from_status_id], [to_status_id], [changed_by], [changed_at], [comment]) VALUES (1, 4, 1, 2, 4, CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2), N'Enjoy your vacation.')
INSERT [dbo].[Request_Status_History] ([history_id], [request_id], [from_status_id], [to_status_id], [changed_by], [changed_at], [comment]) VALUES (2, 5, 1, 3, 5, CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2), N'Not enough leave balance.')
INSERT [dbo].[Request_Status_History] ([history_id], [request_id], [from_status_id], [to_status_id], [changed_by], [changed_at], [comment]) VALUES (3, 9, 1, 2, 3, CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2), N'Approved.')
INSERT [dbo].[Request_Status_History] ([history_id], [request_id], [from_status_id], [to_status_id], [changed_by], [changed_at], [comment]) VALUES (4, 12, 1, 2, 5, CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2), N'Get well soon.')
INSERT [dbo].[Request_Status_History] ([history_id], [request_id], [from_status_id], [to_status_id], [changed_by], [changed_at], [comment]) VALUES (5, 17, 1, 2, 4, CAST(N'2025-06-22T08:26:16.9390000' AS DateTime2), N'Approved for maintenance')
INSERT [dbo].[Request_Status_History] ([history_id], [request_id], [from_status_id], [to_status_id], [changed_by], [changed_at], [comment]) VALUES (6, 18, 1, 2, 4, CAST(N'2025-06-22T08:26:16.9390000' AS DateTime2), N'Overtime approved')
INSERT [dbo].[Request_Status_History] ([history_id], [request_id], [from_status_id], [to_status_id], [changed_by], [changed_at], [comment]) VALUES (7, 19, 1, 3, 5, CAST(N'2025-06-22T08:26:16.9390000' AS DateTime2), N'Not enough budget for marketing')
INSERT [dbo].[Request_Status_History] ([history_id], [request_id], [from_status_id], [to_status_id], [changed_by], [changed_at], [comment]) VALUES (8, 20, 1, 2, 2, CAST(N'2025-06-22T08:26:16.9390000' AS DateTime2), N'Training session confirmed')
INSERT [dbo].[Request_Status_History] ([history_id], [request_id], [from_status_id], [to_status_id], [changed_by], [changed_at], [comment]) VALUES (9, 21, 1, 2, 3, CAST(N'2025-06-22T08:26:16.9390000' AS DateTime2), N'Presentation slot reserved')
SET IDENTITY_INSERT [dbo].[Request_Status_History] OFF
GO
SET IDENTITY_INSERT [dbo].[Requests] ON 

INSERT [dbo].[Requests] ([request_id], [user_id], [title], [start_date], [end_date], [reason], [status_id], [created_at], [updated_at]) VALUES (1, 7, N'Vacation', CAST(N'2025-06-01' AS Date), CAST(N'2025-06-05' AS Date), N'Family trip', 1, CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2), CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2))
INSERT [dbo].[Requests] ([request_id], [user_id], [title], [start_date], [end_date], [reason], [status_id], [created_at], [updated_at]) VALUES (2, 8, N'Medical Leave', CAST(N'2025-06-10' AS Date), CAST(N'2025-06-12' AS Date), N'Sick leave', 1, CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2), CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2))
INSERT [dbo].[Requests] ([request_id], [user_id], [title], [start_date], [end_date], [reason], [status_id], [created_at], [updated_at]) VALUES (3, 9, N'Conference', CAST(N'2025-07-15' AS Date), CAST(N'2025-07-17' AS Date), N'Attend tech conference', 1, CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2), CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2))
INSERT [dbo].[Requests] ([request_id], [user_id], [title], [start_date], [end_date], [reason], [status_id], [created_at], [updated_at]) VALUES (4, 10, N'Annual Leave', CAST(N'2025-06-20' AS Date), CAST(N'2025-06-25' AS Date), N'Summer vacation', 2, CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2), CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2))
INSERT [dbo].[Requests] ([request_id], [user_id], [title], [start_date], [end_date], [reason], [status_id], [created_at], [updated_at]) VALUES (5, 11, N'Personal Leave', CAST(N'2025-08-01' AS Date), CAST(N'2025-08-03' AS Date), N'Personal matters', 3, CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2), CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2))
INSERT [dbo].[Requests] ([request_id], [user_id], [title], [start_date], [end_date], [reason], [status_id], [created_at], [updated_at]) VALUES (6, 12, N'Study Leave', CAST(N'2025-09-05' AS Date), CAST(N'2025-09-10' AS Date), N'Training program', 1, CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2), CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2))
INSERT [dbo].[Requests] ([request_id], [user_id], [title], [start_date], [end_date], [reason], [status_id], [created_at], [updated_at]) VALUES (7, 13, N'Jury Duty', CAST(N'2025-10-01' AS Date), CAST(N'2025-10-03' AS Date), N'Jury service', 1, CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2), CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2))
INSERT [dbo].[Requests] ([request_id], [user_id], [title], [start_date], [end_date], [reason], [status_id], [created_at], [updated_at]) VALUES (8, 7, N'Vacation 2', CAST(N'2025-07-01' AS Date), CAST(N'2025-07-07' AS Date), N'Family event', 1, CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2), CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2))
INSERT [dbo].[Requests] ([request_id], [user_id], [title], [start_date], [end_date], [reason], [status_id], [created_at], [updated_at]) VALUES (9, 8, N'Medical Leave 2', CAST(N'2025-08-10' AS Date), CAST(N'2025-08-12' AS Date), N'Flu', 2, CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2), CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2))
INSERT [dbo].[Requests] ([request_id], [user_id], [title], [start_date], [end_date], [reason], [status_id], [created_at], [updated_at]) VALUES (10, 9, N'Project Leave', CAST(N'2025-07-01' AS Date), CAST(N'2025-07-03' AS Date), N'Client meeting', 1, CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2), CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2))
INSERT [dbo].[Requests] ([request_id], [user_id], [title], [start_date], [end_date], [reason], [status_id], [created_at], [updated_at]) VALUES (11, 10, N'Annual Leave 2', CAST(N'2025-12-20' AS Date), CAST(N'2025-12-31' AS Date), N'Winter break', 1, CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2), CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2))
INSERT [dbo].[Requests] ([request_id], [user_id], [title], [start_date], [end_date], [reason], [status_id], [created_at], [updated_at]) VALUES (12, 11, N'Sick Leave', CAST(N'2025-11-01' AS Date), CAST(N'2025-11-03' AS Date), N'Health', 2, CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2), CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2))
INSERT [dbo].[Requests] ([request_id], [user_id], [title], [start_date], [end_date], [reason], [status_id], [created_at], [updated_at]) VALUES (13, 12, N'Study Leave 2', CAST(N'2025-09-15' AS Date), CAST(N'2025-09-20' AS Date), N'Course', 1, CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2), CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2))
INSERT [dbo].[Requests] ([request_id], [user_id], [title], [start_date], [end_date], [reason], [status_id], [created_at], [updated_at]) VALUES (14, 13, N'Jury Duty 2', CAST(N'2025-10-15' AS Date), CAST(N'2025-10-17' AS Date), N'Jury service', 1, CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2), CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2))
INSERT [dbo].[Requests] ([request_id], [user_id], [title], [start_date], [end_date], [reason], [status_id], [created_at], [updated_at]) VALUES (15, 7, N'Family Event', CAST(N'2025-12-24' AS Date), CAST(N'2025-12-26' AS Date), N'Family reunion', 1, CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2), CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2))
INSERT [dbo].[Requests] ([request_id], [user_id], [title], [start_date], [end_date], [reason], [status_id], [created_at], [updated_at]) VALUES (16, 8, N'Medical Leave 3', CAST(N'2025-09-05' AS Date), CAST(N'2025-09-07' AS Date), N'Surgery', 1, CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2), CAST(N'2025-06-22T08:22:43.1200000' AS DateTime2))
INSERT [dbo].[Requests] ([request_id], [user_id], [title], [start_date], [end_date], [reason], [status_id], [created_at], [updated_at]) VALUES (17, 14, N'Server Maintenance', CAST(N'2025-07-10' AS Date), CAST(N'2025-07-12' AS Date), N'Support server upgrade', 1, CAST(N'2025-06-22T08:26:16.9390000' AS DateTime2), CAST(N'2025-06-22T08:26:16.9390000' AS DateTime2))
INSERT [dbo].[Requests] ([request_id], [user_id], [title], [start_date], [end_date], [reason], [status_id], [created_at], [updated_at]) VALUES (18, 15, N'Overtime', CAST(N'2025-07-05' AS Date), CAST(N'2025-07-06' AS Date), N'End of quarter tasks', 2, CAST(N'2025-06-22T08:26:16.9390000' AS DateTime2), CAST(N'2025-06-22T08:26:16.9390000' AS DateTime2))
INSERT [dbo].[Requests] ([request_id], [user_id], [title], [start_date], [end_date], [reason], [status_id], [created_at], [updated_at]) VALUES (19, 16, N'Marketing Brief', CAST(N'2025-08-01' AS Date), CAST(N'2025-08-03' AS Date), N'Prepare marketing plan', 3, CAST(N'2025-06-22T08:26:16.9390000' AS DateTime2), CAST(N'2025-06-22T08:26:16.9390000' AS DateTime2))
INSERT [dbo].[Requests] ([request_id], [user_id], [title], [start_date], [end_date], [reason], [status_id], [created_at], [updated_at]) VALUES (20, 17, N'Sales Training', CAST(N'2025-09-15' AS Date), CAST(N'2025-09-17' AS Date), N'Attend sales training program', 1, CAST(N'2025-06-22T08:26:16.9390000' AS DateTime2), CAST(N'2025-06-22T08:26:16.9390000' AS DateTime2))
INSERT [dbo].[Requests] ([request_id], [user_id], [title], [start_date], [end_date], [reason], [status_id], [created_at], [updated_at]) VALUES (21, 18, N'Client Presentation', CAST(N'2025-10-10' AS Date), CAST(N'2025-10-11' AS Date), N'Present to major client', 1, CAST(N'2025-06-22T08:26:16.9390000' AS DateTime2), CAST(N'2025-06-22T08:26:16.9390000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Requests] OFF
GO
INSERT [dbo].[Role_Features] ([role_id], [feature_id]) VALUES (1, 1)
INSERT [dbo].[Role_Features] ([role_id], [feature_id]) VALUES (1, 2)
INSERT [dbo].[Role_Features] ([role_id], [feature_id]) VALUES (2, 2)
INSERT [dbo].[Role_Features] ([role_id], [feature_id]) VALUES (2, 3)
INSERT [dbo].[Role_Features] ([role_id], [feature_id]) VALUES (2, 4)
INSERT [dbo].[Role_Features] ([role_id], [feature_id]) VALUES (2, 5)
INSERT [dbo].[Role_Features] ([role_id], [feature_id]) VALUES (3, 1)
INSERT [dbo].[Role_Features] ([role_id], [feature_id]) VALUES (3, 2)
INSERT [dbo].[Role_Features] ([role_id], [feature_id]) VALUES (3, 3)
INSERT [dbo].[Role_Features] ([role_id], [feature_id]) VALUES (3, 4)
INSERT [dbo].[Role_Features] ([role_id], [feature_id]) VALUES (3, 5)
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([role_id], [name], [description]) VALUES (1, N'Employee', N'Nhân viên bình thường')
INSERT [dbo].[Roles] ([role_id], [name], [description]) VALUES (2, N'Manager', N'Quản lý cấp trực tiếp')
INSERT [dbo].[Roles] ([role_id], [name], [description]) VALUES (3, N'Admin', N'Quản trị hệ thống')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
INSERT [dbo].[User_Roles] ([user_id], [role_id]) VALUES (1, 3)
INSERT [dbo].[User_Roles] ([user_id], [role_id]) VALUES (2, 2)
INSERT [dbo].[User_Roles] ([user_id], [role_id]) VALUES (3, 2)
INSERT [dbo].[User_Roles] ([user_id], [role_id]) VALUES (4, 2)
INSERT [dbo].[User_Roles] ([user_id], [role_id]) VALUES (5, 2)
INSERT [dbo].[User_Roles] ([user_id], [role_id]) VALUES (6, 2)
INSERT [dbo].[User_Roles] ([user_id], [role_id]) VALUES (7, 1)
INSERT [dbo].[User_Roles] ([user_id], [role_id]) VALUES (8, 1)
INSERT [dbo].[User_Roles] ([user_id], [role_id]) VALUES (9, 1)
INSERT [dbo].[User_Roles] ([user_id], [role_id]) VALUES (10, 1)
INSERT [dbo].[User_Roles] ([user_id], [role_id]) VALUES (11, 1)
INSERT [dbo].[User_Roles] ([user_id], [role_id]) VALUES (12, 1)
INSERT [dbo].[User_Roles] ([user_id], [role_id]) VALUES (13, 1)
INSERT [dbo].[User_Roles] ([user_id], [role_id]) VALUES (14, 1)
INSERT [dbo].[User_Roles] ([user_id], [role_id]) VALUES (15, 1)
INSERT [dbo].[User_Roles] ([user_id], [role_id]) VALUES (16, 1)
INSERT [dbo].[User_Roles] ([user_id], [role_id]) VALUES (17, 1)
INSERT [dbo].[User_Roles] ([user_id], [role_id]) VALUES (18, 1)
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([user_id], [username], [password_hash], [full_name], [email], [department_id], [manager_id]) VALUES (1, N'admin', N'admin', N'System Admin', N'admin@example.com', 1, NULL)
INSERT [dbo].[Users] ([user_id], [username], [password_hash], [full_name], [email], [department_id], [manager_id]) VALUES (2, N'alice', N'alice', N'Alice Nguyen', N'alice@example.com', 2, 1)
INSERT [dbo].[Users] ([user_id], [username], [password_hash], [full_name], [email], [department_id], [manager_id]) VALUES (3, N'bob', N'hash_bob', N'Bob Tran', N'bob@example.com', 2, 1)
INSERT [dbo].[Users] ([user_id], [username], [password_hash], [full_name], [email], [department_id], [manager_id]) VALUES (4, N'charlie', N'hash_charlie', N'Charlie Le', N'charlie@example.com', 3, 1)
INSERT [dbo].[Users] ([user_id], [username], [password_hash], [full_name], [email], [department_id], [manager_id]) VALUES (5, N'david', N'hash_david', N'David Pham', N'david@example.com', 4, 1)
INSERT [dbo].[Users] ([user_id], [username], [password_hash], [full_name], [email], [department_id], [manager_id]) VALUES (6, N'eva', N'hash_eva', N'Eva Ho', N'eva@example.com', 5, 1)
INSERT [dbo].[Users] ([user_id], [username], [password_hash], [full_name], [email], [department_id], [manager_id]) VALUES (7, N'user1', N'hash_user1', N'User One', N'user1@example.com', 2, 2)
INSERT [dbo].[Users] ([user_id], [username], [password_hash], [full_name], [email], [department_id], [manager_id]) VALUES (8, N'user2', N'hash_user2', N'User Two', N'user2@example.com', 2, 3)
INSERT [dbo].[Users] ([user_id], [username], [password_hash], [full_name], [email], [department_id], [manager_id]) VALUES (9, N'user3', N'hash_user3', N'User Three', N'user3@example.com', 3, 4)
INSERT [dbo].[Users] ([user_id], [username], [password_hash], [full_name], [email], [department_id], [manager_id]) VALUES (10, N'user4', N'hash_user4', N'User Four', N'user4@example.com', 3, 4)
INSERT [dbo].[Users] ([user_id], [username], [password_hash], [full_name], [email], [department_id], [manager_id]) VALUES (11, N'user5', N'hash_user5', N'User Five', N'user5@example.com', 4, 5)
INSERT [dbo].[Users] ([user_id], [username], [password_hash], [full_name], [email], [department_id], [manager_id]) VALUES (12, N'user6', N'hash_user6', N'User Six', N'user6@example.com', 5, 6)
INSERT [dbo].[Users] ([user_id], [username], [password_hash], [full_name], [email], [department_id], [manager_id]) VALUES (13, N'user7', N'hash_user7', N'User Seven', N'user7@example.com', 1, 1)
INSERT [dbo].[Users] ([user_id], [username], [password_hash], [full_name], [email], [department_id], [manager_id]) VALUES (14, N'frank', N'hash_frank', N'Frank Nguyen', N'frank@example.com', 3, 4)
INSERT [dbo].[Users] ([user_id], [username], [password_hash], [full_name], [email], [department_id], [manager_id]) VALUES (15, N'george', N'hash_george', N'George Minh', N'george@example.com', 4, 5)
INSERT [dbo].[Users] ([user_id], [username], [password_hash], [full_name], [email], [department_id], [manager_id]) VALUES (16, N'helen', N'hash_helen', N'Helen Tran', N'helen@example.com', 4, 5)
INSERT [dbo].[Users] ([user_id], [username], [password_hash], [full_name], [email], [department_id], [manager_id]) VALUES (17, N'ian', N'hash_ian', N'Ian Le', N'ian@example.com', 2, 2)
INSERT [dbo].[Users] ([user_id], [username], [password_hash], [full_name], [email], [department_id], [manager_id]) VALUES (18, N'julia', N'hash_julia', N'Julia Pham', N'julia@example.com', 2, 3)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Departments_Name]    Script Date: 6/23/2025 10:52:40 AM ******/
ALTER TABLE [dbo].[Departments] ADD  CONSTRAINT [UQ_Departments_Name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Features_Name]    Script Date: 6/23/2025 10:52:40 AM ******/
ALTER TABLE [dbo].[Features] ADD  CONSTRAINT [UQ_Features_Name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Request_Status_Name]    Script Date: 6/23/2025 10:52:40 AM ******/
ALTER TABLE [dbo].[Request_Status] ADD  CONSTRAINT [UQ_Request_Status_Name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Roles_Name]    Script Date: 6/23/2025 10:52:40 AM ******/
ALTER TABLE [dbo].[Roles] ADD  CONSTRAINT [UQ_Roles_Name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Users_Email]    Script Date: 6/23/2025 10:52:40 AM ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [UQ_Users_Email] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Users_Username]    Script Date: 6/23/2025 10:52:40 AM ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [UQ_Users_Username] UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Request_Status_History] ADD  CONSTRAINT [DF_RSH_ChangedAt]  DEFAULT (sysutcdatetime()) FOR [changed_at]
GO
ALTER TABLE [dbo].[Requests] ADD  CONSTRAINT [DF_Requests_Status]  DEFAULT ((1)) FOR [status_id]
GO
ALTER TABLE [dbo].[Requests] ADD  CONSTRAINT [DF_Requests_CreatedAt]  DEFAULT (sysutcdatetime()) FOR [created_at]
GO
ALTER TABLE [dbo].[Requests] ADD  CONSTRAINT [DF_Requests_UpdatedAt]  DEFAULT (sysutcdatetime()) FOR [updated_at]
GO
ALTER TABLE [dbo].[Request_Status_History]  WITH CHECK ADD  CONSTRAINT [FK_RSH_ChangedBy] FOREIGN KEY([changed_by])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Request_Status_History] CHECK CONSTRAINT [FK_RSH_ChangedBy]
GO
ALTER TABLE [dbo].[Request_Status_History]  WITH CHECK ADD  CONSTRAINT [FK_RSH_FromStatus] FOREIGN KEY([from_status_id])
REFERENCES [dbo].[Request_Status] ([status_id])
GO
ALTER TABLE [dbo].[Request_Status_History] CHECK CONSTRAINT [FK_RSH_FromStatus]
GO
ALTER TABLE [dbo].[Request_Status_History]  WITH CHECK ADD  CONSTRAINT [FK_RSH_Request] FOREIGN KEY([request_id])
REFERENCES [dbo].[Requests] ([request_id])
GO
ALTER TABLE [dbo].[Request_Status_History] CHECK CONSTRAINT [FK_RSH_Request]
GO
ALTER TABLE [dbo].[Request_Status_History]  WITH CHECK ADD  CONSTRAINT [FK_RSH_ToStatus] FOREIGN KEY([to_status_id])
REFERENCES [dbo].[Request_Status] ([status_id])
GO
ALTER TABLE [dbo].[Request_Status_History] CHECK CONSTRAINT [FK_RSH_ToStatus]
GO
ALTER TABLE [dbo].[Requests]  WITH CHECK ADD  CONSTRAINT [FK_Requests_Status] FOREIGN KEY([status_id])
REFERENCES [dbo].[Request_Status] ([status_id])
GO
ALTER TABLE [dbo].[Requests] CHECK CONSTRAINT [FK_Requests_Status]
GO
ALTER TABLE [dbo].[Requests]  WITH CHECK ADD  CONSTRAINT [FK_Requests_User] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Requests] CHECK CONSTRAINT [FK_Requests_User]
GO
ALTER TABLE [dbo].[Role_Features]  WITH CHECK ADD  CONSTRAINT [FK_RF_Feature] FOREIGN KEY([feature_id])
REFERENCES [dbo].[Features] ([feature_id])
GO
ALTER TABLE [dbo].[Role_Features] CHECK CONSTRAINT [FK_RF_Feature]
GO
ALTER TABLE [dbo].[Role_Features]  WITH CHECK ADD  CONSTRAINT [FK_RF_Role] FOREIGN KEY([role_id])
REFERENCES [dbo].[Roles] ([role_id])
GO
ALTER TABLE [dbo].[Role_Features] CHECK CONSTRAINT [FK_RF_Role]
GO
ALTER TABLE [dbo].[User_Roles]  WITH CHECK ADD  CONSTRAINT [FK_UR_Role] FOREIGN KEY([role_id])
REFERENCES [dbo].[Roles] ([role_id])
GO
ALTER TABLE [dbo].[User_Roles] CHECK CONSTRAINT [FK_UR_Role]
GO
ALTER TABLE [dbo].[User_Roles]  WITH CHECK ADD  CONSTRAINT [FK_UR_User] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[User_Roles] CHECK CONSTRAINT [FK_UR_User]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Department] FOREIGN KEY([department_id])
REFERENCES [dbo].[Departments] ([department_id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Department]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Manager] FOREIGN KEY([manager_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Manager]
GO

-- Thêm nhân viên cấp dưới cho Alice (user_id = 2)
INSERT INTO Users (username, password_hash, full_name, email, department_id, manager_id)
VALUES (N'nhanvien1', N'123', N'Nguyễn Văn A', N'a@example.com', 2, 2);
GO
-- Gán role nhân viên cho user mới (giả sử role_id = 1 là Employee)
INSERT INTO User_Roles (user_id, role_id)
VALUES ((SELECT user_id FROM Users WHERE username = N'nhanvien1'), 1);
GO
-- Thêm đơn nghỉ phép cho nhân viên này
DECLARE @nv1 INT = (SELECT user_id FROM Users WHERE username = N'nhanvien1');
INSERT INTO Requests (user_id, title, start_date, end_date, reason, status_id, created_at, updated_at)
VALUES (@nv1, N'Nghỉ phép năm', '2025-07-01', '2025-07-05', N'Nghỉ phép thường niên', 1, GETDATE(), GETDATE());
GO
