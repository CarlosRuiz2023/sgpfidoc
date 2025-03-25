Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports System.Web.Script.Services
Imports System.Web.Services


' Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente.
<System.Web.Script.Services.ScriptService()> _
<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class WebServiceFact
    Inherits System.Web.Services.WebService

    Public Conn As SqlConnection = New SqlConnection("Data Source=192.168.1.4;Initial Catalog=fidoc;user id=usrfidoc;password=pwdfidoc;")

    <WebMethod(Description:="Retorna las factibilidades con el documento asignado")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetFactibilidad(idsol As Integer, idfact As Integer) As String
        Dim query As String = "select * from mFactibilidad as a inner join mdcto as b on a.midsol = b.midsol and a.mnumfact = b.midref where a.mnumfact = " & idfact & " and mEstatusFact <> 4"
        Dim custDA As SqlDataAdapter = New SqlDataAdapter(query, Conn)
        Dim custDS As DataSet = New DataSet()
        custDA.MissingSchemaAction = MissingSchemaAction.AddWithKey
        custDA.Fill(custDS, "Factibilidad")
        Try
            Dim sb = New StringBuilder()
            Using writer = New StringWriter(sb)
                custDS.WriteXml(writer)
                Dim xml As String = sb.ToString()
                Return xml
            End Using
        Catch ex As Exception
            Return "Error " & ex.Message
        End Try
    End Function


    <WebMethod(Description:="Recaba todas las factibilidades activas")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetFactibilidades(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, idsol As Integer) As JQGridJsonResponseFact

        Return GetFactibilidadesJSon(pPageSize, pCurrentPage, pSortColumn, pSortOrder, idsol)

    End Function

    Private Function GetFactibilidadesJSon(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, idsol As Integer) As JQGridJsonResponseFact
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf25").ConnectionString
        Dim dt As DataSet = New DataSet()

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("SP_FactGrid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@Idsol", idsol)
                cmd.Parameters.AddWithValue("@NoError", 1)
                cmd.Parameters.AddWithValue("@DescError", "ERROR")
                Dim adapt As SqlDataAdapter = New SqlDataAdapter(cmd)

                adapt.Fill(dt)
                Dim factis = New List(Of clsFactibilidad)
                If Convert.ToInt32(dt.Tables(0).Rows(0)("RecordCount")) > 0 Then
                    For Each row As DataRow In dt.Tables(1).Rows
                        Dim facti As clsFactibilidad = New clsFactibilidad()
                        facti.IdSol = Convert.ToInt32(row.Item("idsol"))
                        facti.NumFact = Convert.ToInt32(row.Item("mNumFact"))
                        facti.opc1 = row.Item("mopc1")
                        facti.opc2 = row.Item("mopc2")
                        facti.opc3 = row.Item("mopc3")
                        facti.opc4 = row.Item("mopc4")
                        facti.opc5 = row.Item("mopc5")
                        facti.opc6 = row.Item("mopc6")
                        facti.opc7 = row.Item("mopc7")
                        facti.opc8 = row.Item("mopc8")
                        facti.opc9 = row.Item("mopc9")
                        facti.opc10 = row.Item("mopc10")
                        facti.NomUsuFact = row.Item("mUsuNombre")
                        facti.UsuCre = row.Item("mUsuCre")
                        facti.FecCre = row.Item("mFecCre")
                        facti.UsuMod = row.Item("mUsuModif")
                        facti.FecMod = row.Item("mFecModif")
                        facti.EstatusFact = row.Item("cEstDescripcion")
                        facti.observtec = row.Item("mobserv_tec")
                        facti.observgral = row.Item("mobserv_gral")
                        facti.FolioDcto = row.Item("mfolio")
                        facti.docdig = row.Item("mNomArchivo")
                        'facti.SapalId = row.Item("mSapalId")
                        'facti.FileSapalSol = row.Item("mSapalNOficio")
                        'facti.FileSapalResp = row.Item("mSapalArchivo")
                        'facti.DUId = row.Item("mDUId")
                        'facti.FileDUSol = row.Item("mDUNOficio")
                        'facti.FileDUResp = row.Item("mDUArchivo")
                        factis.Add(facti)
                    Next row


                End If

                Dim objeto As JQGridJsonResponseFact = New JQGridJsonResponseFact
                objeto.JQGridJsonResponseFact(Convert.ToInt32(dt.Tables(0).Rows(0)("PageCount")), Convert.ToInt32(dt.Tables(0).Rows(0)("CurrentPage")), Convert.ToInt32(dt.Tables(0).Rows(0)("RecordCount")), factis)
                Return objeto

            End Using
        End Using
    End Function


    <WebMethod(Description:="Retorna valores del catálogo del estatus de factibilidad")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetEstFact() As String
        Dim query As String = "select cEstId,cEstDescripcion from cEstAutoriza"
        Dim custDA As SqlDataAdapter = New SqlDataAdapter(query, Conn)
        Dim custDS As DataSet = New DataSet()
        custDA.MissingSchemaAction = MissingSchemaAction.AddWithKey
        custDA.Fill(custDS, "EstatusFact")
        Try
            Dim sb = New StringBuilder()
            Using writer = New StringWriter(sb)
                custDS.WriteXml(writer)
                Dim xml As String = sb.ToString()
                Return xml
            End Using
        Catch ex As Exception
            Return "Error " & ex.Message
        End Try
    End Function


    <WebMethod(Description:="Actualizar el registro de la factibilidad")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function ActFactibilidad(objFact As clsFactibilidad) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf25").ConnectionString
        Dim idfact As Integer = 0
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("SP_Factib", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idsol", objFact.IdSol)
                cmd.Parameters.AddWithValue("@idfact", objFact.idFact)
                cmd.Parameters.AddWithValue("@UsuFact", objFact.UsuFact)
                cmd.Parameters.AddWithValue("@opc1", objFact.opc1)
                cmd.Parameters.AddWithValue("@opc2", objFact.opc2)
                cmd.Parameters.AddWithValue("@opc3", objFact.opc3)
                cmd.Parameters.AddWithValue("@opc4", objFact.opc4)
                cmd.Parameters.AddWithValue("@opc5", objFact.opc5)
                cmd.Parameters.AddWithValue("@opc6", objFact.opc6)
                cmd.Parameters.AddWithValue("@opc7", objFact.opc7)
                cmd.Parameters.AddWithValue("@opc8", objFact.opc8)
                cmd.Parameters.AddWithValue("@opc9", objFact.opc9)
                cmd.Parameters.AddWithValue("@opc10", objFact.opc10)
                cmd.Parameters.AddWithValue("@opc11", objFact.opc11)
                cmd.Parameters.AddWithValue("@opc12", objFact.opc12)
                cmd.Parameters.AddWithValue("@factfile", objFact.docdig)
                cmd.Parameters.AddWithValue("@estatusfact", objFact.EstatusFact)
                cmd.Parameters.AddWithValue("@UsuCre", objFact.UsuCre)
                cmd.Parameters.AddWithValue("@FecCre", objFact.FecCre)
                cmd.Parameters.AddWithValue("@UsuMod", objFact.UsuMod)
                cmd.Parameters.AddWithValue("@FecMod", objFact.FecMod)
                cmd.Parameters.AddWithValue("@observtec", objFact.observtec)
                cmd.Parameters.AddWithValue("@observgral", objFact.observgral)
                cmd.Parameters.AddWithValue("@accion", objFact.Accion)
                Dim parIdError As SqlParameter = New SqlParameter("@NoError", SqlDbType.Int) ' .Value = 0
                parIdError.Direction = ParameterDirection.Output

                Dim parDesError As SqlParameter = New SqlParameter("@DescError", SqlDbType.VarChar, 1000) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output

                Dim paridfact As SqlParameter = New SqlParameter("@idfactR", SqlDbType.Int) ' .Value = 0
                paridfact.Direction = ParameterDirection.Output

                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)
                cmd.Parameters.Add(paridfact)

                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                idfact = cmd.Parameters("@idfactR").Value()
                numerror = cmd.Parameters("@NoError").Value()
                messerror = cmd.Parameters("@DescError").Value()
                con.Close()
            End Using
        End Using
        Try
            Return "Accion ejecutada correctamente:" & idfact.ToString
        Catch ex As SqlException
            Return ex.Message & "No.Error:" & numerror.ToString() & "Mensaje error:" & messerror
        End Try
    End Function

    Private Function ValidarDBNull(objParametro As Object) As Object
        If IsDBNull(objParametro.ToString) Then
            ValidarDBNull = ""
        Else
            If objParametro.ToString = "" Then
                ValidarDBNull = 0
            Else
                ValidarDBNull = objParametro.ToString
            End If
        End If
    End Function

End Class