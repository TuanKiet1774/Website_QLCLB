-- =======================================================
-- HỆ THỐNG QUẢN LÝ CÂU LẠC BỘ TIN HỌC (QLCLB)
-- =======================================================

CREATE DATABASE [QLCLB_TinHoc]
GO
USE [QLCLB_TinHoc]
GO

-- 1. BẢNG VAI TRÒ CLB
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY IDENTITY(1,1),
    RoleName NVARCHAR(50) NOT NULL
);
GO

-- 2. BẢNG VAI TRÒ TRONG BUỔI SINH HOẠT
CREATE TABLE RoleSession (
    RoleSessionID INT PRIMARY KEY IDENTITY(1,1),
    RoleSessionName NVARCHAR(50) NOT NULL
);
GO

-- 3. BẢNG THÀNH VIÊN
CREATE TABLE Members (
    MemberID INT PRIMARY KEY IDENTITY(1,1),
    MSSV NVARCHAR(20) UNIQUE NOT NULL,
    FullName NVARCHAR(100) NOT NULL,
    ClassName NVARCHAR(50),
    Email NVARCHAR(100),
    PasswordHash NVARCHAR(255) NOT NULL,
    AvatarPath NVARCHAR(255),
    RoleID INT FOREIGN KEY REFERENCES Roles(RoleID), 
    Status NVARCHAR(50) DEFAULT N'Hoạt động',
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

-- 4. BẢNG BUỔI SINH HOẠT
CREATE TABLE Sessions (
    SessionID INT PRIMARY KEY IDENTITY(1,1),
    SessionName NVARCHAR(200) NOT NULL,
    SessionDate DATETIME DEFAULT GETDATE(),
    Location NVARCHAR(200),
    MaxParticipants INT DEFAULT 50
);
GO

-- 5. BẢNG NGƯỜI ĐỨNG LỚP
CREATE TABLE SessionInstructors (
    SessionID INT FOREIGN KEY REFERENCES Sessions(SessionID),
    MemberID INT FOREIGN KEY REFERENCES Members(MemberID),
    RoleSessionID INT FOREIGN KEY REFERENCES RoleSession(RoleSessionID),
    PRIMARY KEY (SessionID, MemberID)
);
GO

-- 6. BẢNG ĐIỂM DANH
CREATE TABLE Attendance (
    AttendanceID INT PRIMARY KEY IDENTITY(1,1),
    SessionID INT FOREIGN KEY REFERENCES Sessions(SessionID),
    MemberID INT FOREIGN KEY REFERENCES Members(MemberID),
    Status NVARCHAR(50) DEFAULT N'Vắng',
    Note NVARCHAR(255)
);
GO

-- 7. VIEW THỐNG KÊ - ĐẾM SỐ LƯỢNG THỰC TẾ THAM GIA ĐỂ TÍNH TỈ LỆ
IF OBJECT_ID('View_SessionStatistics', 'V') IS NOT NULL
    DROP VIEW View_SessionStatistics;
GO

CREATE VIEW View_SessionStatistics AS
SELECT 
    s.SessionID,
    s.SessionName,
    s.SessionDate,
    s.Location,
    s.MaxParticipants,
    (SELECT COUNT(*) FROM Attendance a WHERE a.SessionID = s.SessionID AND a.Status = N'Có mặt') AS TotalAttendees,
    (SELECT COUNT(*) FROM Attendance a WHERE a.SessionID = s.SessionID) AS TotalAssigned
FROM Sessions s;
GO

-- =======================================================
-- THÊM DỮ LIỆU MẪU
-- =======================================================
INSERT INTO Roles (RoleName) VALUES (N'Admin'), (N'Thành viên');
INSERT INTO RoleSession (RoleSessionName) VALUES (N'Đứng lớp');

INSERT INTO Members (MSSV, FullName, ClassName, Email, PasswordHash, RoleID) VALUES  
(N'66131234', N'Nguyễn Văn A', N'66.CNTT-2', N'a.nv@ntu.edu.vn', N'123abc@', 1),
(N'67131235', N'Trần Thị B', N'67.CNTT-1', N'b.tt@ntu.edu.vn', N'123abc@', 2),
(N'66131236', N'Nguyễn An', N'66.CNTT-2', N'a.n@ntu.edu.vn', N'123abc@', 2), 
(N'67131237', N'Trần Thị Hoa', N'67.CNTT-1', N'h.tt@ntu.edu.vn', N'123abc@', 2),
(N'66135566', N'Lê Minh Cường', N'66.KHMT', N'cuong.lm@ntu.edu.vn', N'123abc@', 2),
(N'65139988', N'Phạm Mỹ Linh', N'65.CNTT-3', N'linh.pm@ntu.edu.vn', N'123abc@', 2);

-- 1. LỚP CỐ ĐỊNH (T2, T3)
INSERT INTO Sessions (SessionName, SessionDate, Location, MaxParticipants) VALUES  
(N'Sinh hoạt Web', '2026-02-16 18:30:00', N'Phòng 205', 15),
(N'Sinh hoạt Web', '2026-02-23 18:30:00', N'Phòng 205', 15),
(N'Sinh hoạt Web', '2026-03-02 18:30:00', N'Phòng 205', 15),
(N'Sinh hoạt NMLT', '2026-02-17 18:30:00', N'Phòng 205', 15),
(N'Sinh hoạt NMLT', '2026-02-24 18:30:00', N'Phòng 205', 15),
(N'Sinh hoạt NMLT', '2026-03-03 18:30:00', N'Phòng 205', 15);

-- 2. HOẠT ĐỘNG KHÁC
INSERT INTO Sessions (SessionName, SessionDate, Location, MaxParticipants) VALUES  
(N'Seminar Vibe Coding', '2026-03-08 09:00:00', N'NDN.101', 20);

-- PHÂN CÔNG ĐỨNG LỚP
INSERT INTO SessionInstructors (SessionID, MemberID, RoleSessionID) VALUES  
(1, 1, 1), (2, 1, 1), (3, 1, 1), -- 1 Người Web
(4, 3, 1), (4, 4, 1), (5, 3, 1), (5, 4, 1), (6, 3, 1), (6, 4, 1), -- 2 Người NMLT
(7, 6, 1); -- 1 Người

-- ĐIỂM DANH
INSERT INTO Attendance (SessionID, MemberID, Status) VALUES  
(1, 2, N'Có mặt'), (1, 5, N'Vắng'), (1, 3, N'Có mặt'), (1, 4, N'Có mặt'), (1, 6, N'Có mặt'), (1, 1, N'Có mặt'),
(2, 2, N'Có mặt'), (2, 5, N'Vắng'), (2, 3, N'Có mặt'), (2, 4, N'Có mặt'), (2, 6, N'Có mặt'), (2, 1, N'Có mặt'),
(3, 2, N'Có mặt'), (3, 5, N'Vắng'), (3, 3, N'Có mặt'), (3, 4, N'Có mặt'), (3, 6, N'Có mặt'), (3, 1, N'Có mặt'),
(4, 1, N'Có mặt'), (4, 2, N'Có phép'), (4, 5, N'Có mặt'), (4, 6, N'Có mặt'), (4, 4, N'Có mặt'), (4, 3, N'Có mặt'),
(5, 1, N'Có mặt'), (5, 2, N'Có phép'), (5, 5, N'Có mặt'), (5, 6, N'Có mặt'), (5, 4, N'Có mặt'), (5, 3, N'Có mặt'),
(6, 1, N'Có mặt'), (6, 2, N'Có phép'), (6, 5, N'Có mặt'), (6, 6, N'Có mặt'), (6, 4, N'Có mặt'), (6, 3, N'Có mặt'),
(7, 1, N'Có mặt'), (7, 2, N'Có mặt'), (7, 3, N'Vắng'), (7, 4, N'Có mặt'), (7, 5, N'Có mặt'), (7, 6, N'Có mặt');
GO

-- XEM KẾT QUẢ CUỐI CÙNG
SELECT * FROM View_SessionStatistics;