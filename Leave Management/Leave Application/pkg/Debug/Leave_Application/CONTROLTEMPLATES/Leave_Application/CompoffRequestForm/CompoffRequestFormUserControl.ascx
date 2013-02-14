<%@ Assembly Name="Leave Application, Version=1.0.0.0, Culture=neutral, PublicKeyToken=56165cd852456de2" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CompoffRequestFormUserControl.ascx.cs" Inherits="Leave_Application.CompoffRequestForm.CompoffRequestFormUserControl" %>
<link href="/_layouts/LeaveApplication/StyleSheet.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/_layouts/LeaveApplication/jquery.min.js"></script>
<script src="/_layouts/LeaveApplication/LeaveRequest.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript ">

    function DateCompare() {
        var jsondata = document.getElementById("<%= hdnHolidayList.ClientID %>").value;

        var fromdate = document.getElementById("<%= dateTimeStartDate.Controls[0].ClientID %>").value;
        var endDate = document.getElementById("<%= dateTimeEndDate.Controls[0].ClientID %>").value;
        //     
        var obj = jQuery.parseJSON(jsondata);
        var fValue = new Date(fromdate);
        var eValue = new Date(endDate);

        //  var selectedLeave = leaveType.options[leaveType.selectedIndex].value;
        var tempfromdate = fValue;

        //        while (IsHoliday(tempfromdate, obj)) {
        //            //  alert(tempfromdate);

        //            tempfromdate.setDate(tempfromdate.getDate() + 1);
        //        }

        var tempenddate = eValue;

        //        while (IsHoliday(tempenddate, obj)) {
        //            tempenddate.setDate(tempenddate.getDate() - 1);
        //        }

        var leaveDays;
        leaveDays = DayDifference(tempfromdate, tempenddate);
        // alert(tempfromdate + "----" + tempenddate);
        if (tempfromdate.toString() != tempenddate.toString()) {
            if (leaveDays > 0)
                leaveDays = leaveDays + 1;
            else
                leaveDays = 0;
        } else {
            leaveDays = 1;
        }

        // alert(selectedLeave);

        // alert(selectedLeave);
        document.getElementById("<%= lblDuration.ClientID %>").innerText = leaveDays;
        document.getElementById("<%= txtDuration.ClientID %>").value = leaveDays;

    }

    function DayDifference(tempfromdate, tempenddate) {
        var oneDay = 1000 * 60 * 60 * 24;

        var dayDiff = (Math.ceil((tempenddate.getTime() - tempfromdate.getTime()) / (oneDay)));

        return dayDiff;
    }

    //    function IsHoliday(fValue, jsondata) {
    //        var fdate = new Date(fValue);
    //        var tdate = fdate.getMonth() + 1 + "/" + fdate.getDate() + "/" + fdate.getFullYear();

    //        if (jsondata.toString().indexOf(tdate) != -1) {
    //            return true;
    //        }

    //        return IsSatOrSun(tdate);
    //    }
    //    function IsSatOrSun(fValue) {
    //        var tdate = new Date(fValue);

    //        if (tdate.getDay() == 0 || tdate.getDay() == 6) {
    //            return true;
    //        } else {
    //            return false;
    //        }
    //    }
</script>
<div class="Container">
    <table>
        <tr class="header">
            <th colspan="4">
                <h3>
                    Compoff Request Form</h3>
            </th>
        </tr>
        <tr class="data double">
            <td class="label">
                <label>
                    Employee Id</label>
            </td>
            <td>
                <asp:Label ID="lblEmpID" runat="server" Text=""></asp:Label>
            </td>
            <td class="label">
                <label>
                    Designation</label>
            </td>
            <td>
                <asp:Label ID="lblDesgination" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr class="data double">
            <td class="label">
                <label>
                    Department</label>
            </td>
            <td>
                <asp:Label ID="lblDepartment" runat="server" Text=""></asp:Label>
            </td>
            <td class="label">
                <label>
                    Reporting To</label>
                <%-- <label>
                    Type of Leave</label>--%>
            </td>
            <td>
                <asp:TextBox runat="server" ID="ddlReportingTo" ReadOnly="True" CssClass="ReadOnly"></asp:TextBox>
                <%--<asp:DropDownList runat="server" ID="ddlReportingTo" CssClass="listbox" AutoPostBack="true">
                                </asp:DropDownList>--%>
                <%--<asp:DropDownList runat="server" ID="ddlTypeofLeave" AutoPostBack="False" Width="150px">
                </asp:DropDownList>--%>
            </td>
        </tr>
        <tr class="data double">
            <td class="label">
                Worked for
            </td>
            <td colspan="4">
                <asp:TextBox runat="server" ID="txtPurpose" TextMode="MultiLine" Width="500px"></asp:TextBox>
            </td>
        </tr>
        <tr id="Selecteddates" runat="server" class="data double">
            <td class="label">
                <label>
                    From Date (MM/DD/YYYY)
                </label>
                &nbsp;
            </td>
            <td>
                <SharePoint:DateTimeControl ID="dateTimeStartDate" runat="server" DateOnly="true"
                    LocaleId="1033" OnValueChangeClientScript="javascript:DateCompare()" />
            </td>
            <td class="label">
                <label>
                    To Date (MM/DD/YYYY)
                </label>
            </td>
            <td>
                <SharePoint:DateTimeControl ID="dateTimeEndDate" runat="server" DateOnly="true" LocaleId="1033"
                    OnValueChangeClientScript="javascript:DateCompare()" />
            </td>
        </tr>
        <tr class="data double">
            <td class="label">
                <label>
                    Duration</label>
            </td>
            <td colspan="3">
                <label runat="server" id="lblDuration" />
                <asp:HiddenField runat="server" ID="txtDuration" />
                <%--  <input type="text" runat="server" id="txtDuration" readonly="readonly"/>--%>
                <%--<asp:TextBox runat="server" ID="txtLeaveDays" CssClass="text readOnly"></asp:TextBox>--%>
            </td>
        </tr>
        <tr class="data double controls">
            <td colspan="4" class="noborders">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" onclick="btnSubmit_Click" 
                     />&nbsp;&nbsp;
                <asp:Button ID="btnReset" runat="server" Text="Reset" 
                    onclick="btnReset_Click" />
            </td>
        </tr>
        <tr class="data double">
            <td class="noborders" colspan="4">
                <%--   <asp:CompareValidator ID="valDate" runat="server" ForeColor="Red" ControlToValidate="dateTimeEndDate$dateTimeEndDateDate"
                    ControlToCompare="dateTimeStartDate$dateTimeStartDateDate" Type="Date" Operator="GreaterThanEqual"
                    ErrorMessage="* Please enter End Date Greater or Equal to Start Date." Display="Dynamic"></asp:CompareValidator>--%>
                <asp:HiddenField runat="server" ID="hdnCurrentUsername" />
                <asp:HiddenField runat="server" ID="hdnReportingTo"></asp:HiddenField>
                <asp:HiddenField runat="server" ID="hdnCurrentYear"></asp:HiddenField>
                <asp:HiddenField runat="server" ID="hdnEmployeeType" />
                <asp:HiddenField runat="server" ID="hdnHolidayList"></asp:HiddenField>
                <asp:HiddenField runat="server" ID="hdnFnclStarts"></asp:HiddenField>
                <asp:HiddenField runat="server" ID="hdnFnclEnds"></asp:HiddenField>
            </td>
        </tr>
    </table>
    <asp:Label ID="lblError" runat="server" ForeColor="red" Font-Bold="True"></asp:Label>
</div>
