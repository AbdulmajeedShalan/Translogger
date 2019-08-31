<%@ Page Title="إضافه سائق" Language="VB" MasterPageFile="~/MasterPage.master" %>
   <%@ Import Namespace=" System.Data" %>
<%@ Import Namespace=" System.Data.SqlClient" %>
<%@ Import Namespace=" System.Windows" %>
<script runat="server">
    Dim cn As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString)
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("Admin") = "" Then
            Response.Redirect("Login.aspx")
        End If
   
    End Sub
    
    Protected Sub Button1_Click(sender As Object, e As EventArgs)
        For Each tb As TextBox In Panel1.Controls.OfType(Of TextBox)()
            tb.Text = ""
        Next
        
      
    End Sub
    
    Protected Sub Button2_Click(sender As Object, e As EventArgs)
        If TextBox1.Text = String.Empty Then
            Label1.Visible = True
            Label1.Focus()
        Else
            SqlDataSource1.Insert()
            Response.Redirect("Massage.aspx")
        End If
     
    End Sub

    Protected Sub Button3_Click(sender As Object, e As EventArgs)
        Dim cmd As SqlCommand = New SqlCommand
        Dim notruck As String = "لايوجد سائق"
        If DropDownList1.SelectedItem.ToString = notruck Then
            Label2.Visible = True
            Label2.Focus()
            
            
        Else
            
       
            cn.Open()
            cmd = New SqlCommand("update Income set TruckName=@Newname where TruckName=@OldName", cn)
            cmd.Parameters.AddWithValue("@Oldname", DropDownList1.SelectedItem.ToString)
            cmd.Parameters.AddWithValue("@NewName", notruck)
            cmd.ExecuteNonQuery()
            cmd = New SqlCommand("update Expenses set TruckName=@Newname where TruckName=@OldName", cn)
            cmd.Parameters.AddWithValue("@Oldname", DropDownList1.SelectedItem.ToString)
            cmd.Parameters.AddWithValue("@NewName", notruck)
            cmd.ExecuteNonQuery()
            cmd = New SqlCommand("update Route set TrackName=@Newname where TrackName=@OldName", cn)
            cmd.Parameters.AddWithValue("@Oldname", DropDownList1.SelectedItem.ToString)
            cmd.Parameters.AddWithValue("@NewName", notruck)
            cmd.ExecuteNonQuery()
            cmd = New SqlCommand(" DELETE FROM Truck WHERE Id = @ID", cn)
            cmd.Parameters.AddWithValue("@ID", DropDownList1.SelectedValue)
          
            cmd.ExecuteNonQuery()
           
            cn.Close()
      Response.Redirect("Massage.aspx")
        End If
        
        
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
       <center>
             <asp:Panel ID="Panel1" runat="server">
    <div>
        <table style="text-align:right;" >
        <tr>
            <td>
                <asp:Button ID="Button3" runat="server" class="btn btn-danger" Text="حذف التريله" Width="90px" Height="40px" OnClick="Button3_Click" />  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label2" runat="server" ForeColor="Red" Text="لايمكن حذف هذا السائق" Visible="False"></asp:Label>
                &nbsp;&nbsp;</td><td>
               <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource2" DataTextField="Name" DataValueField="Id" Width="200px"></asp:DropDownList><asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Truck]"></asp:SqlDataSource></td>
             <td >حذف تريله</td>
        </tr></table>
        <br /><br />   <br /><br />   <br /><br />
    <table style="text-align:right;" >
        <tr>
            <td>
               <asp:Label ID="Label1" runat="server" Text="هذا الحقل إلزامي" Visible="False" ForeColor="Red"></asp:Label> &nbsp;رقم اللوحه كمثال <asp:TextBox ID="TextBox1" runat="server"  TextMode="SingleLine" Width="175px"></asp:TextBox>   </td>
             <td >أسم التريله</td>
        </tr>
         

    </table><br /><br />   
        <asp:Button ID="Button2" runat="server"   Text="تأكيد"  class="btn btn-success" Width="60px" OnClick="Button2_Click"></asp:Button>
        &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
        <asp:Button ID="Button1" runat="server"  class="btn btn-danger" Width="60px" Text="إالغاء" OnClick="Button1_Click"  />
    </div></asp:Panel>
             <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Truck] WHERE [Id] = @Id" InsertCommand="INSERT INTO [Truck] ([Name]) VALUES (@Name)" SelectCommand="SELECT * FROM [Truck]" UpdateCommand="UPDATE [Truck] SET [Name] = @Name WHERE [Id] = @Id">
                 <DeleteParameters>
                     <asp:Parameter Name="Id" Type="Int32" />
                 </DeleteParameters>
                 <InsertParameters>
                     <asp:ControlParameter ControlID="TextBox1" Name="Name" PropertyName="Text" Type="String" />
                 </InsertParameters>
                 <UpdateParameters>
                     <asp:Parameter Name="Name" Type="String" />
                     <asp:Parameter Name="Id" Type="Int32" />
                 </UpdateParameters>
             </asp:SqlDataSource>
       </center>
</asp:Content>

