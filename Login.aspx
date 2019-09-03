<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" %>

<%@ Import Namespace="ClosedXML.Excel" %>
<%@ Import Namespace=" System.Data" %>
<%@ Import Namespace=" System.Data.SqlClient" %>
<%@ Import Namespace=" System.Windows" %>
<%@ Import Namespace=" System.IO" %>
<%@ Import Namespace=" System.IO" %>
<%@ Import Namespace=" System.Data" %>
<%@ Import Namespace=" System.Configuration" %>
<%@ Import Namespace=" System.Drawing" %>
<script runat="server">

    Protected Sub Submit_Click(sender As Object, e As EventArgs)
        Dim cn As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString)
        Dim cmd As SqlCommand
        cmd = New SqlCommand("Select COUNT(*) from Users where UserName='" + username.Text + "'and Password='" + password.Text + "'", cn)
        cn.Open()
        Dim count As Integer = cmd.ExecuteScalar
        If count>0
            Session("Admin") = "Admin"
            Response.Redirect("default.aspx")
        Else
            Label1.Visible = True
        End If
        cn.Close()

    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <center>
     <div class="form-group">
         <label runat="server" >Username:</label> <asp:TextBox runat="server" ID="username"></asp:TextBox> <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ControlToValidate="username" ForeColor="Red"></asp:RequiredFieldValidator>
     </div>
        <div class="form-group">
         <label runat="server" >Password:</label> <asp:TextBox runat="server" ID="password" TextMode="Password"></asp:TextBox> <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="password" ForeColor="Red"></asp:RequiredFieldValidator>
     </div>
           <div class="form-group">
         <asp:Button runat="server" ID="Submit" CssClass="btn-danger" Width="90px" Text="Submit" OnClick="Submit_Click"/><asp:Label ID="Label1" runat="server" Text="Username/Password invalid" ForeColor="Red" Visible="false"></asp:Label>
              
               <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [User] WHERE (([Password] = @Password) AND ([UserName] = @UserName))">
                   <SelectParameters>
                       <asp:ControlParameter ControlID="password" Name="Password" PropertyName="Text" Type="String" />
                       <asp:ControlParameter ControlID="username" Name="UserName" PropertyName="Text" Type="String" />
                   </SelectParameters>
               </asp:SqlDataSource>
              
     </div>
        </center>
</asp:Content>

