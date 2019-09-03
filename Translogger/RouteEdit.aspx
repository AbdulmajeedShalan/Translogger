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
    Protected Sub DetailsView3_ItemDeleted(sender As Object, e As DetailsViewDeletedEventArgs)
        Response.Redirect("Massage.aspx")
    End Sub

    Protected Sub DetailsView3_ItemUpdated(sender As Object, e As DetailsViewUpdatedEventArgs)
        cn.Open()
        Dim id As String=Request.QueryString("ID")
        Dim cmd As SqlCommand
        cmd = New SqlCommand("update Route set TrackName=@track  where Id=@ID ", cn)
        Dim dropdawn As DropDownList = DirectCast(DetailsView3.FindControl("DropDownList2"), DropDownList)
          cmd.Parameters.AddWithValue("@track", dropdawn.SelectedValue.ToString)
        cmd.Parameters.AddWithValue("@ID", id)
        cmd.ExecuteNonQuery()
        cn.Close()
        
        Response.Redirect("Massage.aspx")
    End Sub

    Protected Sub DetailsView3_PageIndexChanging(sender As Object, e As DetailsViewPageEventArgs)

    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   
        <br />
    <div style="text-align:center">
        <asp:DetailsView ID="DetailsView3" class="table table-striped" runat="server"  AutoGenerateRows="False" DataKeyNames="Id" DataSourceID="SqlDataSource1" Height="50px" Width="100%" OnItemDeleted="DetailsView3_ItemDeleted" OnItemUpdated="DetailsView3_ItemUpdated" OnPageIndexChanging="DetailsView3_PageIndexChanging">
            <Fields>
                <asp:BoundField DataField="Id" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                <asp:TemplateField HeaderText="اسم التريله" SortExpression="TrackName">
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource2" DataTextField="Name" DataValueField="Name" SelectedValue='<%# Bind("TrackName") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Truck]"></asp:SqlDataSource>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("TrackName") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label7" runat="server" Text='<%# Bind("TrackName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="تاريخ الأنطلاق" SortExpression="from_date">
                    <EditItemTemplate>
                         <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("from_date") %>'></asp:TextBox>
                         <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox1" ErrorMessage="YYYY-mm-DD format only" ForeColor="Red" ValidationExpression="((([0-9][0-9][0-9][1-9])|([1-9][0-9][0-9][0-9])|([0-9][1-9][0-9][0-9])|([0-9][0-9][1-9][0-9]))\-((0[13578])|(1[02]))\-((0[1-9])|([12][0-9])|(3[01])))|((([0-9][0-9][0-9][1-9])|([1-9][0-9][0-9][0-9])|([0-9][1-9][0-9][0-9])|([0-9][0-9][1-9][0-9]))\-((0[469])|11)\-((0[1-9])|([12][0-9])|(30)))|(((000[48])|([0-9][0-9](([13579][26])|([2468][048])))|([0-9][1-9][02468][048])|([1-9][0-9][02468][048]))\-02\-((0[1-9])|([12][0-9])))|((([0-9][0-9][0-9][1-9])|([1-9][0-9][0-9][0-9])|([0-9][1-9][0-9][0-9])|([0-9][0-9][1-9][0-9]))\-02\-((0[1-9])|([1][0-9])|([2][0-8])))"></asp:RegularExpressionValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                      
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("from_date") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("from_date") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="نقطة الأنطلاق" SortExpression="from_point">
                    <EditItemTemplate>
                         <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("from_point") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox2" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                       
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("from_point") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("from_point") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="تاريخ الأستلام" SortExpression="to_date">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("to_date") %>'></asp:TextBox>
                         <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TextBox3" ErrorMessage="YYYY-mm-DD format only" ForeColor="Red" ValidationExpression="((([0-9][0-9][0-9][1-9])|([1-9][0-9][0-9][0-9])|([0-9][1-9][0-9][0-9])|([0-9][0-9][1-9][0-9]))\-((0[13578])|(1[02]))\-((0[1-9])|([12][0-9])|(3[01])))|((([0-9][0-9][0-9][1-9])|([1-9][0-9][0-9][0-9])|([0-9][1-9][0-9][0-9])|([0-9][0-9][1-9][0-9]))\-((0[469])|11)\-((0[1-9])|([12][0-9])|(30)))|(((000[48])|([0-9][0-9](([13579][26])|([2468][048])))|([0-9][1-9][02468][048])|([1-9][0-9][02468][048]))\-02\-((0[1-9])|([12][0-9])))|((([0-9][0-9][0-9][1-9])|([1-9][0-9][0-9][0-9])|([0-9][1-9][0-9][0-9])|([0-9][0-9][1-9][0-9]))\-02\-((0[1-9])|([1][0-9])|([2][0-8])))"></asp:RegularExpressionValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBox3" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
  
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("to_date") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("to_date") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="نقطة الأستلام" SortExpression="to_point">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("to_point") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TextBox4" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                        
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("to_point") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("to_point") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="المسافه" SortExpression="distance">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("distance") %>'></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="TextBox5" ErrorMessage="Only english number" ForeColor="Red" ValidationExpression="^[0-9-.]*$"></asp:RegularExpressionValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="TextBox5" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                        
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("distance") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("distance") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="نوع التحميل" SortExpression="type">
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("type") %>'>
                            <asp:ListItem Value="2">فارغ</asp:ListItem>
                            <asp:ListItem Value="1">حموله</asp:ListItem>
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("type") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:DropDownList ID="DropDownList1" runat="server" Enabled="False" SelectedValue='<%# Bind("type") %>'>
                            <asp:ListItem Value="2">فارغ</asp:ListItem>
                            <asp:ListItem Value="1">حموله</asp:ListItem>
                        </asp:DropDownList>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="تكاليف الوقود" SortExpression="gas">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("gas") %>'></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" ControlToValidate="TextBox6" ErrorMessage="Only english number" ForeColor="Red" ValidationExpression="^[0-9-.]*$"></asp:RegularExpressionValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="TextBox6" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                        
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("gas") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("gas") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="العموله" SortExpression="commission">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("commission") %>'></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator9" runat="server" ControlToValidate="TextBox8" ErrorMessage="Only english number" ForeColor="Red" ValidationExpression="^[0-9-.]*$"></asp:RegularExpressionValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="TextBox8" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>
                        
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("commission") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label8" runat="server" Text='<%# Bind("commission") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CommandField CancelText="إلغاء" DeleteText="حذف" EditText="تعديل" ShowDeleteButton="True" ShowEditButton="True" UpdateText="تحديث" />
            </Fields>
        </asp:DetailsView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Route] WHERE ([Id] = @Id)" ConflictDetection="CompareAllValues" DeleteCommand="DELETE FROM [Route] WHERE [Id] = @original_Id AND (([from_date] = @original_from_date) OR ([from_date] IS NULL AND @original_from_date IS NULL)) AND (([from_point] = @original_from_point) OR ([from_point] IS NULL AND @original_from_point IS NULL)) AND (([to_date] = @original_to_date) OR ([to_date] IS NULL AND @original_to_date IS NULL)) AND (([to_point] = @original_to_point) OR ([to_point] IS NULL AND @original_to_point IS NULL)) AND (([distance] = @original_distance) OR ([distance] IS NULL AND @original_distance IS NULL)) AND (([type] = @original_type) OR ([type] IS NULL AND @original_type IS NULL)) AND (([gas] = @original_gas) OR ([gas] IS NULL AND @original_gas IS NULL)) AND (([commission] = @original_commission) OR ([commission] IS NULL AND @original_commission IS NULL))" InsertCommand="INSERT INTO [Route] ([from_date], [from_point], [to_date], [to_point], [distance], [type], [gas], [commission]) VALUES (@from_date, @from_point, @to_date, @to_point, @distance, @type, @gas, @commission)" OldValuesParameterFormatString="original_{0}" UpdateCommand="UPDATE [Route] SET [from_date] = @from_date, [from_point] = @from_point, [to_date] = @to_date, [to_point] = @to_point, [distance] = @distance, [type] = @type, [gas] = @gas, [commission] = @commission WHERE [Id] = @original_Id AND (([from_date] = @original_from_date) OR ([from_date] IS NULL AND @original_from_date IS NULL)) AND (([from_point] = @original_from_point) OR ([from_point] IS NULL AND @original_from_point IS NULL)) AND (([to_date] = @original_to_date) OR ([to_date] IS NULL AND @original_to_date IS NULL)) AND (([to_point] = @original_to_point) OR ([to_point] IS NULL AND @original_to_point IS NULL)) AND (([distance] = @original_distance) OR ([distance] IS NULL AND @original_distance IS NULL)) AND (([type] = @original_type) OR ([type] IS NULL AND @original_type IS NULL)) AND (([gas] = @original_gas) OR ([gas] IS NULL AND @original_gas IS NULL)) AND (([commission] = @original_commission) OR ([commission] IS NULL AND @original_commission IS NULL))">
        <DeleteParameters>
            <asp:Parameter Name="original_Id" Type="Int32" />
            <asp:Parameter Name="original_from_date" Type="String" />
            <asp:Parameter Name="original_from_point" Type="String" />
            <asp:Parameter Name="original_to_date" Type="String" />
            <asp:Parameter Name="original_to_point" Type="String" />
            <asp:Parameter Name="original_distance" Type="Int32" />
            <asp:Parameter Name="original_type" Type="Int32" />
            <asp:Parameter Name="original_gas" Type="Decimal" />
            <asp:Parameter Name="original_commission" Type="Decimal" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="from_date" Type="String" />
            <asp:Parameter Name="from_point" Type="String" />
            <asp:Parameter Name="to_date" Type="String" />
            <asp:Parameter Name="to_point" Type="String" />
            <asp:Parameter Name="distance" Type="Int32" />
            <asp:Parameter Name="type" Type="Int32" />
            <asp:Parameter Name="gas" Type="Decimal" />
            <asp:Parameter Name="commission" Type="Decimal" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="Id" QueryStringField="Id" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="from_date" Type="String" />
            <asp:Parameter Name="from_point" Type="String" />
            <asp:Parameter Name="to_date" Type="String" />
            <asp:Parameter Name="to_point" Type="String" />
            <asp:Parameter Name="distance" Type="Int32" />
            <asp:Parameter Name="type" Type="Int32" />
            <asp:Parameter Name="gas" Type="Decimal" />
            <asp:Parameter Name="commission" Type="Decimal" />
            <asp:Parameter Name="original_Id" Type="Int32" />
            <asp:Parameter Name="original_from_date" Type="String" />
            <asp:Parameter Name="original_from_point" Type="String" />
            <asp:Parameter Name="original_to_date" Type="String" />
            <asp:Parameter Name="original_to_point" Type="String" />
            <asp:Parameter Name="original_distance" Type="Int32" />
            <asp:Parameter Name="original_type" Type="Int32" />
            <asp:Parameter Name="original_gas" Type="Decimal" />
            <asp:Parameter Name="original_commission" Type="Decimal" />
        </UpdateParameters>
    </asp:SqlDataSource>
        <br />
  </div>
</asp:Content>

