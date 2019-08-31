<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" %>
    <%@ Import Namespace=" System.Data" %>
<%@ Import Namespace=" System.Data.SqlClient" %>
<%@ Import Namespace=" System.Windows" %>
<script runat="server">
    Dim fileinfo As String
    Dim cn As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString)
     
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("Admin") = "" Then
            Response.Redirect("Login.aspx")
        End If
    End Sub
    Protected Sub DetailsView1_ItemDeleted(sender As Object, e As DetailsViewDeletedEventArgs)
   
        
        Response.Redirect("Massage.aspx")
    End Sub


    Protected Sub DetailsView1_ItemDeleting(sender As Object, e As DetailsViewDeleteEventArgs)
        Dim id As String = Request.QueryString("ID")
        
        Dim cmd As SqlCommand
        cmd = New SqlCommand("select Invoice from Income where Id='" + id + "'", cn)
        cn.Open()
        
       
        
        If IsDBNull(cmd.ExecuteScalar) Then
        Else
            Dim path As String = cmd.ExecuteScalar()
            path = path.Replace("~", "")
     
            System.IO.File.Delete((MapPath(".") + ("\\" + path)))
        
        End If
        cn.Close()
    End Sub

    Protected Sub DetailsView1_ItemUpdating(sender As Object, e As DetailsViewUpdateEventArgs)
        Dim id As String = Request.QueryString("ID")
        Dim cn As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString)
        Dim cmd As SqlCommand
       
        cmd = New SqlCommand("select Invoice from Income where Id='" + id + "'", cn)
        cn.Open()
        
       
        Dim fileupolad As FileUpload = DirectCast(DetailsView1.FindControl("FileUpload1"), FileUpload)
        If fileupolad.HasFile Then
            If IsDBNull(cmd.ExecuteScalar) Then
                
              
            Else
                Dim path As String = cmd.ExecuteScalar()
                path = path.Replace("~", "")
     
                System.IO.File.Delete((MapPath(".") + ("\\" + path)))
              
            End If
            End If
            
        cn.Close()
    End Sub
    Protected Sub DetailsView1_ItemUpdated(sender As Object, e As DetailsViewUpdatedEventArgs)
        Dim id As String = Request.QueryString("ID")
        Dim cn As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString)
        Dim cmd As SqlCommand
       
        cmd = New SqlCommand("select Invoice from Income where Id='" + id + "'", cn)
        cn.Open()
        
       
        Dim fileupolad As FileUpload = DirectCast(DetailsView1.FindControl("FileUpload1"), FileUpload)
        If fileupolad.HasFile Then
         
            If System.IO.File.Exists(Server.MapPath("~/Invoice/Income/") + fileupolad.FileName) Then
                   
          
                Dim counter As Integer = 0
                Dim Filename As String = Server.MapPath("~/Invoice/Income/") + fileupolad.FileName

                Dim newFileName As String = Server.MapPath("~/Invoice/Income/") + fileupolad.FileName
                  
                Dim fileinfo As String = String.Empty
                While System.IO.File.Exists(newFileName)
                    counter = counter + 1
                    newFileName = String.Format("{0}({1}){2}", Server.MapPath("~/Invoice/Income/") + System.IO.Path.GetFileNameWithoutExtension(fileupolad.FileName), counter, System.IO.Path.GetExtension(Filename))
                    fileinfo = "~/Invoice/Income/" + System.IO.Path.GetFileNameWithoutExtension(fileupolad.FileName) + "(" + counter.ToString + ")" + System.IO.Path.GetExtension(fileupolad.FileName)
                  
                End While
                   
                fileupolad.SaveAs(newFileName)
                 
              
                cmd = New SqlCommand("update Income set Invoice=@File where Id=@ID ", cn)
                cmd.Parameters.AddWithValue("@File", fileinfo)
                cmd.Parameters.AddWithValue("@ID", id)
                cmd.ExecuteNonQuery()
               
            Else
                fileupolad.SaveAs(Server.MapPath("~/Invoice/Income/") + fileupolad.FileName)
                Dim fileinfo As String = "~/Invoice/Income/" + fileupolad.FileName
                cmd = New SqlCommand("update Income set Invoice=@File where Id=@ID ", cn)
                cmd.Parameters.AddWithValue("@File", fileinfo)
                cmd.Parameters.AddWithValue("@ID", id)
                cmd.ExecuteNonQuery()
            End If
            
            
     
        End If
        Dim dropdawn As DropDownList = DirectCast(DetailsView1.FindControl("DropDownList1"), DropDownList)
      
        cmd = New SqlCommand("update Income set TruckName=@Name where Id=@ID ", cn)
        cmd.Parameters.AddWithValue("@Name", dropdawn.SelectedValue.ToString)
        cmd.Parameters.AddWithValue("@ID", id)
        cmd.ExecuteNonQuery()
        Dim dropdawn1 As DropDownList = DirectCast(DetailsView1.FindControl("DropDownList2"), DropDownList)
      
        cmd = New SqlCommand("update Income set PaymentStatus=@Name where Id=@ID ", cn)
        cmd.Parameters.AddWithValue("@Name", dropdawn1.SelectedValue.ToString)
        cmd.Parameters.AddWithValue("@ID", id)
        cmd.ExecuteNonQuery()
        cn.Close()
        Response.Redirect("Massage.aspx")
    End Sub

   
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Income] WHERE [Id] = @original_Id" InsertCommand="INSERT INTO [Income] ([Name_From], [f_rom], [Name_To], [Too], [Bill_No], [Date], [weight], [Amount], [Amount_perTon], [Invoice], [date_a]) VALUES (@Name_From, @f_rom, @Name_To, @Too, @Bill_No, @Date, @weight, @Amount, @Amount_perTon, @Invoice, @date_a)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Income] WHERE ([Id] = @Id)" UpdateCommand="UPDATE [Income] SET [Name_From] = @Name_From, [f_rom] = @f_rom, [Name_To] = @Name_To, [Too] = @Too, [Bill_No] = @Bill_No, [Date] = @Date, [weight] = @weight, [Amount] = @Amount, [Amount_perTon] = @Amount_perTon, [Invoice] = @Invoice, [date_a] = @date_a WHERE [Id] = @original_Id">
        <DeleteParameters>
            <asp:Parameter Name="original_Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Name_From" Type="String" />
            <asp:Parameter Name="f_rom" Type="String" />
            <asp:Parameter Name="Name_To" Type="String" />
            <asp:Parameter Name="Too" Type="String" />
            <asp:Parameter Name="Bill_No" Type="String" />
            <asp:Parameter Name="Date" Type="String" />
            <asp:Parameter Name="weight" Type="String" />
            <asp:Parameter Name="Amount" Type="String" />
            <asp:Parameter Name="Amount_perTon" Type="String" />
            <asp:Parameter Name="Invoice" Type="String" />
            <asp:Parameter Name="date_a" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="Id" QueryStringField="ID" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name_From" Type="String" />
            <asp:Parameter Name="f_rom" Type="String" />
            <asp:Parameter Name="Name_To" Type="String" />
            <asp:Parameter Name="Too" Type="String" />
            <asp:Parameter Name="Bill_No" Type="String" />
            <asp:Parameter Name="Date" Type="String" />
            <asp:Parameter Name="weight" Type="String" />
            <asp:Parameter Name="Amount" Type="String" />
            <asp:Parameter Name="Amount_perTon" Type="String" />
            <asp:Parameter Name="Invoice" Type="String" />
            <asp:Parameter Name="date_a" Type="String" />
            <asp:Parameter Name="original_Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
   <div style="text-align:center"> <asp:DetailsView ID="DetailsView1"  class="table table-striped" runat="server"  AutoGenerateRows="False" DataKeyNames="Id" DataSourceID="SqlDataSource1" Height="50px" Width="100%" OnItemDeleted="DetailsView1_ItemDeleted" OnItemUpdated="DetailsView1_ItemUpdated" OnItemDeleting="DetailsView1_ItemDeleting" OnItemUpdating="DetailsView1_ItemUpdating" >
       <Fields>
           <asp:BoundField DataField="Id" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
           <asp:TemplateField HeaderText="اسم التريله" SortExpression="TruckName">
               <EditItemTemplate>
                   <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource2" DataTextField="Name" DataValueField="Name" SelectedValue='<%# Bind("TruckName") %>'>
                   </asp:DropDownList>
                   <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Truck]"></asp:SqlDataSource>
               </EditItemTemplate>
               <InsertItemTemplate>
                   <asp:TextBox ID="TextBox11" runat="server" Text='<%# Bind("TruckName") %>'></asp:TextBox>
               </InsertItemTemplate>
               <ItemTemplate>
                   <asp:Label ID="Label12" runat="server" Text='<%# Bind("TruckName") %>'></asp:Label>
               </ItemTemplate>
           </asp:TemplateField>
           <asp:TemplateField HeaderText="تاريخ الأرسال" SortExpression="Date">
               <EditItemTemplate>
                   <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Date") %>' TextMode="Date"></asp:TextBox>
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1" ErrorMessage="Required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
               </EditItemTemplate>
               <InsertItemTemplate>
                   <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Date") %>'></asp:TextBox>
               </InsertItemTemplate>
               <ItemTemplate>
                   <asp:Label ID="Label2" runat="server" Text='<%# Bind("Date") %>'></asp:Label>
               </ItemTemplate>
           </asp:TemplateField>
           <asp:TemplateField HeaderText="اسم المرسل" SortExpression="Name_From">
               <EditItemTemplate>
                   <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Name_From") %>'></asp:TextBox>
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox2"  Display="Dynamic" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
               </EditItemTemplate>
               <InsertItemTemplate>
                   <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Name_From") %>'></asp:TextBox>
               </InsertItemTemplate>
               <ItemTemplate>
                   <asp:Label ID="Label3" runat="server" Text='<%# Bind("Name_From") %>'></asp:Label>
               </ItemTemplate>
           </asp:TemplateField>
           <asp:TemplateField HeaderText="من" SortExpression="f_rom">
               <EditItemTemplate>
                   <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("f_rom") %>'></asp:TextBox>
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBox3" Display="Dynamic" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
               </EditItemTemplate>
               <InsertItemTemplate>
                   <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("f_rom") %>'></asp:TextBox>
               </InsertItemTemplate>
               <ItemTemplate>
                   <asp:Label ID="Label4" runat="server" Text='<%# Bind("f_rom") %>'></asp:Label>
               </ItemTemplate>
           </asp:TemplateField>
           <asp:TemplateField HeaderText="تاريخ الأستلام" SortExpression="date_a">
               <EditItemTemplate>
                   <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("date_a") %>' TextMode="Date"></asp:TextBox>
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator99" runat="server" ControlToValidate="TextBox4" ErrorMessage="Required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
               </EditItemTemplate>
               <InsertItemTemplate>
                   <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("date_a") %>'></asp:TextBox>
               </InsertItemTemplate>
               <ItemTemplate>
                   <asp:Label ID="Label5" runat="server" Text='<%# Bind("date_a") %>'></asp:Label>
               </ItemTemplate>
           </asp:TemplateField>
           <asp:TemplateField HeaderText="اسم المستلم" SortExpression="Name_To">
               <EditItemTemplate>
                   <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("Name_To") %>'></asp:TextBox>
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="TextBox5" Display="Dynamic" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
               </EditItemTemplate>
               <InsertItemTemplate>
                   <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("Name_To") %>'></asp:TextBox>
               </InsertItemTemplate>
               <ItemTemplate>
                   <asp:Label ID="Label6" runat="server" Text='<%# Bind("Name_To") %>'></asp:Label>
               </ItemTemplate>
           </asp:TemplateField>
           <asp:TemplateField HeaderText="إلى" SortExpression="Too">
               <EditItemTemplate>
                   <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("Too") %>'></asp:TextBox>
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" Display="Dynamic" ControlToValidate="TextBox6" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
               </EditItemTemplate>
               <InsertItemTemplate>
                   <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("Too") %>'></asp:TextBox>
               </InsertItemTemplate>
               <ItemTemplate>
                   <asp:Label ID="Label7" runat="server" Text='<%# Bind("Too") %>'></asp:Label>
               </ItemTemplate>
           </asp:TemplateField>
           <asp:TemplateField HeaderText="رقم الفاتوره" SortExpression="Bill_No">
               <EditItemTemplate>
                   <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("Bill_No") %>'></asp:TextBox>
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator7" Display="Dynamic" runat="server" ControlToValidate="TextBox7" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                   <asp:RegularExpressionValidator ID="RegularExpressionValidator2" Display="Dynamic" runat="server" ControlToValidate="TextBox7" ErrorMessage="Only english number" ForeColor="Red" ValidationExpression="^[0-9-.]*$"></asp:RegularExpressionValidator>
               </EditItemTemplate>
               <InsertItemTemplate>
                   <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("Bill_No") %>'></asp:TextBox>
               </InsertItemTemplate>
               <ItemTemplate>
                   <asp:Label ID="Label8" runat="server" Text='<%# Bind("Bill_No") %>'></asp:Label>
               </ItemTemplate>
           </asp:TemplateField>
           <asp:TemplateField HeaderText="الوزن" SortExpression="weight">
               <EditItemTemplate>
                   <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("weight") %>'></asp:TextBox>
                   <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="TextBox8" ErrorMessage="Only english number" ForeColor="Red" ValidationExpression="^[0-9-.]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="TextBox8" Display="Dynamic" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
               </EditItemTemplate>
               <InsertItemTemplate>
                   <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("weight") %>'></asp:TextBox>
               </InsertItemTemplate>
               <ItemTemplate>
                   <asp:Label ID="Label9" runat="server" Text='<%# Bind("weight") %>'></asp:Label>
               </ItemTemplate>
           </asp:TemplateField>
           <asp:TemplateField HeaderText="المبلغ بالوزن" SortExpression="Amount_perTon">
               <EditItemTemplate>
                   <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("Amount_perTon") %>'></asp:TextBox>
                   <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="TextBox9" ErrorMessage="Only english number" ForeColor="Red" ValidationExpression="^[0-9-.]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="TextBox9" ErrorMessage="Required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
               </EditItemTemplate>
               <InsertItemTemplate>
                   <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("Amount_perTon") %>'></asp:TextBox>
               </InsertItemTemplate>
               <ItemTemplate>
                   <asp:Label ID="Label10" runat="server" Text='<%# Bind("Amount_perTon") %>'></asp:Label>
               </ItemTemplate>
           </asp:TemplateField>
           <asp:TemplateField HeaderText="المبلغ" SortExpression="Amount">
               <EditItemTemplate>
                   <asp:TextBox ID="TextBox10" runat="server" Text='<%# Bind("Amount") %>'></asp:TextBox>
                   <asp:RegularExpressionValidator ID="RegularExpressionValidator99" runat="server" ControlToValidate="TextBox10" ErrorMessage="Only english number" ForeColor="Red" ValidationExpression="^[0-9-.]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="TextBox10" ErrorMessage="Required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
               </EditItemTemplate>
               <InsertItemTemplate>
                   <asp:TextBox ID="TextBox10" runat="server" Text='<%# Bind("Amount") %>'></asp:TextBox>
               </InsertItemTemplate>
               <ItemTemplate>
                   <asp:Label ID="Label11" runat="server" Text='<%# Bind("Amount") %>'></asp:Label>
               </ItemTemplate>
           </asp:TemplateField>
           <asp:TemplateField HeaderText="فاتوره" InsertVisible="False" SortExpression="Invoice">
               <EditItemTemplate>
                   <asp:Label ID="Label3" runat="server" ForeColor="Red" Text="أترك الخانه فارغه في حالة عدم التعديل"></asp:Label>
                   <asp:FileUpload ID="FileUpload1" runat="server" />
               </EditItemTemplate>
               <ItemTemplate>
                   <asp:Label ID="Label1" runat="server" Text='<%# Bind("Invoice") %>'></asp:Label>
                   &nbsp;
               </ItemTemplate>
           </asp:TemplateField>
           <asp:TemplateField HeaderText="حالة السداد">
               <EditItemTemplate>
                   <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [PaymentStatus] FROM [Income] WHERE ([Id] = @Id)">
                       <SelectParameters>
                           <asp:QueryStringParameter DefaultValue="" Name="Id" QueryStringField="ID" Type="Int32" />
                       </SelectParameters>
                   </asp:SqlDataSource>
                   <asp:DropDownList ID="DropDownList2" runat="server" SelectedValue='<%# Bind("PaymentStatus") %>'>
                       <asp:ListItem>تم السداد</asp:ListItem>
                       <asp:ListItem>لم يتم السداد</asp:ListItem>
                   </asp:DropDownList>
               </EditItemTemplate>
               <ItemTemplate>
                   <asp:Label ID="Label13" runat="server" Text='<%# Eval("PaymentStatus") %>'></asp:Label>
               </ItemTemplate>
           </asp:TemplateField>
           <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" CancelText="إلغاء" DeleteText="حذف" EditText="تعديل" UpdateText="تحديث" />
       </Fields>
    </asp:DetailsView>
  </div>

</asp:Content>

