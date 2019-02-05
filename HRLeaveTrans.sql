select 
	rtrim(DistrictAbbrev) 
from tblDistrict

select 
	(select DistrictId from tblDistrict) as OrgID,
	ts.tsEmployeeId,
	te.Fullname,
	CONVERT(VARCHAR(10), tsd.tsDate, 110) as DateFrom,
	null as DateThru,
	null as TransType,
	lt.LeaveTypeID as LeaveType,
	lt.LeaveType as LeaveTypeID,
	gltc.LeavetypeCategory,
	bl.total,
	null as LeaveBalanceCode,
	tsd.Hrs as UnitHours,
	ps.SiteID,
	si.SiteCode,
	si.SiteName,
	null as Reason,
	tsd.Comments
from tblTimesheets ts
inner join
	tblEmployee te
	on te.EmployeeID = ts.tsEmployeeId
	and te.TerminateDate is null
inner join
	tblTimeSheetsDetails tsd
	on ts.TimeSheetID = tsd.tsTimeSheetID
inner join
	tblLeaveType lt
	on tsd.tsLeaveTypeID = lt.LeaveTypeID
	and isnull(lt.Inactive,0) = 0
inner join
	tblLeaveTypeByCategory ltc
	on ltc.LeaveTypeID = lt.LeaveTypeID
	and ltc.LeaveTypeCategoryID = 14
inner join
	tblPayrollStatus ps
	on ts.PayrollStatusID = ps.PayrollStatusID
inner join
	tblSite si
	on si.SiteID = ps.SiteID
inner join
	tblPayroll pr
	on ts.tsPayroll = pr.PayrollID
	and pr.FiscalYear = 2018
left join
	tblLeaveBalance bl
	on bl.EmployeeID = ts.tsEmployeeId
	and bl.FiscalYear = 2018
inner join
	DS_Global..tblLeaveTypeCategory gltc
	on gltc.LeaveTypeCategoryID = bl.LeaveTypeCategoryID

