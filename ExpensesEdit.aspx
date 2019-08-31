<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" %>
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
    Protected Sub DetailsView1_ItemDeleted(sender As Object, e As DetailsViewDeletedEventArgs)
        Response.Redirect("Massage.aspx")
    End Sub

    Protected Sub DetailsView1_ItemUpdated(sender As Object, e As DetailsViewUpdatedEventArgs)
        Dim id As String = Request.QueryString("ID")
        
        Dim cmd As SqlCommand
        cmd = New SqlCommand("select Expenses from Expenses where Id='" + id + "'", cn)
        cn.Open()
        Dim fileupolad As FileUpload = DirectCast(DetailsView1.FindControl("FileUpload1"), FileUpload)
        Dim dropdawn As DropDownList = DirectCast(DetailsView1.FindControl("DropDownList1"),  DropDownList)
        If fileupolad.HasFile Then
         
            If System.IO.File.Exists(Server.MapPath("~/Invoice/Expenses/") + fileupolad.FileName) Then
                   
          
                Dim counter As Integer = 0
                Dim Filename As String = Server.MapPath("~/Invoice/Expenses/") + fileupolad.FileName

                Dim newFileName As String = Server.MapPath("~/Invoice/Expenses/") + fileupolad.FileName
                  
                Dim fileinfo As String = String.Empty
                While System.IO.File.Exists(newFileName)
                    counter = counter + 1
                    newFileName = String.Format("{0}({1}){2}", Server.MapPath("~/Invoice/Expenses/") + System.IO.Path.GetFileNameWithoutExtension(fileupolad.FileName), counter, System.IO.Path.GetExtension(Filename))
                    fileinfo = "~/Invoice/Expenses/" + System.IO.Path.GetFileNameWithoutExtension(fileupolad.FileName) + "(" + counter.ToString + ")" + System.IO.Path.GetExtension(fileupolad.FileName)
                  
                End While
                   
                fileupolad.SaveAs(newFileName)
                 
                cmd = New SqlCommand("update Expenses set Expenses=@File   where Id=@ID ", cn)
                cmd.Parameters.AddWithValue("@File", fileinfo)
              
                cmd.Parameters.AddWithValue("@ID", id)
                cmd.ExecuteNonQuery()
            Else
                fileupolad.SaveAs(Server.MapPath("~/Invoice/Expenses/") + fileupolad.FileName)
                Dim fileinfo As String = "~/Invoice/Expenses/" + fileupolad.FileName
                cmd = New SqlCommand("update Expenses set Expenses=@File   where Id=@ID ", cn)
                cmd.Parameters.AddWithValue("@File", fileinfo)
           
                cmd.Parameters.AddWithValue("@ID", id)
                cmd.ExecuteNonQuery()
            End If
          
     
     
        End If
        cmd = New SqlCommand("update Expenses set TruckName=@track  where Id=@ID ", cn)
      
        cmd.Parameters.AddWithValue("@track", dropdawn.SelectedValue.ToString)
        cmd.Parameters.AddWithValue("@ID", id)

        cn.Close()
        Response.Redirect("Massage.aspx")
    End Sub

    Protected Sub DetailsView1_ItemDeleting(sender As Object, e As DetailsViewDeleteEventArgs)
        Dim id As String = Request.QueryString("ID")
        
        Dim cmd As SqlCommand
        cmd = New SqlCommand("select Expenses from Expenses where Id='" + id + "'", cn)
        cn.Open()
        
       
        
        If IsDBNull(cmd.ExecuteScalar) Then
        Else
            Dim path As String = cmd.ExecuteScalar()
            path = path.Replace("~", "")
     
            System.IO.File.Delete((MapPath(".") + ("\\" + path)))
        
        End If
        cn.Close()
        cmd = New SqlCommand(" DELETE FROM Expenses WHERE Id = @ID", cn)
        cmd.Parameters.AddWithValue("@ID", id)
        cn.Open()
        cmd.ExecuteNonQuery()
           
        cn.Close()
    End Sub

    Protected Sub DetailsView1_ItemUpdating(sender As Object, e As DetailsViewUpdateEventArgs)
        Dim DateE As TextBox = DirectCast(DetailsView1.FindControl("TextBox1"), TextBox)
        Dim Amount As TextBox = DirectCast(DetailsView1.FindControl("TextBox2"), TextBox)
        Dim Quintty As TextBox = DirectCast(DetailsView1.FindControl("TextBox3"), TextBox)
        Dim Docnu As TextBox = DirectCast(DetailsView1.FindControl("TextBox4"), TextBox)
        Dim Note As TextBox = DirectCast(DetailsView1.FindControl("TextBox5"), TextBox)
        Dim cmd As SqlCommand = New SqlCommand("update Expenses set date=@Date ,money=@Money , amount=@Amount , Docno=@Dono , Note=@note   where Id=@ID ", cn)
        cmd.Parameters.AddWithValue("@Date", DateE.Text)
        cmd.Parameters.AddWithValue("@Amount", Quintty.Text)
        cmd.Parameters.AddWithValue("@Money", Amount.Text)
        cmd.Parameters.AddWithValue("@Dono", Docnu.Text)
        cmd.Parameters.AddWithValue("@ID", Request.QueryString("ID"))
        cmd.Parameters.AddWithValue("@note", Note.Text)
        cn.Open()
        cmd.ExecuteScalar()
        cn.Close()
     
        
    End Sub

    Protected Sub DetailsView1_PageIndexChanging(sender As Object, e As DetailsViewPageEventArgs)

    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="text-align:center">
   <asp:DetailsView ID="DetailsView1"  class="table table-striped" runat="server" Height="100%" Width="100%" AutoGenerateRows="False" DataKeyNames="Id" DataSourceID="SqlDataSource1" OnItemDeleted="DetailsView1_ItemDeleted" OnItemUpdated="DetailsView1_ItemUpdated" OnItemDeleting="DetailsView1_ItemDeleting" OnItemUpdating="DetailsView1_ItemUpdating" OnPageIndexChanging="DetailsView1_PageIndexChanging">
        <Fields>
            <asp:BoundField DataField="Id" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
            <asp:TemplateField HeaderText="التاريخ" SortExpression="date">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("date") %>'></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox1" ErrorMessage="YYYY-mm-DD format only" ForeColor="Red" ValidationExpression="((([0-9][0-9][0-9][1-9])|([1-9][0-9][0-9][0-9])|([0-9][1-9][0-9][0-9])|([0-9][0-9][1-9][0-9]))\-((0[13578])|(1[02]))\-((0[1-9])|([12][0-9])|(3[01])))|((([0-9][0-9][0-9][1-9])|([1-9][0-9][0-9][0-9])|([0-9][1-9][0-9][0-9])|([0-9][0-9][1-9][0-9]))\-((0[469])|11)\-((0[1-9])|([12][0-9])|(30)))|(((000[48])|([0-9][0-9](([13579][26])|([2468][048])))|([0-9][1-9][02468][048])|([1-9][0-9][02468][048]))\-02\-((0[1-9])|([12][0-9])))|((([0-9][0-9][0-9][1-9])|([1-9][0-9][0-9][0-9])|([0-9][1-9][0-9][0-9])|([0-9][0-9][1-9][0-9]))\-02\-((0[1-9])|([1][0-9])|([2][0-8])))"></asp:RegularExpressionValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                      
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("date") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("date") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="المبلغ" SortExpression="money">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("money") %>'></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TextBox2" ErrorMessage="Only english number" ForeColor="Red" ValidationExpression="^[0-9-.]*$"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox2" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                    
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("money") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("money") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="اسم التريله" SortExpression="TruckName">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource2" DataTextField="Name" DataValueField="Name" SelectedValue='<%# Bind("TruckName") %>'>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Truck]"></asp:SqlDataSource>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("TruckName") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label7" runat="server" Text='<%# Bind("TruckName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="الكميه" SortExpression="amount">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("amount") %>'></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="TextBox3" ErrorMessage="Only english number" ForeColor="Red" ValidationExpression="^[0-9-.]*$"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBox3" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                    
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("amount") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("amount") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="رقم المستند" SortExpression="Docno">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Docno") %>'></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="TextBox4" ErrorMessage="Only english number" ForeColor="Red" ValidationExpression="^[0-9-.]*$"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TextBox4" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                    
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Docno") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("Docno") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="الوصف" SortExpression="Note">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("Note") %>' TextMode="MultiLine"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="TextBox5" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                    
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("Note") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("Note") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="الفاتوره" SortExpression="Expenses">
                <EditItemTemplate>
                    <asp:Label ID="Label3" runat="server" ForeColor="Red" Text="أترك الخانه فارغه في حالة عدم التعديل"></asp:Label>
                    <asp:FileUpload ID="FileUpload1" runat="server" />
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("Expenses") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label6" runat="server" Text='<%# Bind("Expenses") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:CommandField  CancelText="إلغاء" DeleteText="حذف" EditText="تعديل" ShowDeleteButton="True" ShowEditButton="True" UpdateText="تحديث" />
        </Fields>
    </asp:DetailsView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Expenses]" ConflictDetection="CompareAllValues" DeleteCommand="DELETE FROM [Expenses] WHERE [Id] = @original_Id AND (([date] = @original_date) OR ([date] IS NULL AND @original_date IS NULL)) AND (([money] = @original_money) OR ([money] IS NULL AND @original_money IS NULL)) AND (([amount] = @original_amount) OR ([amount] IS NULL AND @original_amount IS NULL)) AND (([Docno] = @original_Docno) OR ([Docno] IS NULL AND @original_Docno IS NULL)) AND (([Note] = @original_Note) OR ([Note] IS NULL AND @original_Note IS NULL)) AND (([Expenses] = @original_Expenses) OR ([Expenses] IS NULL AND @original_Expenses IS NULL)) AND (([TruckName] = @original_TruckName) OR ([TruckName] IS NULL AND @original_TruckName IS NULL))" InsertCommand="INSERT INTO [Expenses] ([date], [money], [amount], [Docno], [Note], [Expenses], [TruckName]) VALUES (@date, @money, @amount, @Docno, @Note, @Expenses, @TruckName)" OldValuesParameterFormatString="original_{0}" UpdateCommand="UPDATE [Expenses] SET [date] = @date, [money] = @money, [amount] = @amount, [Docno] = @Docno, [Note] = @Note, [Expenses] = @Expenses, [TruckName] = @TruckName WHERE [Id] = @original_Id AND (([date] = @original_date) OR ([date] IS NULL AND @original_date IS NULL)) AND (([money] = @original_money) OR ([money] IS NULL AND @original_money IS NULL)) AND (([amount] = @original_amount) OR ([amount] IS NULL AND @original_amount IS NULL)) AND (([Docno] = @original_Docno) OR ([Docno] IS NULL AND @original_Docno IS NULL)) AND (([Note] = @original_Note) OR ([Note] IS NULL AND @original_Note IS NULL)) AND (([Expenses] = @original_Expenses) OR ([Expenses] IS NULL AND @original_Expenses IS NULL)) AND (([TruckName] = @original_TruckName) OR ([TruckName] IS NULL AND @original_TruckName IS NULL))">
        <DeleteParameters>
            <asp:Parameter Name="original_Id" Type="Int32" />
            <asp:Parameter Name="original_date" Type="String" />
            <asp:Parameter Name="original_money" Type="Decimal" />
            <asp:Parameter Name="original_amount" Type="String" />
            <asp:Parameter Name="original_Docno" Type="String" />
            <asp:Parameter Name="original_Note" Type="String" />
            <asp:Parameter Name="original_Expenses" Type="String" />
            <asp:Parameter Name="original_TruckName" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="date" Type="String" />
            <asp:Parameter Name="money" Type="Decimal" />
            <asp:Parameter Name="amount" Type="String" />
            <asp:Parameter Name="Docno" Type="String" />
            <asp:Parameter Name="Note" Type="String" />
            <asp:Parameter Name="Expenses" Type="String" />
            <asp:Parameter Name="TruckName" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="date" Type="String" />
            <asp:Parameter Name="money" Type="Decimal" />
            <asp:Parameter Name="amount" Type="String" />
            <asp:Parameter Name="Docno" Type="String" />
            <asp:Parameter Name="Note" Type="String" />
            <asp:Parameter Name="Expenses" Type="String" />
            <asp:Parameter Name="TruckName" Type="String" />
            <asp:Parameter Name="original_Id" Type="Int32" />
            <asp:Parameter Name="original_date" Type="String" />
            <asp:Parameter Name="original_money" Type="Decimal" />
            <asp:Parameter Name="original_amount" Type="String" />
            <asp:Parameter Name="original_Docno" Type="String" />
            <asp:Parameter Name="original_Note" Type="String" />
            <asp:Parameter Name="original_Expenses" Type="String" />
            <asp:Parameter Name="original_TruckName" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource></div>
</asp:Content>

