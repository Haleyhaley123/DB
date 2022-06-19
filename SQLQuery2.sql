USE [master]
GO

/****** Object:  Database [lightPortal_4Dev]    Script Date: 6/5/2022 10:42:25 AM ******/
CREATE DATABASE [lightPortal_4Dev]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'cnPortal', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\lightPortal_4Dev.mdf' , SIZE = 18432KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'cnPortal_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\lightPortal_4Dev_log.ldf' , SIZE = 22144KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

ALTER DATABASE [lightPortal_4Dev] SET COMPATIBILITY_LEVEL = 110
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [lightPortal_4Dev].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [lightPortal_4Dev] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [lightPortal_4Dev] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [lightPortal_4Dev] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [lightPortal_4Dev] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [lightPortal_4Dev] SET ARITHABORT OFF 
GO

ALTER DATABASE [lightPortal_4Dev] SET AUTO_CLOSE ON 
GO

ALTER DATABASE [lightPortal_4Dev] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [lightPortal_4Dev] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [lightPortal_4Dev] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [lightPortal_4Dev] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [lightPortal_4Dev] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [lightPortal_4Dev] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [lightPortal_4Dev] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [lightPortal_4Dev] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [lightPortal_4Dev] SET  DISABLE_BROKER 
GO

ALTER DATABASE [lightPortal_4Dev] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [lightPortal_4Dev] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [lightPortal_4Dev] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [lightPortal_4Dev] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [lightPortal_4Dev] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [lightPortal_4Dev] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [lightPortal_4Dev] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [lightPortal_4Dev] SET RECOVERY FULL 
GO

ALTER DATABASE [lightPortal_4Dev] SET  MULTI_USER 
GO

ALTER DATABASE [lightPortal_4Dev] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [lightPortal_4Dev] SET DB_CHAINING OFF 
GO

ALTER DATABASE [lightPortal_4Dev] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [lightPortal_4Dev] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO

ALTER DATABASE [lightPortal_4Dev] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [lightPortal_4Dev] SET  READ_WRITE 
GO

