<%@ Page Title="مسار" Language="VB" MasterPageFile="~/MasterPage.master" %>

<script runat="server">
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
        If DropDownList1.SelectedValue = "-1" Then
            
            RequiredFieldValidator11.IsValid = False
            
        Else
            If DropDownList2.SelectedValue = "-1" Then
                RequiredFieldValidator15.IsValid = False
            Else
              
                SqlDataSource1.Insert()
                Response.Redirect("Massage.aspx")
              
              
            End If
        End If
    End Sub
   
    
    Protected Sub TextBox5_TextChanged(sender As Object, e As EventArgs)
        If IsNumeric(TextBox5.Text) And TextBox5.Text <> String.Empty Then
            If TextBox5.Text > 0 Then
                If DropDownList1.SelectedValue = 2 Then
                    TextBox7.Text = Format((TextBox5.Text / 2) * 0.45, "0.00")
                ElseIf DropDownList1.SelectedValue = 1 Then
                    TextBox7.Text = Format((TextBox5.Text / 1.9) * 0.45, "0.00")
                End If
                
            Else
                RegularExpressionValidator1.IsValid = False
            End If

        End If
    End Sub

 


 


    Protected Sub DropDownList1_DataBound2(sender As Object, e As EventArgs)
        Dim newListItem As ListItem
        newListItem = New ListItem("--أختر سائق --", -1)
        newListItem.Selected = True
        DropDownList2.Items.Insert(0, newListItem)
    End Sub

    Protected Sub DropDownList1_SelectedIndexChanged(sender As Object, e As EventArgs)
        If IsNumeric(TextBox5.Text) And TextBox5.Text <> String.Empty Then
            If TextBox5.Text > 0 Then
                If DropDownList1.SelectedValue = 2 Then
                    TextBox7.Text = Format((TextBox5.Text / 2) * 0.45, "0.00")
                ElseIf DropDownList1.SelectedValue = 1 Then
                    TextBox7.Text = Format((TextBox5.Text / 1.9) * 0.45, "0.00")
                End If
                
            Else
                RegularExpressionValidator1.IsValid = False
            End If

        End If
    End Sub

   
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <%@ Import Namespace=" System.Data" %>
    <%@ Import Namespace=" System.Data.SqlClient" %>

    <%@ Import Namespace=" System.Math" %>
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
                <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ControlToValidate="DropDownList1" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource2" DataTextField="Name" DataValueField="Name" OnDataBound="DropDownList1_DataBound2">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Truck]"></asp:SqlDataSource>
                 </td>
             <td >اسم التريله </td>
        </tr>
        <tr>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="TextBox1" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:TextBox ID="TextBox1" runat="server"  TextMode="Date" Width="175px"></asp:TextBox>  </td>
             <td >تاريخ الإنطلاق</td>
        </tr>
        <tr>
           
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="TextBox2" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox></td>
        <td>نقطة الإنطلاق</td>
             </tr>
        <tr>
           
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ClientIDMode="Static" ControlToValidate="TextBox3" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:TextBox ID="TextBox3" runat="server" TextMode="Date" Width="175px" ></asp:TextBox></td>
    <td>التاريخ الوصول </td>
                 </tr>
        <tr>
          
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="TextBox4" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox></td>
              <td>نقطة الوصول</td>
        </tr>
         <tr>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="DropDownList1" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:DropDownList ID="DropDownList1" runat="server" Width="173px" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="True" >
                    <asp:ListItem Selected="True" Value="-1">-- اختر --</asp:ListItem>
                    <asp:ListItem Value="1">حموله</asp:ListItem>
                    <asp:ListItem Value="2">فارغ</asp:ListItem>
                </asp:DropDownList>
            </td>
            
            <td>نوع التحميل </td>
        </tr>
        <tr>
           
            <td>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox5" ErrorMessage="Only english number" ForeColor="Red" ValidationExpression="^[0-9-.]*$"></asp:RegularExpressionValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="TextBox5" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:TextBox ID="TextBox5" runat="server" OnTextChanged="TextBox5_TextChanged" AutoPostBack="true"  ></asp:TextBox></td>
             <td>المسافه</td>
        </tr>
       
        <tr>
          
            <td>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TextBox7" ErrorMessage="Only english number" ForeColor="Red" ValidationExpression="^[0-9-.]*$"></asp:RegularExpressionValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="TextBox7" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:TextBox ID="TextBox7" runat="server"></asp:TextBox></td>
              <td>تكاليف الوقود</td>
        </tr>
          <tr>
          
            <td>
                 <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="TextBox9" ErrorMessage="Only english number" ForeColor="Red" ValidationExpression="^[0-9-.]*$"></asp:RegularExpressionValidator>
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ControlToValidate="TextBox9" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                 <asp:TextBox ID="TextBox9" runat="server" ></asp:TextBox></td>
              <td>العموله</td>
        </tr>
        <tr>
        
            <td> 
                 <asp:Label ID="Label1" runat="server" ForeColor="Red" Text="Required" Visible="False"></asp:Label>
                 <asp:TextBox ID="TextBox6" runat="server" ></asp:TextBox></td>
              <td>عداد الكيلومترات</td>
            
        </tr>
       
        <tr style="float:none;"><td><asp:Button ID="Button2" runat="server"   Text="تأكيد"  class="btn btn-success" Width="60px" OnClick="Button2_Click"></asp:Button></td><td><asp:Button ID="Button1" runat="server"  class="btn btn-danger" Width="60px" Text="إالغاء" OnClick="Button1_Click"  /></td></tr>

    </table><asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Route] WHERE [Id] = @Id" InsertCommand="INSERT INTO [Route] ([from_date], [from_point], [to_date], [to_point], [distance], [type], [gas], [commission],[TrackName],[KM]) VALUES (@from_date, @from_point, @to_date, @to_point, @distance, @type, @gas, @commission,@TruckName,@KM)" SelectCommand="SELECT * FROM [Route]" UpdateCommand="UPDATE [Route] SET [from_date] = @from_date, [from_point] = @from_point, [to_date] = @to_date, [to_point] = @to_point, [distance] = @distance, [type] = @type, [gas] = @gas, [commission] = @commission WHERE [Id] = @Id">
            <DeleteParameters>
                <asp:Parameter Name="Id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="TextBox1" DbType="Date" Name="from_date" PropertyName="Text" />
                <asp:ControlParameter ControlID="TextBox2" Name="from_point" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="TextBox3" DbType="Date" Name="to_date" PropertyName="Text" />
                <asp:ControlParameter ControlID="TextBox4" Name="to_point" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="TextBox5" Name="distance" PropertyName="Text" Type="Int32" />
                <asp:ControlParameter ControlID="DropDownList1" Name="type" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="TextBox7" Name="gas" PropertyName="Text" Type="Decimal" />
                <asp:ControlParameter ControlID="TextBox9" Name="commission" PropertyName="Text" Type="Decimal" />
                <asp:ControlParameter ControlID="DropDownList2" Name="TruckName" PropertyName="SelectedValue" DefaultValue="" />
                <asp:ControlParameter ControlID="TextBox6" Name="KM" PropertyName="Text" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter DbType="Date" Name="from_date" />
                <asp:Parameter Name="from_point" Type="String" />
                <asp:Parameter DbType="Date" Name="to_date" />
                <asp:Parameter Name="to_point" Type="String" />
                <asp:Parameter Name="distance" Type="Int32" />
                <asp:Parameter Name="type" Type="Int32" />
                <asp:Parameter Name="gas" Type="Decimal" />
                <asp:Parameter Name="commission" Type="Decimal" />
                <asp:Parameter Name="Id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>

    </div>
            </center>
        </asp:Panel>
    </body>
    </html>
</asp:Content>

