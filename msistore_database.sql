USE master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'msistoredb')
BEGIN
    ALTER DATABASE msistoredb SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE msistoredb;
END;
GO

CREATE DATABASE msistoredb;
GO

USE msistoredb;
GO

CREATE SCHEMA msistoredb;
GO

-- Bảng user
CREATE TABLE msistoredb.[user] (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(50) NOT NULL UNIQUE,
    password NVARCHAR(100) NOT NULL,
    DateJoined DATETIME2 DEFAULT GETDATE()
);

-- Bảng brand
CREATE TABLE msistoredb.brand (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL
);

-- Bảng category
CREATE TABLE msistoredb.category (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL
);

-- Bảng product (gộp trường hình ảnh)
CREATE TABLE [msistoredb].[product](
	[id] [bigint] IDENTITY(17,1) NOT NULL,
	[CreatedAt] [date] NULL,
	[UpdatedAt] [date] NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](200) NOT NULL,
	[Detail] [nvarchar](max) NOT NULL,
	[OldPrice] [decimal](6, 2) NOT NULL,
	[NewPrice] [decimal](6, 2) NOT NULL,
	[brand_id] [bigint] NULL,
	[CategoryId] [bigint] NULL,
 CONSTRAINT [PK_ProductId] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [msistoredb].[role]    Script Date: 5/28/2024 12:52:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Bảng order
CREATE TABLE [msistoredb].[order](
	[id] [bigint] IDENTITY(78,1) NOT NULL,
	[CreatedAt] [date] NULL,
	[UpdatedAt] [date] NULL,
	[UserId] [bigint] NULL,
 CONSTRAINT [PK_OrderId] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [msistoredb].[orderitem]    Script Date: 5/28/2024 12:52:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Bảng order_item
CREATE TABLE [msistoredb].[orderitem](
	[id] [bigint] IDENTITY(37,1) NOT NULL,
	[Quantity] [bigint] NOT NULL,
	[OrderId] [bigint] NOT NULL,
	[ProductId] [bigint] NOT NULL,
	[UnitPrice] [money] NOT NULL,
 CONSTRAINT [PK_orderitem_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [msistoredb].[product]    Script Date: 5/28/2024 12:52:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Bảng feedback
CREATE TABLE [msistoredb].[feedback](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[user_id] [bigint] NULL,
	[order_id] [bigint] NULL,
	[comment] [nvarchar](200) NULL,
	[createdAt] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [msistoredb].[image]    Script Date: 5/28/2024 12:52:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


SET IDENTITY_INSERT [msistoredb].[brand] ON 

INSERT [msistoredb].[brand] ([id], [Name]) VALUES (1, N'msi')
INSERT [msistoredb].[brand] ([id], [Name]) VALUES (2, N'razer')
INSERT [msistoredb].[brand] ([id], [Name]) VALUES (3, N'hp')
INSERT [msistoredb].[brand] ([id], [Name]) VALUES (4, N'gigabyte')
SET IDENTITY_INSERT [msistoredb].[brand] OFF
GO
SET IDENTITY_INSERT [msistoredb].[category] ON 

INSERT [msistoredb].[category] ([id], [Name]) VALUES (1, N'Laptops')
INSERT [msistoredb].[category] ([id], [Name]) VALUES (2, N'Desktop PC')
INSERT [msistoredb].[category] ([id], [Name]) VALUES (3, N'Netwoking Devices')
INSERT [msistoredb].[category] ([id], [Name]) VALUES (4, N'Printers & Scanners')
INSERT [msistoredb].[category] ([id], [Name]) VALUES (5, N'PC Parts')
INSERT [msistoredb].[category] ([id], [Name]) VALUES (6, N'Laptop Gaming')
INSERT [msistoredb].[category] ([id], [Name]) VALUES (7, N'Monitors')
SET IDENTITY_INSERT [msistoredb].[category] OFF
GO

SET IDENTITY_INSERT [msistoredb].[feedback] ON 

INSERT [msistoredb].[feedback] ([id], [user_id], [order_id], [comment], [createdAt]) VALUES (1, 25, 81, N'Very good', CAST(N'2024-05-24' AS Date))
INSERT [msistoredb].[feedback] ([id], [user_id], [order_id], [comment], [createdAt]) VALUES (2, 25, 79, N'Nice', CAST(N'2024-05-24' AS Date))
INSERT [msistoredb].[feedback] ([id], [user_id], [order_id], [comment], [createdAt]) VALUES (3, 25, 78, N'Awsome', CAST(N'2024-05-26' AS Date))
SET IDENTITY_INSERT [msistoredb].[feedback] OFF
GO


SET IDENTITY_INSERT [msistoredb].[order] ON 

INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (65, CAST(N'2024-03-01' AS Date), CAST(N'2024-01-03' AS Date), 6)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (66, CAST(N'2024-03-01' AS Date), CAST(N'2024-01-03' AS Date), 6)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (67, CAST(N'2024-03-01' AS Date), CAST(N'2024-01-03' AS Date), 6)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (74, CAST(N'2024-06-01' AS Date), CAST(N'2024-01-06' AS Date), 9)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (75, CAST(N'2024-06-01' AS Date), CAST(N'2024-01-06' AS Date), 9)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (76, CAST(N'2024-06-01' AS Date), CAST(N'2024-01-06' AS Date), 9)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (77, CAST(N'2024-06-01' AS Date), CAST(N'2024-01-06' AS Date), 9)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (78, CAST(N'2024-05-23' AS Date), CAST(N'2024-05-23' AS Date), 25)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (79, CAST(N'2024-05-23' AS Date), CAST(N'2024-05-23' AS Date), 25)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (80, CAST(N'2024-05-23' AS Date), CAST(N'2024-05-23' AS Date), 25)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (81, CAST(N'2024-05-23' AS Date), CAST(N'2024-05-23' AS Date), 25)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (82, CAST(N'2024-05-23' AS Date), CAST(N'2024-05-23' AS Date), 25)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (83, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 31)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (84, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 31)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (85, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 31)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (86, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 31)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (87, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 31)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (88, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 29)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (89, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 29)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (92, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 29)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (93, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 29)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (94, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 29)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (95, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 29)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (96, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 29)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (97, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 29)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (98, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 29)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (99, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 29)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (100, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 29)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (101, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 29)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (102, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 29)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (103, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 29)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (104, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 29)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (105, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 29)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (106, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 29)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (107, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 29)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (108, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 29)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (109, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 29)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (110, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 29)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (111, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 29)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (112, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 29)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (113, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 29)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (114, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 29)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (115, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 29)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (116, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 29)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (117, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 29)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (118, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 29)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (119, CAST(N'2024-05-25' AS Date), CAST(N'2024-05-25' AS Date), 29)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (120, CAST(N'2024-05-25' AS Date), CAST(N'2024-05-25' AS Date), 29)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (121, CAST(N'2024-05-25' AS Date), CAST(N'2024-05-25' AS Date), 29)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (122, CAST(N'2024-05-25' AS Date), CAST(N'2024-05-25' AS Date), 25)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (123, CAST(N'2024-05-25' AS Date), CAST(N'2024-05-25' AS Date), 28)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (124, CAST(N'2024-05-25' AS Date), CAST(N'2024-05-25' AS Date), 28)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (125, CAST(N'2024-05-25' AS Date), CAST(N'2024-05-25' AS Date), 28)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (126, CAST(N'2024-05-25' AS Date), CAST(N'2024-05-25' AS Date), 25)
INSERT [msistoredb].[order] ([id], [CreatedAt], [UpdatedAt], [UserId]) VALUES (127, CAST(N'2024-05-25' AS Date), CAST(N'2024-05-25' AS Date), 25)
SET IDENTITY_INSERT [msistoredb].[order] OFF
GO

SET IDENTITY_INSERT [msistoredb].[orderitem] ON 

INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (33, 1, 74, 3, 0.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (34, 1, 75, 5, 0.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (35, 1, 76, 3, 0.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (36, 1, 77, 3, 0.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (37, 6, 78, 7, 2854.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (38, 6, 79, 7, 2854.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (39, 6, 80, 7, 2854.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (40, 6, 81, 7, 2854.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (41, 6, 82, 7, 2854.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (42, 1, 83, 3, 499.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (43, 1, 83, 3, 499.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (44, 1, 83, 4, 3080.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (45, 1, 84, 3, 499.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (46, 1, 84, 3, 499.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (47, 1, 84, 4, 3080.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (48, 1, 85, 3, 499.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (49, 1, 85, 3, 499.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (50, 1, 85, 4, 3080.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (51, 1, 86, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (52, 1, 86, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (53, 1, 86, 10, 2580.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (54, 1, 87, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (55, 1, 87, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (56, 1, 87, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (57, 1, 87, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (58, 1, 87, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (59, 1, 87, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (60, 1, 87, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (61, 1, 87, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (62, 1, 87, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (63, 1, 87, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (64, 1, 87, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (65, 1, 87, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (66, 1, 87, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (67, 1, 87, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (68, 1, 87, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (69, 1, 87, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (70, 1, 87, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (71, 1, 87, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (72, 1, 87, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (73, 1, 87, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (74, 1, 88, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (75, 1, 88, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (76, 1, 88, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (77, 1, 88, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (78, 1, 88, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (79, 1, 88, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (80, 1, 88, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (81, 1, 88, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (82, 1, 88, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (83, 1, 88, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (84, 1, 88, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (85, 1, 88, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (86, 1, 88, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (87, 1, 88, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (88, 1, 88, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (89, 1, 88, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (90, 1, 88, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (91, 1, 88, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (92, 1, 88, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (93, 1, 88, 9, 1980.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (94, 1, 89, 3, 499.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (95, 1, 89, 3, 499.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (100, 1, 92, 3, 499.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (101, 1, 93, 3, 499.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (102, 1, 94, 4, 3080.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (103, 1, 95, 4, 3080.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (104, 1, 96, 3, 499.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (105, 1, 97, 3, 499.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (106, 1, 98, 4, 3080.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (107, 1, 99, 4, 3080.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (108, 1, 100, 3, 499.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (109, 1, 101, 3, 499.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (110, 1, 102, 4, 3080.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (111, 1, 103, 4, 3080.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (112, 1, 104, 3, 499.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (113, 1, 105, 3, 499.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (114, 1, 106, 4, 3080.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (115, 1, 107, 4, 3080.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (116, 1, 108, 3, 499.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (117, 1, 109, 3, 499.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (118, 1, 110, 4, 3080.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (119, 1, 111, 4, 3080.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (120, 1, 112, 3, 499.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (121, 1, 112, 3, 499.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (122, 1, 112, 4, 3080.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (123, 1, 112, 4, 3080.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (124, 1, 113, 5, 3000.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (125, 1, 113, 5, 3000.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (126, 1, 113, 6, 2750.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (127, 1, 114, 5, 3000.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (128, 1, 114, 5, 3000.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (129, 1, 114, 6, 2750.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (130, 1, 115, 5, 3000.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (131, 1, 115, 5, 3000.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (132, 1, 115, 6, 2750.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (133, 1, 116, 5, 3000.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (134, 1, 116, 5, 3000.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (135, 1, 116, 6, 2750.0000)
GO
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (136, 1, 117, 5, 3000.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (137, 1, 117, 5, 3000.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (138, 1, 118, 5, 3000.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (139, 1, 118, 5, 3000.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (140, 1, 119, 5, 3000.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (141, 1, 119, 5, 3000.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (142, 1, 120, 4, 3080.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (143, 1, 120, 4, 3080.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (144, 1, 121, 4, 3080.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (145, 1, 121, 4, 3080.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (146, 1, 122, 5, 3000.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (147, 1, 123, 6, 2750.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (148, 1, 124, 6, 2750.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (149, 1, 125, 6, 2750.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (150, 1, 125, 8, 2200.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (151, 1, 126, 5, 3000.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (152, 1, 126, 5, 3000.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (153, 1, 126, 5, 3000.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (154, 1, 126, 5, 3000.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (155, 1, 127, 6, 2750.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (156, 1, 127, 6, 2750.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (157, 1, 127, 6, 2750.0000)
INSERT [msistoredb].[orderitem] ([id], [Quantity], [OrderId], [ProductId], [UnitPrice]) VALUES (158, 1, 127, 6, 2750.0000)
SET IDENTITY_INSERT [msistoredb].[orderitem] OFF
GO


SET IDENTITY_INSERT [msistoredb].[product] ON 

INSERT [msistoredb].[product] ([id], [CreatedAt], [UpdatedAt], [Name], [Description], [Detail], [OldPrice], [NewPrice], [brand_id], [CategoryId]) VALUES (3, CAST(N'2023-11-10' AS Date), CAST(N'2023-11-10' AS Date), N'GS66 Stealth', N'GS66 Stealth 11UG - 210VN 15.6 FHD (1920x1080), 300Hz, xấp xỉ 100%sRGB NVIDIA® GeForce RTX™ 3070 Laptop 8GB GDDR6 boost tối đa 1410MHz,', N'["Windows 10 Home", "15.6''FHD (1920x1080), 300Hz, xấp xỉ 100%sRGB", "Intel® Core™ i7-11800H", "2TB NVMe PCIe Gen4x4 SSD", "Killer 2.5Gb LAN", "Killer Wi-Fi 6E AX1675", "Bluetooth v5.2", "1x (8K @ 60Hz / 4K @ 120Hz) HDMI"]', CAST(600.00 AS Decimal(6, 2)), CAST(499.00 AS Decimal(6, 2)), 1, 1)
INSERT [msistoredb].[product] ([id], [CreatedAt], [UpdatedAt], [Name], [Description], [Detail], [OldPrice], [NewPrice], [brand_id], [CategoryId]) VALUES (4, CAST(N'2023-11-20' AS Date), CAST(N'2023-11-20' AS Date), N'Stealth 16 Mercedes-AMG Motorsport', N'Vi xử lí Intel® Core™ i9-13900H thế hệ 13. Windows 11 Home (MSI khuyến nghị Windows 11 Pro cho doanh nghiệp.) Card đồ họa GeForce RTX™ 4070 Laptop 8GB GDDR6 mới nhất. Laptop đạt chuẩn NVIDIA® GeForce', N'["Vi xử lí Intel® Core™ i9-13900H thế hệ 13.", "Windows 11 Home (MSI khuyến nghị Windows 11 Pro cho doanh nghiệp.)", "Card đồ họa GeForce RTX™ 4070 Laptop 8GB GDDR6 mới nhất.", "Laptop đạt chuẩn NVIDIA® GeForce RTX™ Studio.", "Chế độ chỉ sử dụng card đồ họa rời giúp tận dụng tối đa hiệu năng GPU.", "Thân máy làm từ chất liệu hợp kim Nhôm/Magie", "Màn hình 16'' UHD+ (3840 x 2400), 16:10, 100% DCI-P3 (Typ.), OLED.", "Siêu nhẹ và siêu mỏng, chỉ 1.88kg & 19.95mm.", "Hệ thống 6 loa thành phần của Dynaudio.", "Cooler Boost 5 với 2 quạt + 5 ống dẫn nhiệt.", "Webcam IR FHD với cần gạt che webcam.", "Bàn phím chơi game đèn nền RGB per-key của SteelSeries.", "Pin dung lượng 99.9Whr."]', CAST(3285.00 AS Decimal(6, 2)), CAST(3080.00 AS Decimal(6, 2)), 1, 6)
INSERT [msistoredb].[product] ([id], [CreatedAt], [UpdatedAt], [Name], [Description], [Detail], [OldPrice], [NewPrice], [brand_id], [CategoryId]) VALUES (5, CAST(N'2023-11-20' AS Date), CAST(N'2023-11-20' AS Date), N'Stealth GS66 - 12U', N'Vi xử lí Intel® Core™ thế hệ 12 / card đồ họa GeForce RTX™ 30 series', N'["Vi xử lí Intel® Core™ i7 thế hệ 12 mới nhất", "Windows 11 Home", "(MSI khuyến cáo sử dụng Windows 11 Pro cho doanh nghiệp.)", "Card đồ họa GeForce RTX™ 3070 Ti Laptop 8GB GDDR6", "Màn hình 15.6“QHD (2560x1440), 240 Hz, 100% DCI-P3(Typical), IPS-Level", "Tản nhiệt Cooler Boost Trinity+ với cánh quạt mỏng chỉ 0.1mm", "Pin dung lượng siêu lớn 99.9Whr", "Bàn phím chơi game đèn nền Per-Key RGB của SteelSeries", "Phần mềm MSI Center với tính năng Gaming mode độc quyền"]', CAST(3348.00 AS Decimal(6, 2)), CAST(3000.00 AS Decimal(6, 2)), 1, 6)
INSERT [msistoredb].[product] ([id], [CreatedAt], [UpdatedAt], [Name], [Description], [Detail], [OldPrice], [NewPrice], [brand_id], [CategoryId]) VALUES (6, CAST(N'2023-11-20' AS Date), CAST(N'2023-11-20' AS Date), N'Stealth 16 Studio A13V', N'Vi xử lí Intel® Core™ thế hệ 13 / card đồ họa GeForce RTX™ 40 Series', N'["Vi xử lí tối đa tới Intel® Core™ i9-13900H thế hệ 13.", "Windows 11 Home", "(MSI khuyến nghị Windows 11 Pro cho doanh nghiệp.)", "Card đồ họa tối đa tới GeForce RTX™ 4070 Laptop 8GB GDDR6.", "Laptop đạt chuẩn NVIDIA® GeForce RTX™ Studio", "Chế độ chỉ sử dụng card đồ họa rời (MUX) giúp tận dụng tối đa hiệu năng GPU.", "Thân máy làm từ chất liệu hợp kim Nhôm/Magie.", "Màn hình 16'' UHD+(3840 x 2400), 16:10, tần số quét 120Hz, 100% DCI-P3 (Typ.), IPS-level.", "Nhẹ và mỏng, chỉ 1.99kg & 19.95mm.", "Hệ thống 6 loa thành phần của Dynaudio.", "Cooler Boost 5 với 2 quạt + 5 ống dẫn nhiệt.", "Webcam IR FHD với cần gạt che webcam.", "Bàn phím chơi game đèn nền RGB per-key của SteelSeries.", "Pin dung lượng 99.9Whr."]', CAST(2845.00 AS Decimal(6, 2)), CAST(2750.00 AS Decimal(6, 2)), 1, 1)
INSERT [msistoredb].[product] ([id], [CreatedAt], [UpdatedAt], [Name], [Description], [Detail], [OldPrice], [NewPrice], [brand_id], [CategoryId]) VALUES (7, CAST(N'2023-11-20' AS Date), CAST(N'2023-11-20' AS Date), N'Stealth GS77 - 12U', N'Vi xử lí Intel® Core™ thế hệ 12 / card đồ họa GeForce RTX™ 30 series', N'["Vi xử lí Intel® Core™ i9 thế hệ 12 mới nhất", "Windows 11 Home", "(MSI khuyến nghị Windows 11 Pro cho doanh nghiệp)", "Card đồ họa GeForce RTX™ 3080 Laptop 8GB GDDR6", "Màn hình 17.3'' QHD (2560x1440), 240 Hz, 100% DCI-P3(Typical), IPS-Level", "Tản nhiệt Cooler Boost 5 với cánh quạt mỏng chỉ 0.1mm", "Hệ thống loa Dynaudio với 6 loa thành phần", "Pin dung lượng siêu lớn 99.9Whr", "Bàn phím chơi game đèn nền Per-Key RGB của SteelSeries", "Phần mềm MSI Center với tính năng Gaming mode độc quyền, SmartAuto và Ambient Silent AI hoàn toàn mới để đem lại trải nghiệm người dùng tốt nhất"]', CAST(3723.00 AS Decimal(6, 2)), CAST(2854.00 AS Decimal(6, 2)), 1, 6)
INSERT [msistoredb].[product] ([id], [CreatedAt], [UpdatedAt], [Name], [Description], [Detail], [OldPrice], [NewPrice], [brand_id], [CategoryId]) VALUES (8, CAST(N'2023-11-20' AS Date), CAST(N'2023-11-20' AS Date), N'Titan GT77 - 12U', N'Vi xử lí Intel® Core™ thế hệ 12 / card đồ họa GeForce™ RTX 30 Series', N'["Vi xử lí Intel® Core™ i9-12900HX mới nhất", "Windows 11 Home", "(MSI khuyến nghị Windows 11 Pro cho doanh nghiệp.)", "Card đồ họa NVIDIA® GeForce RTX™ 3080 Ti Laptop GPU 16GB GDDR6", "Màn hình 17.3'' UHD (3840x2160), tần số quét 120 Hz, 100% DCI-P3(Typical), IPS-Level", "Bàn phím cơ chơi game Cherry đèn nền Per-Key RGB tới từ SteelSeries", "Pin dung lượng 99.9Whr", "Siêu mỏng 23mm, nặng chỉ 3.3 kg", "* Cấu hình có thể thay đổi tùy phiên bản, vui lòng xem thêm phần thông số kĩ thuật để biết chi tiết."]', CAST(2568.00 AS Decimal(6, 2)), CAST(2200.00 AS Decimal(6, 2)), 1, 6)
INSERT [msistoredb].[product] ([id], [CreatedAt], [UpdatedAt], [Name], [Description], [Detail], [OldPrice], [NewPrice], [brand_id], [CategoryId]) VALUES (9, CAST(N'2023-11-20' AS Date), CAST(N'2023-11-20' AS Date), N'Optix MAG24C', N'Display Port: 1920 x 1080 (Up to 144Hz) HDMI™: 1920 x 1080 (Up to 120Hz) The color gamut follows the CIE 1976 testing standard.', N'["1800R thiết kế panel cong – Phù hợp với mắt người dùng.", "Tần số quét 144Hz  - Hình ảnh hiển thị không bị chồng hình ảnh cũ..", "1ms thời gian đap ứng giúp giảm tình trạng xé hình và chồng hình ảnh.", "Gaming OSD - Thiết lập các tùy chỉnh riêng dành cho trò chơi của bạn.", "True colors - NTSC 85% & sRGB 110%.", "Adaptive Sync – giúp hình ảnh không bị xé hình trong quá trình sử dụng.", "Anti-Flicker và Less Blue Light – Ngăn ngừa hiện tượng mỏi mắt khi sử dụng lâu.", "Frameless design – Trải nghiệm trò chơi tối ưu.", "Góc nhìn rộng đến 178° .", "Được tối ưu với các thiết bị MSI Gaming – Mang đến trải nghiệm tốt nhất cho người dùng.", "RED LED – Kết thúc trò chơi cuối cùng."]', CAST(2600.00 AS Decimal(6, 2)), CAST(1980.00 AS Decimal(6, 2)), 1, 7)
INSERT [msistoredb].[product] ([id], [CreatedAt], [UpdatedAt], [Name], [Description], [Detail], [OldPrice], [NewPrice], [brand_id], [CategoryId]) VALUES (10, CAST(N'2023-11-20' AS Date), CAST(N'2023-11-20' AS Date), N'G253PF', N'Hiện thực hoá chiến thằng của bạn với màn hình dành cho Thể thao điện tử MSI G253PF. Được trang bị tấm nền Rapid IPS tối thượng với tần số quét hình 380hz, thời gian phản hồi 1ms', N'["Tấm nền Rapid IPS – Đem đến thời gian đáp ứng nhanh GTG 1ms, Tối ưu màu sắc và độ sáng màn hình.", "Tần số quét hình 380Hz – Đáp ứng nhanh hơn với khung hình mượt mà hơn.", "Thời gian đáp ứng GTG 1ms - Xóa bỏ xé hình và giật hình.", "Công nghệ FreeSync Premium™ Ngăn cản hiện tượng xé hình hay giật hình, đem đến trải nghiệm game mượt mà không độ trễ.", "HDR 400 - Đem đến các chi tiết bắt mắt nhờ khả năng điều chỉnh độ tương phản và đổ bóng.", "Night Vision; Tinh chỉnh màu đen thông minh để có thể nhìn thấy mọi chi tiết rõ ràng trong bóng tối.", "Dải màu rộng – Màu cho game và các chi tiết trở nên chân thực và sát sao hơn", "Thiết kế không viền – Đem đến trải nghiệm game đỉnh cấp với viền màn hình siêu hẹp.", "Góc nhìn rộng lên đến 178°; Màu sắc và chi tiết vẫn sắc nét ở góc nhìn lớn nhờ vào góc nhìn rộng đến 178°.", "Chống chớp hình và giảm ánh sáng xanh – Chơi game thời gian dài cũng không bị mỏi mắt hay gặp các vấn đề về mắt khác."]', CAST(3234.00 AS Decimal(6, 2)), CAST(2580.00 AS Decimal(6, 2)), 1, 7)
INSERT [msistoredb].[product] ([id], [CreatedAt], [UpdatedAt], [Name], [Description], [Detail], [OldPrice], [NewPrice], [brand_id], [CategoryId]) VALUES (11, CAST(N'2023-11-20' AS Date), CAST(N'2023-11-20' AS Date), N'MAG Codex 5 12th', N'MAG Codex 5 12TG-1488VN, HDMIx1, Display Portx3, GeForce RTX 3060 Ti VENTUS 2X 8G V1 LHR, 8G', N'["Windows 11", "Tùy chọn Bộ vi xử lý lên đến Intel® Core™ i7 Thế hệ 12", "Tùy chọn card đồ họa lên đến GeForce RTX™ 3070", "Thiết kế thông gió tuyệt vời để giữ cho máy luôn chạy ở hiệu năng đỉnh", "Tùy chọn hai cửa sổ hông, tùy biến dàn máy theo phong cách của bạn", "Mystic Light RGB LED được thiết kế để tùy biến PC chơi game của bạn", "Dễ dàng nâng cấp - Thiết kế để có thể nâng cấp linh kiện dễ dàng", "Ổ cứng SSD M.2 Tốc độ cao, tải game chỉ trong một giây", "Sử dụng linh kiện tiêu chuẩn, giữ cho hệ thống luôn được nâng cấp", "USB 3.2 Gen 2 với đầu cắm hai chiều type C"]', CAST(5390.00 AS Decimal(6, 2)), CAST(5010.00 AS Decimal(6, 2)), 1, 2)
INSERT [msistoredb].[product] ([id], [CreatedAt], [UpdatedAt], [Name], [Description], [Detail], [OldPrice], [NewPrice], [brand_id], [CategoryId]) VALUES (12, CAST(N'2023-11-20' AS Date), CAST(N'2023-11-20' AS Date), N'Trident A 9th', N'Trident A được trang bị CPU Core i7 thế hệ thứ 9 của Intel. Trải nghiệm hiệu năng với bộ vi xử lý thế hệ tiếp theo. Trải nghiệm trò chơi và làm việc nhanh hơn với hiệu năng nhanh hơn tới 50%.', N'["Hỗ trợ vi xử lý Intel® Core™ lên tới i7 thế hệ thứ 9", "Hỗ trợ Windows 10 Home", "FREE Upgrade to Windows 11*", "Card đồ họa lên tới GeForce RTX™ 2070", "Khối lượng 10 lít, máy tính để bàn gaming nhỏ gọn nhất thế giới", "Công nghệ Silent Storm Cooling 3", "Hỗ trợ tải nghiệm gaming 4K", "Dễ dàng nâng cấp", "Âm thanh Nahimic 3", "Đèn LED RGB Mystic Light tùy chỉnh theo ý bạn", "Gia tăng trải nghiệm của bạn với phần mềm MSI"]', CAST(4900.00 AS Decimal(6, 2)), CAST(4570.00 AS Decimal(6, 2)), 1, 2)
INSERT [msistoredb].[product] ([id], [CreatedAt], [UpdatedAt], [Name], [Description], [Detail], [OldPrice], [NewPrice], [brand_id], [CategoryId]) VALUES (13, CAST(N'2023-11-20' AS Date), CAST(N'2023-11-20' AS Date), N'Trident A Plus 9th', N'The Trident A Plus is housed with an Intel® 9th gen Core i7 CPU. Experience next generation performance with a next-generation processor.', N'["Up to 9th Gen Intel® Core™ i7 processor Windows 10 Home", "FREE Upgrade to Windows 11*", "GeForce RTX™ 2070 graphics", "10 liters in size, the most compact gaming desktop", "Silent Storm Cooling 3", "Support 4K gaming experience", "Easy to upgrade", "Nahimic 3 Audio Enhancer", "Mystic Light RGB LED design, customize your look", "Enrich your experience with included MSI software"]', CAST(5010.00 AS Decimal(6, 2)), CAST(5000.00 AS Decimal(6, 2)), 1, 2)
INSERT [msistoredb].[product] ([id], [CreatedAt], [UpdatedAt], [Name], [Description], [Detail], [OldPrice], [NewPrice], [brand_id], [CategoryId]) VALUES (14, CAST(N'2023-11-20' AS Date), CAST(N'2023-11-20' AS Date), N'Trident A', N'8th Gen Intel® Core™ processor / GeForce RTX™ 20 series', N'["Up to 8th Gen Intel® Core™ i7-8700 processor Windows 10 Home", "GeForce RTX™ 2070 graphics", "10 liters in size, the most compact gaming desktop", "Silent Storm Cooling 3", "Support 4K gaming experience", "Easy to upgrade", "Nahimic 3 Audio Enhancer", "Mystic Light RGB LED design, customize your look", "Enrich your experience with included MSI software"]', CAST(4790.00 AS Decimal(6, 2)), CAST(4500.00 AS Decimal(6, 2)), 1, 2)
INSERT [msistoredb].[product] ([id], [CreatedAt], [UpdatedAt], [Name], [Description], [Detail], [OldPrice], [NewPrice], [brand_id], [CategoryId]) VALUES (15, CAST(N'2023-11-20' AS Date), CAST(N'2023-11-20' AS Date), N'VIGOR GK50 LOW PROFile TKL', N'Vigor GK50 Low ProFile dưới dạng tenkeyless và hiệu năng nâng tầm đẳng cấp và trải nghiệm chơi game của bạn với switch cơ học low proFile Kailh', N'["Sử dụng switch cơ học của Kailh dạng phiên bản White Clicky", "Thiết kế Tenkeyless gọn gàng dễ dàng mang theo bên người khi di chuyển", "Có thể điều chỉnh 3 góc độ sử dụng bàn phím (5°, 8°, hay 11°)", "Dây cáp rời USB Type-C bền bỉ", "Thiết kế mũ phím nổi phù hợp công thái học"]', CAST(500.00 AS Decimal(6, 2)), CAST(4680.00 AS Decimal(6, 2)), 1, 5)
INSERT [msistoredb].[product] ([id], [CreatedAt], [UpdatedAt], [Name], [Description], [Detail], [OldPrice], [NewPrice], [brand_id], [CategoryId]) VALUES (16, CAST(N'2023-11-20' AS Date), CAST(N'2023-11-20' AS Date), N'VIGOR GK30', N'Plunger Switches 1042 g / 1303 g 1.8m with gold-plated connector USB 2.0 12+ Million', N'["Switch tịnh tiến dạng cơ học đem đến trải nghiệm gõ phím chắc chắn", "Hiệu ứng đèn RGB 6 khu vực ấn tượng", "Thiết kế bàn phím ngăn nước", "Tinh chỉnh đi vào chi tiết với MSI Center"]', CAST(670.00 AS Decimal(6, 2)), CAST(570.00 AS Decimal(6, 2)), 1, 5)
SET IDENTITY_INSERT [msistoredb].[product] OFF
GO

SET IDENTITY_INSERT [msistoredb].[user] ON 

INSERT [msistoredb].[user] ([id], [password], [Username], [DateJoined]) 
VALUES (3, N'123456', N'admin', CAST(N'2025-04-18T00:00:00.0000000' AS DateTime2));

INSERT [msistoredb].[user] ([id], [password], [Username], [DateJoined]) 
VALUES (4, N'123456', N'tri', CAST(N'2025-04-18T00:00:00.0000000' AS DateTime2));

INSERT [msistoredb].[user] ([id], [password], [Username], [DateJoined]) 
VALUES (5, N'123456', N'triadmin', CAST(N'2025-04-18T00:00:00.0000000' AS DateTime2));

INSERT [msistoredb].[user] ([id], [password], [Username], [DateJoined]) 
VALUES (6, N'123456', N'tu1', CAST(N'2025-04-18T00:00:00.0000000' AS DateTime2));

INSERT [msistoredb].[user] ([id], [password], [Username], [DateJoined]) 
VALUES (9, N'123456', N'tu5', CAST(N'2025-04-18T00:00:00.0000000' AS DateTime2));

INSERT [msistoredb].[user] ([id], [password], [Username], [DateJoined]) 
VALUES (23, N'123456', N'tu2512', CAST(N'2025-04-18T00:00:00.0000000' AS DateTime2));

INSERT [msistoredb].[user] ([id], [password], [Username], [DateJoined]) 
VALUES (25, N'123456', N'tri313', CAST(N'2025-04-18T00:00:00.0000000' AS DateTime2));

INSERT [msistoredb].[user] ([id], [password], [Username], [DateJoined]) 
VALUES (28, N'123456', N'tu123', CAST(N'2025-04-18T00:00:00.0000000' AS DateTime2));

INSERT [msistoredb].[user] ([id], [password], [Username], [DateJoined]) 
VALUES (29, N'123456', N'ducmanh78912', CAST(N'2025-04-18T00:00:00.0000000' AS DateTime2));

INSERT [msistoredb].[user] ([id], [password], [Username], [DateJoined]) 
VALUES (31, N'123456', N'ducmanh123', CAST(N'2025-04-18T00:00:00.0000000' AS DateTime2));

INSERT [msistoredb].[user] ([id], [password], [Username], [DateJoined]) 
VALUES (32, N'123456', N'tri123', CAST(N'2025-04-18T00:00:00.0000000' AS DateTime2));

SET IDENTITY_INSERT [msistoredb].[user] OFF
GO


-- Liên kết khóa ngoại: product → brand, category
ALTER TABLE msistoredb.product
ADD CONSTRAINT FK_Product_Brand FOREIGN KEY (brand_id) REFERENCES msistoredb.brand(id),
    CONSTRAINT FK_Product_Category FOREIGN KEY (CategoryId) REFERENCES msistoredb.category(id);

-- Liên kết khóa ngoại: order → user
ALTER TABLE msistoredb.[order]
ADD CONSTRAINT FK_Order_User FOREIGN KEY (UserId) REFERENCES msistoredb.[user](id);

-- Liên kết khóa ngoại: orderitem → order, product
ALTER TABLE msistoredb.orderitem
ADD CONSTRAINT FK_OrderItem_Order FOREIGN KEY (OrderId) REFERENCES msistoredb.[order](id),
    CONSTRAINT FK_OrderItem_Product FOREIGN KEY (ProductId) REFERENCES msistoredb.product(id);

-- Liên kết khóa ngoại: feedback → user, order, product
ALTER TABLE msistoredb.feedback
ADD CONSTRAINT FK_Feedback_User FOREIGN KEY (user_id) REFERENCES msistoredb.[user](id),
    CONSTRAINT FK_Feedback_Order FOREIGN KEY (order_id) REFERENCES msistoredb.[order](id);