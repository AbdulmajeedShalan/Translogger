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
<%@ Import Namespace=" System.Microsoft.Office.Interop.Excel" %>
<script runat="server">
    Dim cn As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString)
    Dim cmd As SqlCommand
    Protected Sub Button1_Click(sender As Object, e As EventArgs)
        For Each tb As TextBox In Panel1.Controls.OfType(Of TextBox)()
            tb.Text = ""
        Next
        
      
        
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("Admin") = "" Then
            Response.Redirect("Login.aspx")
        End If
    End Sub
    Protected Function Convertnumber(nu As String) As String
        Dim Bill As String = ""
        Dim array As Char() = nu.ToCharArray()
    
        For Each num As Char In array
      
            If num = "-" Then
                Bill = Bill + "-"
            ElseIf num = "." Then
                Bill = Bill + "."
               
                
            Else
              
                Bill = Bill + Char.GetNumericValue(num).ToString
            End If
        Next
        Return Bill
    End Function
   
    Protected Sub onclicksubmit(sender As Object, e As EventArgs)
        If DropDownList1.SelectedValue <> "-1" Then
            
      
            Try
                If FileUpload1.HasFile Then
                    If System.IO.File.Exists(Server.MapPath("~/Invoice/Expenses/") + FileUpload1.FileName) Then
                   
          
                        Dim counter As Integer = 0
                        Dim Filename As String = Server.MapPath("~/Invoice/Expenses/") + FileUpload1.FileName

                        Dim newFileName As String = Server.MapPath("~/Invoice/Expenses/") + FileUpload1.FileName
                  
                        Dim fileinfo As String = String.Empty
                        While System.IO.File.Exists(newFileName)
                            counter = counter + 1
                            newFileName = String.Format("{0}({1}){2}", Server.MapPath("~/Invoice/Expenses/") + System.IO.Path.GetFileNameWithoutExtension(FileUpload1.FileName), counter, System.IO.Path.GetExtension(Filename))
                            fileinfo = "~/Invoice/Expenses/" + System.IO.Path.GetFileNameWithoutExtension(FileUpload1.FileName) + "(" + counter.ToString + ")" + System.IO.Path.GetExtension(FileUpload1.FileName)
                  
                        End While
                   
                        FileUpload1.SaveAs(newFileName)
                 
                        cn.Open()
                        cmd = New SqlCommand("insert into Expenses (date,money,amount,Docno,Note,Expenses,TruckName) VALUES (N'" + TextBox1.Text.ToString + "',  N'" + TextBox2.Text.ToString + "',  N'" + TextBox3.Text.ToString + "',N'" + TextBox4.Text.ToString + "',N'" + TextBox5.Text.ToString + "','" + fileinfo + "',N'" + DropDownList1.SelectedValue + "')", cn)
                        cmd.ExecuteScalar()
                        cn.Close()
                        Response.Redirect("Massage.aspx")
                    Else
                        FileUpload1.SaveAs(Server.MapPath("~/Invoice/Expenses/") + FileUpload1.FileName)
                        Dim fileinfo As String = "~/Invoice/Expenses/" + FileUpload1.FileName
                        cn.Open()
                        cmd = New SqlCommand("insert into Expenses (date,money,amount,Docno,Note,Expenses,TruckName) VALUES (N'" + TextBox1.Text.ToString + "',  N'" + TextBox2.Text.ToString + "',  N'" + TextBox3.Text.ToString + "',N'" + TextBox4.Text.ToString + "',N'" + TextBox5.Text.ToString + "','" + fileinfo + "',N'" + DropDownList1.SelectedValue + "')", cn)
                        cmd.ExecuteScalar()
                        cn.Close()
                        Response.Redirect("Massage.aspx")
                    End If
              
               
                Else
                    cn.Open()
                    cmd = New SqlCommand("insert into Expenses (date,money,amount,Docno,Note,TruckName) VALUES (N'" + TextBox1.Text.ToString + "',  N'" + TextBox2.Text.ToString + "',  N'" + TextBox3.Text.ToString + "',N'" + TextBox4.Text.ToString + "',N'" + TextBox5.Text.ToString + "',N'"+DropDownList1.SelectedValue+"' )", cn)
                    cmd.ExecuteScalar()
                    cn.Close()
                    Response.Redirect("Massage.aspx")
                End If
            Catch ex As Exception
                Response.Write(ex)
            End Try
        Else
            RequiredFieldValidator20.IsValid=False
        End If
      
    End Sub

    Protected Sub DropDownList1_DataBound1(sender As Object, e As EventArgs)
        Dim newListItem As ListItem
        newListItem = New ListItem("--أختر سائق --", -1)
        newListItem.Selected = True
        DropDownList1.Items.Insert(0, newListItem)
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

  
<%@ Import Namespace=" System.Windows" %>

<style>
    table tr td {
        padding-bottom: 18px;
    }
</style>
<html xmlns="http://www.w3.org/1999/xhtml">



<body>
  <asp:Panel ID="Panel1" runat="server">
        <center>
    <div>
    <table style="text-align:right;" >
        <tr>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator20" runat="server" ControlToValidate="DropDownList1" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="Name" OnDataBound="DropDownList1_DataBound1">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Truck]"></asp:SqlDataSource>
                 </td>
             <td >اسم التريله </td>
        </tr>
        <tr>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="TextBox1" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:TextBox ID="TextBox1" runat="server"  textmode="Date" Width="175 px"></asp:TextBox>  </td>
             <td >التاريخ</td>
        </tr>
        <tr>
           
            <td>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="TextBox2" ErrorMessage="Only english number" ForeColor="Red" ValidationExpression="^[0-9-.]*$"></asp:RegularExpressionValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="TextBox2" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox></td>
        <td>المبلغ</td>
             </tr>
        <tr>
           
            <td>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="TextBox3" ErrorMessage="Only english number" ForeColor="Red" ValidationExpression="^[0-9-.]*$"></asp:RegularExpressionValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="TextBox3" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:TextBox ID="TextBox3" runat="server" ></asp:TextBox></td>
    <td>الكميه</td>
                 </tr>
        <tr>
          
            <td>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox4" ErrorMessage="Only english number" ForeColor="Red" ValidationExpression="^[0-9-.]*$"></asp:RegularExpressionValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="TextBox4" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:TextBox ID="TextBox4" runat="server" ></asp:TextBox></td>
              <td>رقم المستند</td>
        </tr>
        <tr>
           
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="TextBox5" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:TextBox ID="TextBox5" runat="server"  TextMode="MultiLine" Height="75px" Width="175px"></asp:TextBox></td>
             <td>الوصف</td>
        </tr>
      
         <tr>
            
            <td>
                 
                <asp:FileUpload ID="FileUpload1" runat="server"></asp:FileUpload>
               
            
            </td>
            <td>صوره الفاتوره</td>
        </tr>

        <tr style="float:none;"><td><asp:Button ID="Button2" runat="server" class="btn btn-success"  Width="60px"  Text="تأكيد" OnClick="onclicksubmit"></asp:Button></td><td><asp:Button ID="Button1" runat="server" Text="إالغاء" OnClick="Button1_Click"  class="btn btn-danger" Width="60px"/></td></tr>
    </table>
    </div>
            </center>
    </asp:Panel>
</body>
</html>



</asp:Content>

