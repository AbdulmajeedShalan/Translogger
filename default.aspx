<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" %>

<script runat="server">
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("Admin") = "" Then
            Response.Redirect("Login.aspx")
        End If
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <center>

 <!--  <asp:LinkButton ID="LinkLinkButton1" class="btn-danger" runat="server" Text="إضافه فاتوره" Width="200px" PostBackUrl="~/Income.aspx"></asp:LinkButton><br /><br /><br />
        <asp:LinkButton ID="LinkButton2"  class="btn-danger" runat="server" Text="إضافه مصروف" Width="200px" PostBackUrl="~/Expenses.aspx"></asp:LinkButton><br /><br /><br />
        <asp:LinkButton ID="LinkButton3"  class="btn-danger" runat="server" Text="إضافه مسار"  Width="200px" PostBackUrl="~/Route.aspx"></asp:LinkButton><br /><br /><br />
         <asp:LinkButton ID="LinkButton1"  class="btn-danger" runat="server" Text="إضافه تريله"  Width="200px" PostBackUrl="~/AddTruck.aspx"></asp:LinkButton><br /><br /><br />
       --><br /><br />
        <table cellspacing="16" ><tr>
            <td ><a href="Income.aspx" ><img src="Image/bill.png"  /></a></td>
            <td ><a href="Route.aspx"><img src="Image/way-512.png" /></a></td>

               </tr>
            <tr>
                <td ><a href="Expenses.aspx"><img src="Image/111-512.png"  /></a></td>
                <td > <a href="AddTruck.aspx"><img src="Image/driver-512.png"  /></a></td>

            </tr></table>
    </center>
</asp:Content>

