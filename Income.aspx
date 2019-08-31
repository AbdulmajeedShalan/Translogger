<%@ Page Title="فواتير" Language="VB" MasterPageFile="~/MasterPage.master" %>

<script runat="server">


    Dim cn As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString)
    Dim cmd As SqlCommand
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("Admin") = "" Then
            Response.Redirect("Login.aspx")
        End If
    End Sub
    
    Protected Sub onclicksubmit(sender As Object, e As EventArgs)
        If TextBox8.Text = Nothing Then
            Call Button3_Click(Me, EventArgs.Empty)
        End If
        If DropDownList1.SelectedValue <> "-1" Then
            Try
           
                
         
     
                If FileUpload1.HasFile Then
               
                    If System.IO.File.Exists(Server.MapPath("~/Invoice/Income/") + FileUpload1.FileName) Then
                   
          
                        Dim counter As Integer = 0
                        Dim Filename As String = Server.MapPath("~/Invoice/Income/") + FileUpload1.FileName

                        Dim newFileName As String = Server.MapPath("~/Invoice/Income/") + FileUpload1.FileName
                  
                        Dim fileinfo As String = String.Empty
                        While System.IO.File.Exists(newFileName)
                            counter = counter + 1
                            newFileName = String.Format("{0}({1}){2}", Server.MapPath("~/Invoice/Income/") + System.IO.Path.GetFileNameWithoutExtension(FileUpload1.FileName), counter, System.IO.Path.GetExtension(Filename))
                            fileinfo = "~/Invoice/Income/" + System.IO.Path.GetFileNameWithoutExtension(FileUpload1.FileName) + "(" + counter.ToString + ")" + System.IO.Path.GetExtension(FileUpload1.FileName)
                  
                        End While
                   
                        FileUpload1.SaveAs(newFileName)
                 
                        cn.Open()
                        cmd = New SqlCommand("insert into Income (Name_From,f_rom,Name_To,Too,Bill_No,Date,weight,Amount,Amount_perTon,Invoice,date_a,TruckName,PaymentStatus) VALUES (N'" + TextBox1.Text.ToString + "',  N'" + TextBox2.Text.ToString + "',  N'" + TextBox3.Text.ToString + "',N'" + TextBox4.Text.ToString + "','" + TextBox5.Text.ToString + "', '" + TextBox6.Text.ToString + "', '" + TextBox7.Text.ToString + "', '" + TextBox8.Text.ToString + "', '" + TextBox9.Text.ToString + "','" + fileinfo + "','" + TextBox10.Text.ToString + "',N'" + DropDownList1.SelectedValue.ToString + "'N'"+DropDownList2.SelectedValue+"')", cn)
                        cmd.ExecuteScalar()
                
                        cn.Close()
                        Response.Redirect("Massage.aspx")
                    Else
                        FileUpload1.SaveAs(Server.MapPath("~/Invoice/Income/") + FileUpload1.FileName)
                        Dim fileinfo As String = "~/Invoice/Income/" + FileUpload1.FileName
                        cn.Open()
                        cmd = New SqlCommand("insert into Income (Name_From,f_rom,Name_To,Too,Bill_No,Date,weight,Amount,Amount_perTon,Invoice,date_a,TruckName,PaymentStatus) VALUES (N'" + TextBox1.Text.ToString + "',  N'" + TextBox2.Text.ToString + "',  N'" + TextBox3.Text.ToString + "',N'" + TextBox4.Text.ToString + "','" + TextBox5.Text.ToString + "', '" + TextBox6.Text.ToString + "', '" + TextBox7.Text.ToString + "', '" + TextBox8.Text.ToString + "', '" + TextBox9.Text.ToString + "','" + fileinfo + "','" + TextBox10.Text.ToString + "',N'" + DropDownList1.SelectedValue.ToString + "',N'"+DropDownList2.SelectedValue.ToString+"')", cn)
                        cmd.ExecuteScalar()
                
                        cn.Close()
                        Response.Redirect("Massage.aspx")
                    End If
         
              
                Else
                    cn.Open()
                    cmd = New SqlCommand("insert into Income (Name_From,f_rom,Name_To,Too,Bill_No,Date,weight,Amount,Amount_perTon,date_a,TruckName,PaymentStatus) VALUES (N'" + TextBox1.Text + "',  N'" + TextBox2.Text.ToString + "',  N'" + TextBox3.Text.ToString + "',N'" + TextBox4.Text.ToString + "','" + TextBox5.Text.ToString + "', '" + TextBox6.Text.ToString + "', '" + TextBox7.Text.ToString + "', '" + TextBox8.Text.ToString + "', '" + TextBox9.Text.ToString + "','" + TextBox10.Text.ToString + "',N'" + DropDownList1.SelectedValue.ToString + "',N'" + DropDownList2.SelectedValue.ToString + "')", cn)
                    cmd.ExecuteScalar()
                    cn.Close()
                    Response.Redirect("Massage.aspx")
                End If
            Catch ex As Exception
                Response.Write(ex)
            End Try
    
        
        Else
        
            RequiredFieldValidator10.IsValid = False
    
        End If

      
       
        
        
    End Sub
 
    Protected Sub calc(sender As Object, e As EventArgs)
        Dim amount As Double = 0
        If TextBox9.Text <> Nothing And TextBox7.Text <> Nothing Then
            amount = (Convert.ToInt64(TextBox9.Text) * Convert.ToInt64(TextBox7.Text))
        End If
       
        TextBox8.Text = amount
    End Sub

 
    
    Protected Sub Button1_Click(sender As Object, e As EventArgs)
        For Each tb As TextBox In Panel1.Controls.OfType(Of TextBox)()
            tb.Text = ""
        Next
        
      
    End Sub
   
    
   



    Protected Sub Button3_Click(sender As Object, e As EventArgs)
        Dim total As Double
        If TextBox7.Text = Nothing Or TextBox9.Text = Nothing Then
            If TextBox7.Text = Nothing Then
                Dim msgRslt As MsgBoxResult = MsgBox("خانة الوزن فارغه",MsgBoxStyle.Critical, "خطأ" )
            End If
            
            If TextBox9.Text = Nothing Then
                Dim msgRslt1 As MsgBoxResult = MsgBox("خانة سعر الطن فارغه",MsgBoxStyle.Critical, "خطأ" )
             
            End If
        End If
        If TextBox7.Text <> Nothing And TextBox9.Text <> Nothing Then
            TextBox8.Text=TextBox7.Text* TextBox9.Text
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
 
    <%@ Import Namespace=" System.Data" %>
<%@ Import Namespace=" System.Data.SqlClient" %>
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
                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="DropDownList1" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:DropDownList ID="DropDownList1"  Width="90px" runat="server" DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="Name" OnDataBound="DropDownList1_DataBound1">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Truck]"></asp:SqlDataSource>
                 </td>
             <td >اسم التريله </td>
        </tr>
        <tr>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox6" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:TextBox ID="TextBox6" runat="server" TextMode="Date" Width="175px"></asp:TextBox></td>
            
            <td>تاريخ الأرسال</td>
        </tr>
        <tr>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox1" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:TextBox ID="TextBox1" runat="server" ></asp:TextBox>  </td>
             <td >اسم المرسل </td>
        </tr>
        <tr>
           
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBox2" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox></td>
        <td>من </td>
             </tr>
         <tr>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TextBox10" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:TextBox ID="TextBox10" runat="server" TextMode="Date" Width="175px"></asp:TextBox></td>
            
            <td>تاريخ الأستلام</td>
        </tr>
        <tr>
           
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="TextBox3" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox></td>
    <td>اسم المستلم </td>
                 </tr>
        <tr>
          
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="TextBox4" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox></td>
              <td>إلى</td>
        </tr>
        <tr>
           
            <td>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox5" ErrorMessage="Only english number" ValidationExpression="^[0-9-.]*$" ForeColor="Red"></asp:RegularExpressionValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="TextBox5" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:TextBox ID="TextBox5" runat="server" ></asp:TextBox></td>
             <td>رقم الفاتورة</td>
        </tr>
        
        <tr>
          
            <td>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="TextBox7" ErrorMessage="Only english number" ForeColor="Red" ValidationExpression="^[0-9-.]*$"></asp:RegularExpressionValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="TextBox7" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:TextBox ID="TextBox7" runat="server"></asp:TextBox></td>
              <td>الوزن</td>
        </tr>
          <tr>
          
            <td>
                 <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="TextBox9" ErrorMessage="Only english number" ForeColor="Red" ValidationExpression="^[0-9-.]*$"></asp:RegularExpressionValidator>
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="TextBox9" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                 <asp:TextBox ID="TextBox9" runat="server" ></asp:TextBox></td>
              <td>سعر الطن</td>
        </tr>
        <tr>
            
            <td><asp:Button ID="Button3" runat="server" Text="أحسب الأجمالي" class="btn btn-info" OnClick="Button3_Click"></asp:Button>
                 
                <asp:TextBox ID="TextBox8" runat="server"  ></asp:TextBox>
            
            </td>
            <td>المبلغ</td>
        </tr>
            <tr>
            
            <td>
                 
                 
               <asp:DropDownList ID="DropDownList2" runat="server" Width="90px">
                   <asp:ListItem Value="لم يتم السداد">لم يتم السداد</asp:ListItem>
                   <asp:ListItem Value="تم السداد">تم السداد</asp:ListItem>
                </asp:DropDownList>
               
            
            </td>
            <td>حالة السداد
         <tr>
            
            <td>
                 
                <asp:FileUpload ID="FileUpload1" runat="server"></asp:FileUpload>
               
            
            </td>
            <td>صوره الفاتوره</td>
        </tr>

        <tr style="float:none;"><td><asp:Button ID="Button2" runat="server"   Width="60px" class="btn btn-success" Text="تأكيد" OnClick="onclicksubmit"></asp:Button></td><td><asp:Button ID="Button1" runat="server" Text="إالغاء"  class="btn btn-danger" Width="60px" OnClick="Button1_Click"  /></td></tr>
    </table>
    </div>
            </center>
    </asp:Panel>
</body>
</html>

</asp:Content>

