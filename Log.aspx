<%@ Page Title="إحصائيات" Language="VB" MasterPageFile="~/MasterPage.master" %>

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
    Dim cn As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString)
    Dim cmd As SqlCommand
    Dim cmd1 As SqlCommand
    Dim cmd2 As SqlCommand
    Dim cmd3 As SqlCommand
    Dim dt1 As New DataSet

    Dim ro As DataRow
    Dim cname As DataColumn
    Dim dt As New DataTable()
    Dim dt2 As New DataTable()
    Dim dt3 As New DataTable()
#Region "NoToTxt"
    Sub NoToTxt(TheNo As Double, MyCur As String, MySubCur As String, total As String)
        total = NoToTxt1(TheNo, MyCur, MySubCur)


    End Sub
    Function NoToTxt1(TheNo As Double, MyCur As String, MySubCur As String) As String
        Dim MyArry1(0 To 9) As String
        Dim MyArry2(0 To 9) As String
        Dim MyArry3(0 To 9) As String
        Dim Myno As String
        Dim GetNo As String
        Dim RdNo As String
        Dim My100 As String
        Dim My10 As String
        Dim My1 As String
        Dim My11 As String
        Dim My12 As String
        Dim GetTxt As String
        Dim Mybillion As String
        Dim MyMillion As String
        Dim MyThou As String
        Dim MyHun As String
        Dim MyFraction As String
        Dim MyAnd As String
        Dim I As Integer
        Dim ReMark As String


        If TheNo > 999999999999.99 Then Exit Function

        If TheNo < 0 Then
            TheNo = TheNo * -1
            ReMark = "يتبقى لكم "
        Else
            ReMark = "فقط "
        End If

        If TheNo = 0 Then
            NoToTxt1 = "صفر"
            Exit Function
        End If

        MyAnd = " و"
        MyArry1(0) = ""
        MyArry1(1) = "مائة"
        MyArry1(2) = "مائتان"
        MyArry1(3) = "ثلاثمائة"
        MyArry1(4) = "أربعمائة"
        MyArry1(5) = "خمسمائة"
        MyArry1(6) = "ستمائة"
        MyArry1(7) = "سبعمائة"
        MyArry1(8) = "ثمانمائة"
        MyArry1(9) = "تسعمائة"

        MyArry2(0) = ""
        MyArry2(1) = " عشر"
        MyArry2(2) = "عشرون"
        MyArry2(3) = "ثلاثون"
        MyArry2(4) = "أربعون"
        MyArry2(5) = "خمسون"
        MyArry2(6) = "ستون"
        MyArry2(7) = "سبعون"
        MyArry2(8) = "ثمانون"
        MyArry2(9) = "تسعون"

        MyArry3(0) = ""
        MyArry3(1) = "واحد"
        MyArry3(2) = "اثنان"
        MyArry3(3) = "ثلاثة"
        MyArry3(4) = "أربعة"
        MyArry3(5) = "خمسة"
        MyArry3(6) = "ستة"
        MyArry3(7) = "سبعة"
        MyArry3(8) = "ثمانية"
        MyArry3(9) = "تسعة"
        '======================

        GetNo = Format(TheNo, "000000000000.00")

        I = 0
        Do While I < 15

            If I < 12 Then
                Myno = Mid$(GetNo, I + 1, 3)
            Else
                Myno = "0" + Mid$(GetNo, I + 2, 2)
            End If

            If (Mid$(Myno, 1, 3)) > 0 Then

                RdNo = Mid$(Myno, 1, 1)
                My100 = MyArry1(RdNo)
                RdNo = Mid$(Myno, 3, 1)
                My1 = MyArry3(RdNo)
                RdNo = Mid$(Myno, 2, 1)
                My10 = MyArry2(RdNo)

                If Mid$(Myno, 2, 2) = 11 Then My11 = "إحدى عشر"
                If Mid$(Myno, 2, 2) = 12 Then My12 = "إثنى عشر"
                If Mid$(Myno, 2, 2) = 10 Then My10 = "عشرة"

                If ((Mid$(Myno, 1, 1)) > 0) And ((Mid$(Myno, 2, 2)) > 0) Then My100 = My100 + MyAnd
                If ((Mid$(Myno, 3, 1)) > 0) And ((Mid$(Myno, 2, 1)) > 1) Then My1 = My1 + MyAnd

                GetTxt = My100 + My1 + My10

                If ((Mid$(Myno, 3, 1)) = 1) And ((Mid$(Myno, 2, 1)) = 1) Then
                    GetTxt = My100 + My11
                    If ((Mid$(Myno, 1, 1)) = 0) Then GetTxt = My11
                End If

                If ((Mid$(Myno, 3, 1)) = 2) And ((Mid$(Myno, 2, 1)) = 1) Then
                    GetTxt = My100 + My12
                    If ((Mid$(Myno, 1, 1)) = 0) Then GetTxt = My12
                End If

                If (I = 0) And (GetTxt <> "") Then
                    If ((Mid$(Myno, 1, 3)) > 10) Then
                        Mybillion = GetTxt + " مليار"
                    Else
                        Mybillion = GetTxt + " مليارات"
                        If ((Mid$(Myno, 1, 3)) = 2) Then Mybillion = " مليار"
                        If ((Mid$(Myno, 1, 3)) = 2) Then Mybillion = " ملياران"
                    End If
                End If

                If (I = 3) And (GetTxt <> "") Then

                    If ((Mid$(Myno, 1, 3)) > 10) Then
                        MyMillion = GetTxt + " مليون"
                    Else
                        MyMillion = GetTxt + " ملايين"
                        If ((Mid$(Myno, 1, 3)) = 1) Then MyMillion = " مليون"
                        If ((Mid$(Myno, 1, 3)) = 2) Then MyMillion = " مليونان"
                    End If
                End If

                If (I = 6) And (GetTxt <> "") Then
                    If ((Mid$(Myno, 1, 3)) > 10) Then
                        MyThou = GetTxt + " ألف"
                    Else
                        MyThou = GetTxt + " آلاف"
                        If ((Mid$(Myno, 3, 1)) = 1) Then MyThou = " ألف"
                        If ((Mid$(Myno, 3, 1)) = 2) Then MyThou = " ألفان"
                    End If
                End If

                If (I = 9) And (GetTxt <> "") Then MyHun = GetTxt
                If (I = 12) And (GetTxt <> "") Then MyFraction = GetTxt
            End If

            I = I + 3
        Loop

        If (Mybillion <> "") Then
            If (MyMillion <> "") Or (MyThou <> "") Or (MyHun <> "") Then Mybillion = Mybillion + MyAnd
        End If

        If (MyMillion <> "") Then
            If (MyThou <> "") Or (MyHun <> "") Then MyMillion = MyMillion + MyAnd
        End If

        If (MyThou <> "") Then
            If (MyHun <> "") Then MyThou = MyThou + MyAnd
        End If

        If MyFraction <> "" Then
            If (Mybillion <> "") Or (MyMillion <> "") Or (MyThou <> "") Or (MyHun <> "") Then
                NoToTxt1 = ReMark + Mybillion + MyMillion + MyThou + MyHun + " " + MyCur + MyAnd + MyFraction + " " + MySubCur
            Else
                NoToTxt1 = ReMark + MyFraction + " " + MySubCur
            End If
        Else
            NoToTxt1 = ReMark + Mybillion + MyMillion + MyThou + MyHun + " " + MyCur
        End If

    End Function
#End Region
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("Admin") = "" Then
            Response.Redirect("Login.aspx")
        End If
        Dim Warining As StringBuilder = New StringBuilder
        Dim notruck As String = "لايوجد سائق"
        Dim commaned As SqlCommand = New SqlCommand("Select * from Income Where TruckName=@Name", cn)
        commaned.Parameters.AddWithValue("@Name", notruck)

        cn.Open()

        Dim reader As SqlDataReader = commaned.ExecuteReader


        If reader.HasRows Then


            While reader.Read
                Warining.Append("<div class=""container""><div class=""alert alert-danger"" id=""myAlert"" style=""text-align:right;"" >")
                Warining.AppendFormat("يوجد فاتوره لايوجد سائق لها <a href=""IncomeEdit.aspx?ID={0}""> اضغط هنا للتعديل</a>           <img src=""Image\attention2.png"" height=""30px"" weight=""30px""/>", reader(0))
                Warining.Append("</div></div>")
            End While


        End If

        cn.Close()

        Dim Warining1 As StringBuilder = New StringBuilder

        commaned = New SqlCommand("Select * from Route Where TrackName=@Name", cn)
        commaned.Parameters.AddWithValue("@Name", notruck)


        Dim reader1 As SqlDataReader
        cn.Open()

        reader1 = commaned.ExecuteReader


        If reader1.HasRows Then


            While reader1.Read
                Warining1.Append("<div class=""container""><div class=""alert alert-danger"" id=""myAlert"" style=""text-align:right;"" >")
                Warining1.AppendFormat("يوجد مسار لايوجد سائق له <a href=""RouteEdit.aspx?ID={0}""> اضغط هنا للتعديل</a>           <img src=""Image\attention2.png"" height=""30px"" weight=""30px""/>", reader1(0))
                Warining1.Append("</div></div>")
            End While


        End If

        cn.Close()

        Dim Warining2 As StringBuilder = New StringBuilder

        commaned = New SqlCommand("Select * from Expenses Where TruckName=@Name", cn)
        commaned.Parameters.AddWithValue("@Name", notruck)
        Dim reader2 As SqlDataReader

        cn.Open()

        reader2 = commaned.ExecuteReader


        If reader2.HasRows Then


            While reader2.Read
                Warining2.Append("<div class=""container""><div class=""alert alert-danger"" id=""myAlert"" style=""text-align:right;"" >")
                Warining2.AppendFormat("يوجد مصروف لايوجد سائق له <a href=""ExpensesEdit.aspx?ID={0}""> اضغط هنا للتعديل</a>           <img src=""Image\attention2.png"" height=""30px"" weight=""30px""/>", reader2(0))
                Warining2.Append("</div></div>")
            End While

            Literal1.Text = Warining2.ToString + Warining1.ToString + Warining.ToString
        End If
        cn.Close()

        If IsPostBack = True Then

            If DropDownList1.SelectedValue <> "-1" Then
                MonthPanel.Visible = True

                Dim CurrentKM As Integer = 0

                cmd = New SqlCommand("select KM from Route ", cn)
                cn.Open()
                Dim LastKM As SqlDataReader = cmd.ExecuteReader()
                While LastKM.Read
                    If Not IsDBNull(LastKM(0)) Then
                        If CurrentKM < LastKM(0) Then

                            CurrentKM = LastKM(0)
                        End If
                    End If

                End While
                If CurrentKM <> Nothing Then
                    Label12.Text = CurrentKM
                Else
                    Label12.Text = "NA"
                End If

                LastKM.Close()
                Dim OldKM As Integer = 0
                LastKM=  cmd.ExecuteReader()

                While (LastKM.Read)
                    If Not IsDBNull(LastKM(0)) Then

                        If CurrentKM > LastKM(0) Then
                            If OldKM < LastKM(0) Then
                                OldKM = LastKM(0)

                            End If
                        End If
                    End If
                End While
                If OldKM <> Nothing Then
                    Label11.Text = OldKM
                Else
                    Label11.Text = "NA"
                End If


                cn.Close()
                cname = New DataColumn("حاله السداد", Type.GetType("System.String"))
                dt.Columns.Add(cname)
                cname = New DataColumn("Invoice", Type.GetType("System.String"))
                dt.Columns.Add(cname)
                cname = New DataColumn("InvoiceText", Type.GetType("System.String"))
                dt.Columns.Add(cname)
                cname = New DataColumn("اسم التريله", Type.GetType("System.String"))
                dt.Columns.Add(cname)
                cname = New DataColumn("المبلغ", Type.GetType("System.String"))
                dt.Columns.Add(cname)
                cname = New DataColumn("(الوزن (طن", Type.GetType("System.String"))
                dt.Columns.Add(cname)
                cname = New DataColumn("سعر الطن", Type.GetType("System.String"))
                dt.Columns.Add(cname)
                cname = New DataColumn("تاريخ الوصول", Type.GetType("System.String"))
                dt.Columns.Add(cname)
                cname = New DataColumn("رقم الفاتوره", Type.GetType("System.String"))
                dt.Columns.Add(cname)
                cname = New DataColumn("إلى", Type.GetType("System.String"))
                dt.Columns.Add(cname)
                cname = New DataColumn("أسم المستلم", Type.GetType("System.String"))
                dt.Columns.Add(cname)
                cname = New DataColumn("من", Type.GetType("System.String"))
                dt.Columns.Add(cname)
                cname = New DataColumn("أسم المرسل", Type.GetType("System.String"))
                dt.Columns.Add(cname)
                cname = New DataColumn("تاريخ الأرسال", Type.GetType("System.String"))
                dt.Columns.Add(cname)
                cname = New DataColumn("#", Type.GetType("System.String"))
                dt.Columns.Add(cname)
                cname = New DataColumn("ID", Type.GetType("System.String"))
                dt.Columns.Add(cname)



                cname = New DataColumn("العموله", Type.GetType("System.String"))
                dt2.Columns.Add(cname)
                cname = New DataColumn("اسم التريله", Type.GetType("System.String"))
                dt2.Columns.Add(cname)

                cname = New DataColumn("تكاليف الوقود", Type.GetType("System.String"))
                dt2.Columns.Add(cname)
                cname = New DataColumn("نوع التحميل", Type.GetType("System.String"))
                dt2.Columns.Add(cname)
                cname = New DataColumn("المسافه", Type.GetType("System.String"))
                dt2.Columns.Add(cname)
                cname = New DataColumn("تاريخ الأستلام", Type.GetType("System.String"))
                dt2.Columns.Add(cname)
                cname = New DataColumn("نقطة الأستلام", Type.GetType("System.String"))
                dt2.Columns.Add(cname)
                cname = New DataColumn("نقطة الأنطلاق", Type.GetType("System.String"))
                dt2.Columns.Add(cname)
                cname = New DataColumn("تاريخ الأنطلاق", Type.GetType("System.String"))
                dt2.Columns.Add(cname)
                cname = New DataColumn("#", Type.GetType("System.String"))
                dt2.Columns.Add(cname)
                cname = New DataColumn("ID", Type.GetType("System.String"))
                dt2.Columns.Add(cname)

                cname = New DataColumn("InvoiceText", Type.GetType("System.String"))
                dt3.Columns.Add(cname)
                cname = New DataColumn("Invoice", Type.GetType("System.String"))
                dt3.Columns.Add(cname)
                cname = New DataColumn("اسم التريله", Type.GetType("System.String"))
                dt3.Columns.Add(cname)
                cname = New DataColumn("الوصف", Type.GetType("System.String"))
                dt3.Columns.Add(cname)
                cname = New DataColumn("رقم المستند", Type.GetType("System.String"))
                dt3.Columns.Add(cname)
                cname = New DataColumn("الكميه", Type.GetType("System.String"))
                dt3.Columns.Add(cname)
                cname = New DataColumn("المبلغ", Type.GetType("System.String"))
                dt3.Columns.Add(cname)
                cname = New DataColumn("التاريخ", Type.GetType("System.String"))
                dt3.Columns.Add(cname)
                cname = New DataColumn("#", Type.GetType("System.String"))
                dt3.Columns.Add(cname)
                cname = New DataColumn("ID", Type.GetType("System.String"))
                dt3.Columns.Add(cname)

                Dim dis As Integer = 0

                Dim id As Integer = 1
                Dim income As Double = 0
                Dim Expenses As Double = 0
                Dim Route As Double = 0
                Dim commission As Double = 0
                cmd = New SqlCommand("select * from Income where substring(date,0,8)='" + DropDownList1.SelectedValue + "'", cn)
                cmd1 = New SqlCommand("select * from Expenses where substring(date,0,8)='" + DropDownList1.SelectedValue + "'", cn)
                cmd2 = New SqlCommand("select * from Route where substring(from_date,0,8)='" + DropDownList1.SelectedValue + "' order by from_date", cn)
                cmd3 = New SqlCommand("select * from Route where substring(from_date,0,8)='" + DropDownList1.SelectedValue + "' and type=1", cn)
                cn.Open()
                Dim sqlreader As SqlDataReader = cmd.ExecuteReader
                If sqlreader.HasRows = False Then
                    GridView1.Visible = False
                    bt1.Visible = False
                    Label8.Visible = False
                Else

                    While (sqlreader.Read)
                        income = income + Convert.ToDouble(sqlreader("Amount"))
                        ro = dt.NewRow()

                        ro("ID") = sqlreader(0)
                        ro(14) = id
                        ro(13) = sqlreader(6)
                        ro(12) = sqlreader(1)
                        ro(11) = sqlreader(2)
                        ro(10) = sqlreader(3)
                        ro(9) = sqlreader(4)
                        ro(8) = sqlreader(5)
                        ro(7) = sqlreader(11)
                        ro(6) = sqlreader(9)
                        ro(5) = sqlreader(7)
                        ro(4) = sqlreader(8)
                        ro(3) = sqlreader(12)
                        If (IsDBNull(sqlreader(10))) Then


                            ro(2) = "NO Invoice"
                        Else


                            ro(1) = sqlreader(10)

                            ro(2) = sqlreader(10).ToString.Remove(0, sqlreader(10).ToString.LastIndexOf("/") + 1)
                        End If
                        ro(0) = sqlreader(13)
                        id = id + 1
                        dt.Rows.Add(ro)

                    End While



                End If

                id = 1
                sqlreader.Close()
                dt1.Tables.Add(dt)

                GridView1.DataSource = dt1.Tables(0)

                GridView1.DataBind()
                Dim count As Integer = 0
                Dim sqlreader2 As SqlDataReader = cmd2.ExecuteReader
                If sqlreader2.HasRows = False Then
                    GridView2.Visible = False
                    Button1.Visible = False
                    Label9.Visible = False
                Else
                    While (sqlreader2.Read)
                        ro = dt2.NewRow()
                        Route = Route + Convert.ToDouble(sqlreader2("gas"))
                        commission = commission + sqlreader2("commission")
                        dis = dis + sqlreader2("distance")

                        ro(10) = sqlreader2(0)
                        ro(9) = id
                        ro(8) = sqlreader2(1)
                        ro(7) = sqlreader2(2)
                        ro(6) = sqlreader2(4)
                        ro(5) = sqlreader2(3)
                        ro(4) = sqlreader2(5)
                        If (sqlreader2(6) = "1") Then
                            ro(3) = "حموله"
                        Else
                            ro(3) = "فارغ"
                        End If
                        ro(2) = sqlreader2(7)
                        ro(1) = sqlreader2(9)
                        ro(0) = sqlreader2(8)
                        dt2.Rows.Add(ro)
                        id = id + 1
                    End While
                    sqlreader2.Close()
                    sqlreader2 = cmd3.ExecuteReader
                    While (sqlreader2.Read)
                        count = count + 1
                    End While

                End If
                dt1.Tables.Add(dt2)
                GridView2.DataSource = dt1.Tables(1)
                GridView2.DataBind()

                sqlreader2.Close()
                Dim sqlreader1 As SqlDataReader = cmd1.ExecuteReader
                id = 1
                If sqlreader1.HasRows = False Then
                    GridView3.Visible = False
                    Button2.Visible = False
                    Label10.Visible = False
                Else
                    While (sqlreader1.Read)
                        Expenses = Expenses + sqlreader1("money")
                        ro = dt3.NewRow()

                        If IsDBNull(sqlreader1(6)) Then
                            ro(0) = "No Invoice"

                        Else

                            ro(0) = sqlreader1(6).ToString.Remove(0, sqlreader1(6).ToString.LastIndexOf("/") + 1)
                            ro(1) = sqlreader1(6)

                        End If
                        ro(2) = sqlreader1(7)
                        ro(3) = sqlreader1(5)
                        ro(4) = sqlreader1(4)
                        ro(5) = sqlreader1(3)
                        ro(6) = sqlreader1(2)
                        ro(7) = sqlreader1(1)
                        ro(8) = id
                        ro(9) = sqlreader1(0)





                        id = id + 1
                        dt3.Rows.Add(ro)
                    End While
                End If

                id = 1
                dt1.Tables.Add(dt3)
                GridView3.DataSource = dt1.Tables(2)
                GridView3.DataBind()
                sqlreader1.Close()

                cn.Close()
                Label1.Text = income
                Label3.Text = Route
                Label2.Text = commission
                Label5.Text = count
                Label7.Text = Expenses
                If (income + commission) - (Expenses + Route) < 0 Then
                    Label4.ForeColor = Color.Red
                Else
                    Label4.ForeColor = Color.Green
                End If
                Label4.Text = (income) - (Expenses + Route + commission)

                Label6.Text = dis
                Label1.Visible = True
                Label2.Visible = True
                Label3.Visible = True
                Label4.Visible = True
                Panel1.Visible = True


                If Label11.Text <> "NA" And Label12.Text <> "NA" Then
                    Label13.Text = Math.Abs(Label12.Text - Label11.Text)
                Else
                    Label13.Text="NA"
                End If
            Else
                Panel1.Visible = False
                MonthPanel.Visible=False

            End If

        End If

    End Sub
    Protected Sub GridView3_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        e.Row.Cells(2).Text = ""
        e.Row.Cells(3).Text = ""

        e.Row.Cells(2).Visible = False
        e.Row.Cells(3).Visible = False
        e.Row.Cells(11).Visible = False
    End Sub

    Protected Sub DropDownList1_DataBound(sender As Object, e As EventArgs)
        Dim newListItem As ListItem
        newListItem = New ListItem("--أختر التاريخ --", -1)
        newListItem.Selected = True
        DropDownList1.Items.Insert(0, newListItem)

    End Sub


    Protected Sub bt1_Click(sender As Object, e As EventArgs) Handles bt1.Click
        Using wb As New XLWorkbook()
            wb.Worksheets.Add(dt, "الدخل" + DropDownList1.SelectedItem.ToString)

            Response.Clear()
            Response.Buffer = True
            Response.Charset = ""
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
            Response.AddHeader("content-disposition", "attachment;filename=الدخل" + DropDownList1.SelectedItem.ToString + "'.xlsx")
            Using MyMemoryStream As New MemoryStream()
                wb.SaveAs(MyMemoryStream)
                MyMemoryStream.WriteTo(Response.OutputStream)
                Response.Flush()
                Response.End()
            End Using
        End Using
    End Sub

    Protected Sub Button2_Click(sender As Object, e As EventArgs)
        Using wb As New XLWorkbook()
            wb.Worksheets.Add(dt3, "المصاريف" + DropDownList1.SelectedItem.ToString)

            Response.Clear()
            Response.Buffer = True
            Response.Charset = ""
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
            Response.AddHeader("content-disposition", "attachment;filename=المصاريف'" + DropDownList1.SelectedItem.ToString + "'.xlsx")
            Using MyMemoryStream As New MemoryStream()
                wb.SaveAs(MyMemoryStream)
                MyMemoryStream.WriteTo(Response.OutputStream)
                Response.Flush()
                Response.End()
            End Using
        End Using
    End Sub

    Protected Sub Button3_Click(sender As Object, e As EventArgs)

        If DropDownList3.SelectedValue <> "-1" Then

            cmd = New SqlCommand("Select *  from Income where substring(Date,0,8)=@Date and Name_from=@Namefrom and f_rom=@From", cn)
            cmd.Parameters.AddWithValue("@Date", DropDownList1.SelectedValue)
            cmd.Parameters.AddWithValue("@Namefrom", DropDownList2.SelectedValue)
            cmd.Parameters.AddWithValue("@From", DropDownList3.SelectedValue)
            Dim FirstCell As String = String.Empty
            Dim SecondCell As String = String.Empty
            Dim wbXl1 As ClosedXML.Excel.XLWorkbook = New XLWorkbook
            wbXl1.RightToLeft = True
            wbXl1.Style.Font.FontSize = 12
            wbXl1.Style.Alignment.ShrinkToFit = True


            Dim shXL1 = wbXl1.Worksheets.Add("Contacts")
            shXL1.Cell("D2").Value = "فاتوره"
            Dim rngTable = shXL1.Range("D2:H2")
            rngTable.Merge()
            rngTable.Style.Font.Bold = True
            rngTable.Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center)
            rngTable.Style.Font.FontSize = 14









            shXL1.Cell("B3").Value = "مؤسسة"

            rngTable = shXL1.Range("B3:F3")
            rngTable.Merge()
            rngTable.Style.Font.Bold = True
            shXL1.Cell("H3").Value = "تاريخ"
            shXL1.Cell("I3").SetValue(Date.Now.ToShortDateString())

            shXL1.Cell("B4").Value = "/جوال"
            shXL1.Cell("B5").Value = "/هاتف"
            shXL1.Cell("B7").Value = "/سادة"
            shXL1.Cell("C7").Value = DropDownList2.SelectedValue
            rngTable = shXL1.Range("C7:G7")
            rngTable.Merge()
            shXL1.Cell("H7").Value = "المحترمين"
            shXL1.Cell("B9").Value = "تسلسل"
            shXL1.Cell("B9").Style.Font.Bold = True
            shXL1.Cell("B9").Style.Font.FontSize = 9
            shXL1.Cell("B9").Style.Border.BottomBorder = XLBorderStyleValues.Thin
            shXL1.Cell("B9").Style.Border.TopBorder = XLBorderStyleValues.Thin
            shXL1.Cell("B9").Style.Border.LeftBorder = XLBorderStyleValues.Thin
            shXL1.Cell("B9").Style.Border.RightBorder = XLBorderStyleValues.Thin
            shXL1.Cell("C9").Value = "السعر الإجمالي"
            shXL1.Cell("C9").Style.Font.Bold = True
            shXL1.Cell("C9").Style.Font.FontSize = 14
            shXL1.Cell("C9").Style.Border.BottomBorder = XLBorderStyleValues.Thin
            shXL1.Cell("C9").Style.Border.TopBorder = XLBorderStyleValues.Thin
            shXL1.Cell("C9").Style.Border.LeftBorder = XLBorderStyleValues.Thin
            shXL1.Cell("C9").Style.Border.RightBorder = XLBorderStyleValues.Thin

            shXL1.Cell("D9").Value = "السعر الفردي"
            shXL1.Cell("D9").Style.Font.Bold = True
            shXL1.Cell("D9").Style.Font.FontSize = 14

            shXL1.Cell("D9").Style.Border.BottomBorder = XLBorderStyleValues.Thin
            shXL1.Cell("D9").Style.Border.TopBorder = XLBorderStyleValues.Thin
            shXL1.Cell("D9").Style.Border.LeftBorder = XLBorderStyleValues.Thin
            shXL1.Cell("D9").Style.Border.RightBorder = XLBorderStyleValues.Thin
            shXL1.Cell("E9").Value = "(الوزن (طن"
            shXL1.Cell("E9").Style.Font.Bold = True
            shXL1.Cell("E9").Style.Font.FontSize = 14
            shXL1.Cell("E9").Style.Border.BottomBorder = XLBorderStyleValues.Thin
            shXL1.Cell("E9").Style.Border.TopBorder = XLBorderStyleValues.Thin
            shXL1.Cell("E9").Style.Border.LeftBorder = XLBorderStyleValues.Thin
            shXL1.Cell("E9").Style.Border.RightBorder = XLBorderStyleValues.Thin
            shXL1.Cell("F9").Value = "تاريخ التحميل"
            shXL1.Cell("F9").Style.Font.Bold = True
            shXL1.Cell("F9").Style.Font.FontSize = 14
            shXL1.Cell("F9").Style.Border.BottomBorder = XLBorderStyleValues.Thin
            shXL1.Cell("F9").Style.Border.TopBorder = XLBorderStyleValues.Thin
            shXL1.Cell("F9").Style.Border.LeftBorder = XLBorderStyleValues.Thin
            shXL1.Cell("F9").Style.Border.RightBorder = XLBorderStyleValues.Thin
            shXL1.Cell("G9").Value = "البيــــــــــــــــــــــــــــان"
            shXL1.Cell("G9").Style.Font.Bold = True
            shXL1.Cell("G9").Style.Font.FontSize = 14
            rngTable = shXL1.Range("G9:J9")
            rngTable.Merge()
            rngTable.Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center)
            shXL1.Cell("G9").Style.Border.BottomBorder = XLBorderStyleValues.Thin
            shXL1.Cell("G9").Style.Border.TopBorder = XLBorderStyleValues.Thin
            shXL1.Cell("G9").Style.Border.LeftBorder = XLBorderStyleValues.Thin
            shXL1.Cell("G9").Style.Border.RightBorder = XLBorderStyleValues.Thin

            shXL1.Cell("H9").Style.Border.BottomBorder = XLBorderStyleValues.Thin
            shXL1.Cell("H9").Style.Border.TopBorder = XLBorderStyleValues.Thin
            shXL1.Cell("H9").Style.Border.LeftBorder = XLBorderStyleValues.Thin
            shXL1.Cell("H9").Style.Border.RightBorder = XLBorderStyleValues.Thin

            shXL1.Cell("I9").Style.Border.BottomBorder = XLBorderStyleValues.Thin
            shXL1.Cell("I9").Style.Border.TopBorder = XLBorderStyleValues.Thin
            shXL1.Cell("I9").Style.Border.LeftBorder = XLBorderStyleValues.Thin
            shXL1.Cell("I9").Style.Border.RightBorder = XLBorderStyleValues.Thin

            shXL1.Cell("J9").Style.Border.BottomBorder = XLBorderStyleValues.Thin
            shXL1.Cell("J9").Style.Border.TopBorder = XLBorderStyleValues.Thin
            shXL1.Cell("J9").Style.Border.LeftBorder = XLBorderStyleValues.Thin
            shXL1.Cell("J9").Style.Border.RightBorder = XLBorderStyleValues.Thin

            rngTable = shXL1.Range("B9:J9")
            rngTable.Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center)
            cn.Open()
            Dim result As SqlDataReader = cmd.ExecuteReader

            Dim row As Integer = 10
            Dim counter As Integer = 1
            Dim total As Double = 0

            While result.Read
                shXL1.Cell("B" + row.ToString()).Value = counter
                shXL1.Cell("B" + row.ToString()).Style.Border.BottomBorder = XLBorderStyleValues.Thin
                shXL1.Cell("B" + row.ToString()).Style.Border.TopBorder = XLBorderStyleValues.Thin
                shXL1.Cell("B" + row.ToString()).Style.Border.LeftBorder = XLBorderStyleValues.Thin
                shXL1.Cell("B" + row.ToString()).Style.Border.RightBorder = XLBorderStyleValues.Thin

                shXL1.Cell("C" + row.ToString()).Value = result(8)
                shXL1.Cell("C" + row.ToString()).Style.Border.BottomBorder = XLBorderStyleValues.Thin
                shXL1.Cell("C" + row.ToString()).Style.Border.TopBorder = XLBorderStyleValues.Thin
                shXL1.Cell("C" + row.ToString()).Style.Border.LeftBorder = XLBorderStyleValues.Thin
                shXL1.Cell("C" + row.ToString()).Style.Border.RightBorder = XLBorderStyleValues.Thin

                shXL1.Cell("D" + row.ToString()).Value = result(9)
                shXL1.Cell("D" + row.ToString()).Style.Border.BottomBorder = XLBorderStyleValues.Thin
                shXL1.Cell("D" + row.ToString()).Style.Border.TopBorder = XLBorderStyleValues.Thin
                shXL1.Cell("D" + row.ToString()).Style.Border.LeftBorder = XLBorderStyleValues.Thin
                shXL1.Cell("D" + row.ToString()).Style.Border.RightBorder = XLBorderStyleValues.Thin

                shXL1.Cell("E" + row.ToString()).Value = result(7)
                shXL1.Cell("E" + row.ToString()).Style.Border.BottomBorder = XLBorderStyleValues.Thin
                shXL1.Cell("E" + row.ToString()).Style.Border.TopBorder = XLBorderStyleValues.Thin
                shXL1.Cell("E" + row.ToString()).Style.Border.LeftBorder = XLBorderStyleValues.Thin
                shXL1.Cell("E" + row.ToString()).Style.Border.RightBorder = XLBorderStyleValues.Thin

                shXL1.Cell("F" + row.ToString()).Value = result(6).ToString()
                shXL1.Cell("F" + row.ToString()).Style.Border.BottomBorder = XLBorderStyleValues.Thin
                shXL1.Cell("F" + row.ToString()).Style.Border.TopBorder = XLBorderStyleValues.Thin
                shXL1.Cell("F" + row.ToString()).Style.Border.LeftBorder = XLBorderStyleValues.Thin
                shXL1.Cell("F" + row.ToString()).Style.Border.RightBorder = XLBorderStyleValues.Thin
                FirstCell = "G" + row.ToString
                SecondCell = "J" + row.ToString

                shXL1.Cell(FirstCell).Value = " حموله من " + result(2).ToString() + "  إلى  " + result(4).ToString() + "   فاتوره رقم   (" + result(5).ToString() + ")"
                rngTable = shXL1.Range(String.Format("{0}:{1}", FirstCell, SecondCell))
                rngTable.Merge()
                rngTable.Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center)
                shXL1.Cell("G" + row.ToString()).Style.Border.BottomBorder = XLBorderStyleValues.Thin
                shXL1.Cell("G" + row.ToString()).Style.Border.TopBorder = XLBorderStyleValues.Thin
                shXL1.Cell("G" + row.ToString()).Style.Border.LeftBorder = XLBorderStyleValues.Thin
                shXL1.Cell("G" + row.ToString()).Style.Border.RightBorder = XLBorderStyleValues.Thin

                shXL1.Cell("H" + row.ToString()).Style.Border.BottomBorder = XLBorderStyleValues.Thin
                shXL1.Cell("H" + row.ToString()).Style.Border.TopBorder = XLBorderStyleValues.Thin
                shXL1.Cell("H" + row.ToString()).Style.Border.LeftBorder = XLBorderStyleValues.Thin
                shXL1.Cell("H" + row.ToString()).Style.Border.RightBorder = XLBorderStyleValues.Thin

                shXL1.Cell("I" + row.ToString()).Style.Border.BottomBorder = XLBorderStyleValues.Thin
                shXL1.Cell("I" + row.ToString()).Style.Border.TopBorder = XLBorderStyleValues.Thin
                shXL1.Cell("I" + row.ToString()).Style.Border.LeftBorder = XLBorderStyleValues.Thin
                shXL1.Cell("I" + row.ToString()).Style.Border.RightBorder = XLBorderStyleValues.Thin

                shXL1.Cell("J" + row.ToString()).Style.Border.BottomBorder = XLBorderStyleValues.Thin
                shXL1.Cell("J" + row.ToString()).Style.Border.TopBorder = XLBorderStyleValues.Thin
                shXL1.Cell("J" + row.ToString()).Style.Border.LeftBorder = XLBorderStyleValues.Thin
                shXL1.Cell("J" + row.ToString()).Style.Border.RightBorder = XLBorderStyleValues.Thin
                rngTable = shXL1.Range(String.Format("B{0}:J{1}", row, row))
                rngTable.Style.Alignment.SetVertical(XLAlignmentVerticalValues.Center)
                row = row + 1
                counter = counter + 1
                total = total + result(8)
            End While
            shXL1.Cell("B" + row.ToString()).Value = "المجموع"
            shXL1.Cell("B" + row.ToString()).Style.Border.BottomBorder = XLBorderStyleValues.Thin
            shXL1.Cell("B" + row.ToString()).Style.Border.TopBorder = XLBorderStyleValues.Thin
            shXL1.Cell("B" + row.ToString()).Style.Border.LeftBorder = XLBorderStyleValues.Thin
            shXL1.Cell("B" + row.ToString()).Style.Border.RightBorder = XLBorderStyleValues.Thin
            shXL1.Cell("C" + row.ToString()).Value = total
            shXL1.Cell("C" + row.ToString()).Style.Border.BottomBorder = XLBorderStyleValues.Thin
            shXL1.Cell("C" + row.ToString()).Style.Border.TopBorder = XLBorderStyleValues.Thin
            shXL1.Cell("C" + row.ToString()).Style.Border.LeftBorder = XLBorderStyleValues.Thin
            shXL1.Cell("C" + row.ToString()).Style.Border.RightBorder = XLBorderStyleValues.Thin
            shXL1.Cell("D" + row.ToString()).Value = NoToTxt1(total, "ريال", "هلله لاغير")
            shXL1.Cell("D" + row.ToString()).Style.Border.BottomBorder = XLBorderStyleValues.Thin
            shXL1.Cell("D" + row.ToString()).Style.Border.TopBorder = XLBorderStyleValues.Thin
            shXL1.Cell("D" + row.ToString()).Style.Border.LeftBorder = XLBorderStyleValues.Thin
            shXL1.Cell("D" + row.ToString()).Style.Border.RightBorder = XLBorderStyleValues.Thin
            FirstCell = "D" + row.ToString
            SecondCell = "J" + row.ToString()
            rngTable = shXL1.Range(String.Format("{0}:{1}", FirstCell, SecondCell))
            rngTable.Merge()
            rngTable.Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center)
            rngTable.Style.Alignment.SetVertical(XLAlignmentVerticalValues.Center)
            rngTable.Style.Font.Bold = True
            shXL1.Cell("E" + row.ToString()).Style.Border.BottomBorder = XLBorderStyleValues.Thin
            shXL1.Cell("E" + row.ToString()).Style.Border.TopBorder = XLBorderStyleValues.Thin
            shXL1.Cell("E" + row.ToString()).Style.Border.LeftBorder = XLBorderStyleValues.Thin
            shXL1.Cell("E" + row.ToString()).Style.Border.RightBorder = XLBorderStyleValues.Thin

            shXL1.Cell("F" + row.ToString()).Style.Border.BottomBorder = XLBorderStyleValues.Thin
            shXL1.Cell("F" + row.ToString()).Style.Border.TopBorder = XLBorderStyleValues.Thin
            shXL1.Cell("F" + row.ToString()).Style.Border.LeftBorder = XLBorderStyleValues.Thin
            shXL1.Cell("F" + row.ToString()).Style.Border.RightBorder = XLBorderStyleValues.Thin

            shXL1.Cell("G" + row.ToString()).Style.Border.BottomBorder = XLBorderStyleValues.Thin
            shXL1.Cell("G" + row.ToString()).Style.Border.TopBorder = XLBorderStyleValues.Thin
            shXL1.Cell("G" + row.ToString()).Style.Border.LeftBorder = XLBorderStyleValues.Thin
            shXL1.Cell("G" + row.ToString()).Style.Border.RightBorder = XLBorderStyleValues.Thin

            shXL1.Cell("H" + row.ToString()).Style.Border.BottomBorder = XLBorderStyleValues.Thin
            shXL1.Cell("H" + row.ToString()).Style.Border.TopBorder = XLBorderStyleValues.Thin
            shXL1.Cell("H" + row.ToString()).Style.Border.LeftBorder = XLBorderStyleValues.Thin
            shXL1.Cell("H" + row.ToString()).Style.Border.RightBorder = XLBorderStyleValues.Thin

            shXL1.Cell("I" + row.ToString()).Style.Border.BottomBorder = XLBorderStyleValues.Thin
            shXL1.Cell("I" + row.ToString()).Style.Border.TopBorder = XLBorderStyleValues.Thin
            shXL1.Cell("I" + row.ToString()).Style.Border.LeftBorder = XLBorderStyleValues.Thin
            shXL1.Cell("I" + row.ToString()).Style.Border.RightBorder = XLBorderStyleValues.Thin


            shXL1.Cell("J" + row.ToString()).Style.Border.BottomBorder = XLBorderStyleValues.Thin
            shXL1.Cell("J" + row.ToString()).Style.Border.TopBorder = XLBorderStyleValues.Thin
            shXL1.Cell("J" + row.ToString()).Style.Border.LeftBorder = XLBorderStyleValues.Thin
            shXL1.Cell("J" + row.ToString()).Style.Border.RightBorder = XLBorderStyleValues.Thin
            shXL1.Column("B").AdjustToContents()
            shXL1.Column("C").AdjustToContents()
            shXL1.Column("D").AdjustToContents()
            shXL1.Column("E").AdjustToContents()
            shXL1.Column("F").AdjustToContents()
            shXL1.Column("G").AdjustToContents()
            shXL1.Column("H").AdjustToContents()
            shXL1.Column("I").AdjustToContents()
            shXL1.Column("J").AdjustToContents()


            Response.Clear()
            Response.Buffer = True
            Response.Charset = ""
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
            Response.AddHeader("content-disposition", "attachment;filename=فاتوره" + DropDownList1.SelectedItem.ToString + "'.xlsx")
            Using MyMemoryStream As New MemoryStream()
                wbXl1.SaveAs(MyMemoryStream)
                MyMemoryStream.WriteTo(Response.OutputStream)
                Response.Flush()
                Response.End()
            End Using

        End If
    End Sub
    Protected Sub Button1_Click(sender As Object, e As EventArgs)
        Response.ClearContent()
        Using wb As New XLWorkbook()
            wb.Worksheets.Add(dt2, "المسارات" + DropDownList1.SelectedItem.ToString)

            Response.Clear()
            Response.Buffer = True
            Response.Charset = ""
            Response.ContentType = "application/vnd.ms-excel"
            Response.AddHeader("content-disposition", "attachment;filename=المسارات" + DropDownList1.SelectedItem.ToString + "'.xlsx")
            Using MyMemoryStream As New MemoryStream()
                wb.SaveAs(MyMemoryStream)
                MyMemoryStream.WriteTo(Response.OutputStream)
                Response.Flush()
                Response.End()
            End Using
        End Using
    End Sub

    Public Overrides Sub VerifyRenderingInServerForm(control As Control)
        ' Verifies that the control is rendered
    End Sub







    Protected Sub GridView1_DataBinding(sender As Object, e As EventArgs)

    End Sub

    Protected Sub GridView1_DataBound(sender As Object, e As EventArgs)

    End Sub

    Protected Sub GridView1_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        e.Row.Cells(3).Text = String.Empty
        e.Row.Cells(4).Text = String.Empty
        e.Row.Cells(3).Visible = False
        e.Row.Cells(4).Visible = False
        e.Row.Cells(17).Visible = False
    End Sub

    Protected Sub GridView2_RowDataBound(sender As Object, e As GridViewRowEventArgs)

        e.Row.Cells(11).Visible = False

    End Sub

    Protected Sub DropDownList2_DataBound(sender As Object, e As EventArgs)
        Dim newListItem As ListItem
        newListItem = New ListItem("--أختر شركه --", -1)
        newListItem.Selected = True
        DropDownList2.Items.Insert(0, newListItem)
    End Sub

    Protected Sub DropDownList3_DataBound(sender As Object, e As EventArgs)
        Dim newListItem As ListItem
        newListItem = New ListItem("--أختر منطقه --", -1)
        newListItem.Selected = True
        DropDownList3.Items.Insert(0, newListItem)
    End Sub

    Protected Sub DropDownList2_SelectedIndexChanged(sender As Object, e As EventArgs)
        If DropDownList2.SelectedValue <> "-1" Then
            placepanel.Visible = True
        End If
    End Sub
</script>



<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      
    <style>
        table tr td {
            padding-bottom: 5px;
            padding-left: 50px;
        }

        .total tr:last-child {
            border-top-width: medium;
            border-top-color: black;
            border-top-style: solid;
        }

        .total {
            border: 1px solid black;
        }
    </style>
<html xmlns="http://www.w3.org/1999/xhtml">
    


   <asp:Literal ID="Literal1" runat="server"></asp:Literal>
  <script>
      $(document).ready(function () {
          $(".close").click(function () {
              $("#myAlert").alert("close");
          });
      });
</script>
 
  <center>
    <table><tr style="float:right;text-align:right;"><td >
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="year" DataValueField="year" OnDataBound="DropDownList1_DataBound" Width="200px"></asp:DropDownList>
        
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="select DISTINCT  substring(from_date,0,8) as year from Route order by year"></asp:SqlDataSource>
        </td><td>أختر تاريخ</td></tr></table>
      <br /><br />
      <asp:Panel runat="server" Visible="false" ID="MonthPanel">
      <table><tr style="float:right;text-align:right;"><td >
        <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="Name_From" DataValueField="Name_From" OnDataBound="DropDownList2_DataBound" Width="200px" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged"></asp:DropDownList>
        
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="select DISTINCT Name_From from Income where substring(date,0,8)=@Date">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="Date" PropertyName="SelectedValue" />
            </SelectParameters>
          </asp:SqlDataSource>
        </td><td>أختر شركه</td></tr></table></asp:Panel>
      <br /><br />
      <asp:Panel runat="server" ID="placepanel" Visible="false">
               <table><tr style="float:right;text-align:right;"><td >
        <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="SqlDataSource3" DataTextField="f_rom" DataValueField="f_rom" OnDataBound="DropDownList3_DataBound" Width="200px"></asp:DropDownList>
        
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="Select DISTINCT f_rom from Income where substring(Date,0,8) =@date and Name_From=@Name">
          
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="Date" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="DropDownList2" Name="Name" PropertyName="SelectedValue" />
            </SelectParameters>
          
          </asp:SqlDataSource>
        </td><td>أختر المنطقه</td></tr>
          <tr><td>
            
                                        <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" class="btn btn-info"  Text="Export To Excel" />
            
                                        </td></tr></table></asp:Panel>
  </center>
        
    <asp:Panel ID="Panel1" runat="server" Visible="false">
    <div style="float:left;" id="DDD">
        <table id="TABLE1" class="total">
            <tr>
                  <td>ريال سعودي
                     </td><td> <asp:Label ID="Label1" runat="server" Text="" Visible="false"></asp:Label>
                  </td>
                <td>الدخل</td>
              
            </tr>
             <tr>
                  <td>ريال سعودي
                      </td><td> <asp:Label ID="Label2" runat="server" Text="" Visible="false"></asp:Label>
                  </td>
                <td>:العمولات</td>
              
            </tr>
             <tr>
                  <td>ريال سعودي
                    </td><td>   <asp:Label ID="Label3" runat="server" Text="" Visible="false"></asp:Label>
                  </td>
                <td> :تكاليف الوقود</td></tr>
               <tr>
                  <td>ريال سعودي
                    </td><td>   <asp:Label ID="Label7" runat="server" Text="" Visible="TRUE"></asp:Label>
                  </td>
                <td> :المصاريف</td>

            </tr>
            <tr>
                  <td> كم </td>
                      <td> <asp:Label ID="Label6" runat="server" Text="" Visible="true"></asp:Label>
                  </td>
                <td> :المسافه</td>
              </tr>
                  <tr>
                      <td> كم </td>
                      <td><asp:Label ID="Label11" runat="server" Text="" Visible="true"></asp:Label>
                  </td>
                <td> :إجمالي الكيلومترات السابق</td>
              </tr>
                  <tr>    <td> كم </td>
                  
                      <td>  <asp:Label ID="Label12" runat="server" Text="" Visible="true"></asp:Label>
                  </td>
                <td> :إجمالي الكيلومترات الحالي </td>
              </tr>
         
         <tr>    <td> كم </td>
                  
                      <td>  <asp:Label ID="Label13" runat="server" Text="" Visible="true"></asp:Label>
                  </td>
                <td> :الفرق </td>
              </tr>
         
            <tr>
                  <td>حموله
                      </td><td> <asp:Label ID="Label5" runat="server" Text="" Visible="true"></asp:Label>
                  </td>
                <td> :عدد الحمولات</td>
              
            </tr>
           
         
           <tr>
            <td >ريال سعودي
                </td><td> <asp:Label ID="Label4" runat="server" Text="" Visible="false"></asp:Label>
            </td>
            <td>:الأجمالي</td>
            </tr>

        </table>
    </div>
        <br /><br />
        <br /><br /> 
        <br /><br />
        <br /><br />
        <br /><br />
        <br /><br /> <br /><br />
        <br /><br /> 
        <br /><br />
        <br /><br />
        <br /><br />
        <br /><br />


        <div style="text-align:right;float:right;">
            <table><tr><td>
                <asp:Label ID="Label8" runat="server" ><h2>الدخل</h2></asp:Label></td></tr><tr><td>
                <asp:GridView ID="GridView1" runat="server" OnRowDataBound="GridView1_RowDataBound" class="table table-striped" Width="100%" style="width:100%;">
                   
                    <Columns>
                        <asp:HyperLinkField HeaderText="" Text="تعديل" DataNavigateUrlFields="ID" DataNavigateUrlFormatString="IncomeEdit.aspx?ID={0}"/>
                       
                       
                       
                      
                       
                       
                       
                      <asp:TemplateField HeaderText="الفاتوره">
                    <ItemTemplate>
                        <asp:HyperLink ID="HyperLink1" runat="server" Text='<%# Eval("InvoiceText")%>' NavigateUrl='<%# Eval("Invoice")%>'></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                       
                       
                      
                       
                       
                       
                    </Columns>
                   
                </asp:GridView> <asp:Button runat="server" ID="bt1" OnClick="bt1_Click"  class="btn btn-info"  Text="Export To Excel"/>
            </td></tr></table> </div>
               <div style="text-align:right;float:right;">
              
            <table><tr><td>
                <asp:Label ID="Label9" runat="server" ><h2>المسارات</h2></asp:Label></td></tr><tr><td>
                
                <asp:GridView ID="GridView2" runat="server" class="table table-striped" Width="100%"  OnRowDataBound="GridView2_RowDataBound">
                     <Columns>
                        <asp:HyperLinkField HeaderText="" Text="تعديل" DataNavigateUrlFields="ID" DataNavigateUrlFormatString="RouteEdit.aspx?ID={0}"/>
                    </Columns>
                   
                </asp:GridView><asp:Button runat="server" ID="Button1"  class="btn btn-info" Text="Export To Excel" OnClick="Button1_Click"/>
            </td></tr></table>
        </div><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />        <br /><br />
        <br /><br />
        <br /><br /><br />
         <div style="text-align:right;float:right;;">
 <table><tr><td>
     <asp:Label ID="Label10" runat="server" ><h2>المصاريف</h2></asp:Label></td></tr><tr><td>
                <asp:GridView ID="GridView3" runat="server"  class="table table-striped" Width="100%" OnRowDataBound="GridView3_RowDataBound">
                     <Columns>
                        <asp:HyperLinkField HeaderText="تعديل" Text="تعديل" DataNavigateUrlFields="ID" DataNavigateUrlFormatString="ExpensesEdit.aspx?ID={0}"/>
                      <asp:TemplateField HeaderText="فاتوره">
                    <ItemTemplate>
                        <asp:HyperLink ID="HyperLink2" runat="server" Text='<%# Eval("InvoiceText")%>' NavigateUrl='<%# Eval("Invoice")%>'></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                       
                       
                          </Columns>
                   
                </asp:GridView><asp:Button runat="server" ID="Button2" class="btn btn-info"  Text="Export To Excel" OnClick="Button2_Click"/>
            </td></tr></table>



         
            </div>

    </asp:Panel>
    </html>
</asp:Content>
      






















