Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports System.Web.Script.Services
Imports System.Web.Services
Imports Npgsql

' Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente.
<System.Web.Script.Services.ScriptService()> _
<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class WebServiceSolic
    Inherits System.Web.Services.WebService

    Public Conn As SqlConnection = New SqlConnection("Data Source=192.168.1.4;Initial Catalog=fidoc;user id=usrfidoc;password=pwdfidoc;")
    Public con_psql As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString

    <WebMethod(Description:="Retorna sector,subsector,nombre_actual,nombre_ant de las colonias de DU")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetSolicitud(idsol As Integer) As String
        Dim query As String = "select * from mSolicitudes where msolid=" & idsol & " and cEstatusSolicitud <> 8"
        Dim custDA As SqlDataAdapter = New SqlDataAdapter(query, Conn)
        Dim custDS As DataSet = New DataSet()
        custDA.MissingSchemaAction = MissingSchemaAction.AddWithKey
        custDA.Fill(custDS, "Solicitud")
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


    <WebMethod(Description:="Retorna sector,subsector,nombre_actual,nombre_ant de las colonias de DU")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetSolicitud_psql(idsol As Integer) As String
        Dim query As String = "select * from mSolicitudes where msolid=" & idsol & " and cEstatusSolicitud <> 8"
        Dim custDA As NpgsqlDataAdapter = New NpgsqlDataAdapter(query, con_psql)

        Dim custDS As DataSet = New DataSet()
        custDA.MissingSchemaAction = MissingSchemaAction.AddWithKey
        custDA.Fill(custDS, "Solicitud")
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

    <WebMethod(Description:="Retorna todos los valores que se encuentran en el catálogo de origen de solicitud")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetOrigenSolicitud() As String
        Dim query As String = "select cOrigId,cOrigNombre  from dbo.cOrigen where cActivo = 1"
        Dim custDA As SqlDataAdapter = New SqlDataAdapter(query, Conn)
        Dim custDS As DataSet = New DataSet()
        custDA.MissingSchemaAction = MissingSchemaAction.AddWithKey
        custDA.Fill(custDS, "OrigSolicitud")
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

    <WebMethod(Description:="Retorna todos los valores que se encuentran en el catálogo de origen de solicitud")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetOrigenSolicitud_psql() As String
        Dim query As String = "select cOrigId,cOrigNombre  from dbo.cOrigen where cActivo = 1"
        Dim custDA As NpgsqlDataAdapter = New NpgsqlDataAdapter(query, con_psql)
        Dim custDS As DataSet = New DataSet()
        custDA.MissingSchemaAction = MissingSchemaAction.AddWithKey
        custDA.Fill(custDS, "OrigSolicitud")
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

    <WebMethod(Description:="Retorna todos los valores que se encuentran en el catálogo de origen de solicitud")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function ConsultaSolicitudes(estatussol As String) As String
        Dim query As String = "select msolid,msolCalle,msolColonia,msolTramo,ubic from msolicitudes where cEstatusSolicitud in (" & estatussol & ") order by msolcalle"
        Dim custDA As SqlDataAdapter = New SqlDataAdapter(query, Conn)
        Dim custDS As DataSet = New DataSet()
        custDA.MissingSchemaAction = MissingSchemaAction.AddWithKey
        custDA.Fill(custDS, "rSolicitud")
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

    <WebMethod(Description:="Retorna todos los valores que se encuentran en el catálogo de origen de solicitud")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function ConsultaSolicitudes_psql(estatussol As String) As String
        Dim query As String = "select msolid,msolCalle,msolColonia,msolTramo,ubic from msolicitudes as a left join (select gid,count(*) from frentes  where gid is not null group by gid)  as b  on  a.ubic=b.gid where b.gid Is null And cestatussolicitud in (" & estatussol & ")  order by msolcalle"
        Dim custDA As NpgsqlDataAdapter = New NpgsqlDataAdapter(query, con_psql)
        Dim custDS As DataSet = New DataSet()
        custDA.MissingSchemaAction = MissingSchemaAction.AddWithKey
        custDA.Fill(custDS, "rSolicitud")
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

    <WebMethod(Description:="Retorna todos los valores que se encuentran en el catálogo de origen de solicitud")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function RevisaAnuencias(idsol As Integer) As String
        Dim query As String = "select a.mSolId as idsol,b.mAnuId as idanu,b.mAnuEstatus as idAnuEst,c.cEstDesc as AnuEstDesc from mSolicitudes as a inner join mAnuencia as b on  a.mSolId = b.mSolId inner join cEstAnuencia as c on b.mAnuEstatus = c.cEstId where a.mSolId =" & idsol & "and b.mAnuEstatus in (1,2,3,6)"

        Dim custDA As SqlDataAdapter = New SqlDataAdapter(query, Conn)
        Dim custDS As DataSet = New DataSet()
        custDA.MissingSchemaAction = MissingSchemaAction.AddWithKey
        custDA.Fill(custDS, "rAnuencia")
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

    <WebMethod(Description:="Retorna todos los valores que se encuentran en el catálogo de origen de solicitud")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function RevisaAnuencias_psql(idsol As Integer) As String
        Dim query As String = "select a.mSolId as idsol,b.mAnuId as idanu,b.mAnuEstatus as idAnuEst,c.cEstDesc as AnuEstDesc from mSolicitudes as a inner join mAnuencia as b on  a.mSolId = b.mSolId inner join cEstAnuencia as c on b.mAnuEstatus = c.cEstId where a.mSolId =" & idsol & "and b.mAnuEstatus in (1,2,3,6)"

        Dim custDA As NpgsqlDataAdapter = New NpgsqlDataAdapter(query, con_psql)
        Dim custDS As DataSet = New DataSet()
        custDA.MissingSchemaAction = MissingSchemaAction.AddWithKey
        custDA.Fill(custDS, "rAnuencia")
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

    <WebMethod(Description:="Actualizar el registro de la solicitud")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function OperaSolicitud(objSol As clsSolicitud) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf25").ConnectionString
        Dim idAnu As Integer = 0
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("SP_Solicitud", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idsol", objSol.IdSol)
                cmd.Parameters.AddWithValue("@idstatus", objSol.IdEstatus)
                cmd.Parameters.AddWithValue("@fecha", objSol.Fecha)
                cmd.Parameters.AddWithValue("@nombre", objSol.Nombre)
                cmd.Parameters.AddWithValue("@direccion", objSol.Direccion)
                cmd.Parameters.AddWithValue("@telefono", objSol.Telefono)
                cmd.Parameters.AddWithValue("@correo", objSol.Correo)
                cmd.Parameters.AddWithValue("@tramo", objSol.Tramo)
                cmd.Parameters.AddWithValue("@observa", objSol.Observaciones)
                cmd.Parameters.AddWithValue("@secfno", objSol.SECFNO)
                cmd.Parameters.AddWithValue("@sscfno", objSol.SSCFNO)
                cmd.Parameters.AddWithValue("@clacno", objSol.CLACNO)
                cmd.Parameters.AddWithValue("@usucre", objSol.UsuCre)
                cmd.Parameters.AddWithValue("@feccre", objSol.FecCre)
                cmd.Parameters.AddWithValue("@usumod", objSol.UsuMod)
                cmd.Parameters.AddWithValue("@fecmod", objSol.FecMod)
                cmd.Parameters.AddWithValue("@idorigen", objSol.IdOrigen)
                cmd.Parameters.AddWithValue("@tramod", objSol.Tramo)
                cmd.Parameters.AddWithValue("@autorizar", objSol.Autorizar)
                cmd.Parameters.AddWithValue("@calle", objSol.Calle)
                cmd.Parameters.AddWithValue("@col", objSol.Col)
                cmd.Parameters.AddWithValue("@ubic", objSol.ubic)
                cmd.Parameters.AddWithValue("@accion", objSol.Accion)
                Dim parIdError As SqlParameter = New SqlParameter("@NoError", SqlDbType.Int) ' .Value = 0
                parIdError.Direction = ParameterDirection.Output

                Dim parDesError As SqlParameter = New SqlParameter("@DescError", SqlDbType.VarChar, 1000) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output

                Dim paridfact As SqlParameter = New SqlParameter("@idanuR", SqlDbType.Int) ' .Value = 0
                paridfact.Direction = ParameterDirection.Output

                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)
                cmd.Parameters.Add(paridfact)

                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                idAnu = cmd.Parameters("@idanuR").Value()
                numerror = cmd.Parameters("@NoError").Value()
                messerror = cmd.Parameters("@DescError").Value()
                con.Close()
            End Using
        End Using
        Try
            Return "Accion ejecutada correctamente:" & idAnu.ToString
        Catch ex As SqlException
            Return ex.Message & "No.Error:" & numerror.ToString() & "Mensaje error:" & messerror
        End Try
    End Function

    <WebMethod(Description:="Actualizar el registro de la solicitud")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function OperaSolicitud_psql(objSol As clsSolicitud) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim idAnu As Integer = 0
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("SP_Solicitud", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idsol", objSol.IdSol)
                cmd.Parameters.AddWithValue("@idstatus", objSol.IdEstatus)
                cmd.Parameters.AddWithValue("@fecha", objSol.Fecha)
                cmd.Parameters.AddWithValue("@nombre", objSol.Nombre)
                cmd.Parameters.AddWithValue("@direccion", objSol.Direccion)
                cmd.Parameters.AddWithValue("@telefono", objSol.Telefono)
                cmd.Parameters.AddWithValue("@correo", objSol.Correo)
                cmd.Parameters.AddWithValue("@tramo", objSol.Tramo)
                cmd.Parameters.AddWithValue("@observa", objSol.Observaciones)
                cmd.Parameters.AddWithValue("@secfno", objSol.SECFNO)
                cmd.Parameters.AddWithValue("@sscfno", objSol.SSCFNO)
                cmd.Parameters.AddWithValue("@clacno", objSol.CLACNO)
                cmd.Parameters.AddWithValue("@usucre", objSol.UsuCre)
                cmd.Parameters.AddWithValue("@feccre", objSol.FecCre)
                cmd.Parameters.AddWithValue("@usumod", objSol.UsuMod)
                cmd.Parameters.AddWithValue("@fecmod", objSol.FecMod)
                cmd.Parameters.AddWithValue("@idorigen", objSol.IdOrigen)
                cmd.Parameters.AddWithValue("@tramod", objSol.Tramo)
                cmd.Parameters.AddWithValue("@autorizar", objSol.Autorizar)
                cmd.Parameters.AddWithValue("@calle", objSol.Calle)
                cmd.Parameters.AddWithValue("@col", objSol.Col)
                cmd.Parameters.AddWithValue("@ubic", objSol.ubic)
                cmd.Parameters.AddWithValue("@accion", objSol.Accion)
                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@NoError", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                parIdError.Direction = ParameterDirection.Output

                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@DescError", NpgsqlTypes.NpgsqlDbType.Varchar, 1000) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output

                Dim paridfact As NpgsqlParameter = New NpgsqlParameter("@idanuR", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                paridfact.Direction = ParameterDirection.Output

                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)
                cmd.Parameters.Add(paridfact)

                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                idAnu = cmd.Parameters("@idanuR").Value()
                numerror = cmd.Parameters("@NoError").Value()
                messerror = cmd.Parameters("@DescError").Value()
                con.Close()
            End Using
        End Using
        Try
            Return "Accion ejecutada correctamente:" & idAnu.ToString
        Catch ex As SqlException
            Return ex.Message & "No.Error:" & numerror.ToString() & "Mensaje error:" & messerror
        End Try
    End Function

    <WebMethod(Description:="Actualiza el registro filtrado por un numero de solicitud")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function ActSolicitud(objSol As clsSolicitudes) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf25").ConnectionString
        Dim strConsulta As String
        If (objSol.Accion = 1) Then
            strConsulta = "UPDATE msolicitudes SET mSolNombre=@nombre,mSolDireccion=@direccion,mSolTel=@telefono,mSolCorreo=@correo,mSolTramo=@tramo,mSolObserva=@observa,mSolSECFNO=@secfno,mSolSSCFNO=@sscfno,mSolCLACNO=@clacno,UsrMod=@usumod,FecMod=@fecmod,cOrigId=@idorigen,mSolTramoO=@tramod,mSolCalle=@calle,mSolColonia=@col,ubic=@ubic WHERE msolid = @idsol"
        Else
            If (objSol.Accion < 0) Then
                strConsulta = "UPDATE msolicitudes SET cEstatusSolicitud=8 WHERE msolid = @idsol"
            Else
                strConsulta = "insert into msolicitudes (cEstatusSolicitud,mSolFecha,mSolNombre,mSolDireccion,mSolTel,mSolCorreo,mSolTramo,mSolObserva,mSolSECFNO,mSolSSCFNO,mSolCLACNO,UsrCre,FecCre,UsrMod,FecMod,cOrigId,mSolTramoO,mSolAutoriza,mSolCalle,mSolColonia,ubic) values (@idstatus,@fecha,@nombre,@direccion,@telefono,@correo,@tramo,@observa,@secfno,@sscfno,@clacno,@usucre,@feccre,@usumod,@fecmod,@idorigen,@tramod,@autorizar,@calle,@col,@ubic)"
            End If
        End If

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand(strConsulta)
                cmd.CommandType = CommandType.Text
                cmd.Parameters.AddWithValue("@idsol", objSol.IdSol)
                cmd.Parameters.AddWithValue("@idstatus", objSol.IdEstatus)
                cmd.Parameters.AddWithValue("@fecha", objSol.Fecha)
                cmd.Parameters.AddWithValue("@nombre", objSol.Nombre)
                cmd.Parameters.AddWithValue("@direccion", objSol.Direccion)
                cmd.Parameters.AddWithValue("@telefono", objSol.Telefono)
                cmd.Parameters.AddWithValue("@correo", objSol.Correo)
                cmd.Parameters.AddWithValue("@tramo", objSol.Tramo)
                cmd.Parameters.AddWithValue("@observa", objSol.Observaciones)
                cmd.Parameters.AddWithValue("@secfno", objSol.SECFNO)
                cmd.Parameters.AddWithValue("@sscfno", objSol.SSCFNO)
                cmd.Parameters.AddWithValue("@clacno", objSol.CLACNO)
                cmd.Parameters.AddWithValue("@usucre", objSol.UsuCre)
                cmd.Parameters.AddWithValue("@feccre", objSol.FecCre)
                cmd.Parameters.AddWithValue("@usumod", objSol.UsuMod)
                cmd.Parameters.AddWithValue("@fecmod", objSol.FecMod)
                cmd.Parameters.AddWithValue("@idorigen", objSol.IdOrigen)
                cmd.Parameters.AddWithValue("@tramod", objSol.Tramo)
                cmd.Parameters.AddWithValue("@autorizar", objSol.Autorizar)
                cmd.Parameters.AddWithValue("@calle", objSol.Calle)
                cmd.Parameters.AddWithValue("@col", objSol.Col)
                cmd.Parameters.AddWithValue("@ubic", objSol.ubic)
                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()
                con.Close()
            End Using
        End Using
        Try
            Return "Acción ejecutada correctamente "
        Catch ex As Exception
            Return "Error " & ex.Message
        End Try
    End Function

    <WebMethod(Description:="Actualiza el registro filtrado por un numero de solicitud")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function ActSolicitud_psql(objSol As clsSolicitudes) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim strConsulta As String
        If (objSol.Accion = 1) Then
            strConsulta = "UPDATE msolicitudes SET mSolNombre=@nombre,mSolDireccion=@direccion,mSolTel=@telefono,mSolCorreo=@correo,mSolTramo=@tramo,mSolObserva=@observa,mSolSECFNO=@secfno,mSolSSCFNO=@sscfno,mSolCLACNO=@clacno,UsrMod=@usumod,FecMod=@fecmod,cOrigId=@idorigen,mSolTramoO=@tramod,mSolCalle=@calle,mSolColonia=@col,ubic=@ubic WHERE msolid = @idsol"
        Else
            If (objSol.Accion < 0) Then
                strConsulta = "UPDATE msolicitudes SET cEstatusSolicitud=8 WHERE msolid = @idsol"
            Else
                strConsulta = "insert into msolicitudes (cEstatusSolicitud,mSolFecha,mSolNombre,mSolDireccion,mSolTel,mSolCorreo,mSolTramo,mSolObserva,mSolSECFNO,mSolSSCFNO,mSolCLACNO,UsrCre,FecCre,UsrMod,FecMod,cOrigId,mSolTramoO,mSolAutoriza,mSolCalle,mSolColonia,ubic) values (@idstatus,@fecha,@nombre,@direccion,@telefono,@correo,@tramo,@observa,@secfno,@sscfno,@clacno,@usucre,@feccre,@usumod,@fecmod,@idorigen,@tramod,@autorizar,@calle,@col,@ubic)"
            End If
        End If

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand(strConsulta)
                cmd.CommandType = CommandType.Text
                cmd.Parameters.AddWithValue("@idsol", objSol.IdSol)
                cmd.Parameters.AddWithValue("@idstatus", objSol.IdEstatus)
                cmd.Parameters.AddWithValue("@fecha", objSol.Fecha)
                cmd.Parameters.AddWithValue("@nombre", objSol.Nombre)
                cmd.Parameters.AddWithValue("@direccion", objSol.Direccion)
                cmd.Parameters.AddWithValue("@telefono", objSol.Telefono)
                cmd.Parameters.AddWithValue("@correo", objSol.Correo)
                cmd.Parameters.AddWithValue("@tramo", objSol.Tramo)
                cmd.Parameters.AddWithValue("@observa", objSol.Observaciones)
                cmd.Parameters.AddWithValue("@secfno", objSol.SECFNO)
                cmd.Parameters.AddWithValue("@sscfno", objSol.SSCFNO)
                cmd.Parameters.AddWithValue("@clacno", objSol.CLACNO)
                cmd.Parameters.AddWithValue("@usucre", objSol.UsuCre)
                cmd.Parameters.AddWithValue("@feccre", objSol.FecCre)
                cmd.Parameters.AddWithValue("@usumod", objSol.UsuMod)
                cmd.Parameters.AddWithValue("@fecmod", objSol.FecMod)
                cmd.Parameters.AddWithValue("@idorigen", objSol.IdOrigen)
                cmd.Parameters.AddWithValue("@tramod", objSol.Tramo)
                cmd.Parameters.AddWithValue("@autorizar", objSol.Autorizar)
                cmd.Parameters.AddWithValue("@calle", objSol.Calle)
                cmd.Parameters.AddWithValue("@col", objSol.Col)
                cmd.Parameters.AddWithValue("@ubic", objSol.ubic)
                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()
                con.Close()
            End Using
        End Using
        Try
            Return "Acción ejecutada correctamente "
        Catch ex As Exception
            Return "Error " & ex.Message
        End Try
    End Function

    <WebMethod(Description:="Actualiza el estatus de la solucitud a 9 (ANTEPRESUPUESTO")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetPresupuestarSolicitud(idsol As Integer, usumod As String) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf25").ConnectionString
        Dim strConsulta As String

        strConsulta = "update mSolicitudes set cEstatusSolicitud = 9, UsrMod = @usumod, FecMod = DATE where mSolId = @idsol"

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand(strConsulta)
                cmd.CommandType = CommandType.Text
                cmd.Parameters.AddWithValue("@idsol", idsol)
                cmd.Parameters.AddWithValue("@usumod", usumod)
                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()
                con.Close()
            End Using
        End Using
        Try
            Return "ok"
        Catch ex As Exception
            Return "Error " & ex.Message
        End Try
    End Function


    <WebMethod(Description:="Actualiza el estatus de la solucitud a 9 (ANTEPRESUPUESTO")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetPresupuestarSolicitud_psql(idsol As Integer, usumod As String) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf25").ConnectionString
        Dim strConsulta As String

        strConsulta = "update mSolicitudes set cEstatusSolicitud = 9, UsrMod = @usumod, FecMod = DATE where mSolId = @idsol"

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand(strConsulta)
                cmd.CommandType = CommandType.Text
                cmd.Parameters.AddWithValue("@idsol", idsol)
                cmd.Parameters.AddWithValue("@usumod", usumod)
                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()
                con.Close()
            End Using
        End Using
        Try
            Return "ok"
        Catch ex As Exception
            Return "Error " & ex.Message
        End Try
    End Function

    <WebMethod(Description:="Recaba todas las solicitudes activas")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetSolicitudes(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, pFiltro As String, pEstatusSolicitud As String, pEstatusFactib As String, pEstatusAnuencia As String) As JQGridJsonResponse
        Return GetSolicitudesJSon(pPageSize, pCurrentPage, pSortColumn, pSortOrder, pFiltro, pEstatusSolicitud, pEstatusFactib, pEstatusAnuencia)

    End Function

    Private Function GetSolicitudesJSon(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, pFiltro As String, pEstatusSolicitud As String, pEstatusFactib As String, pEstatusAnuencia As String) As JQGridJsonResponse
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf25").ConnectionString
        Dim dt As DataSet = New DataSet()

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("SP_SolicitudesGrid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@Filtro", pFiltro)
                cmd.Parameters.AddWithValue("@EstatusSolicitud", pEstatusSolicitud)
                cmd.Parameters.AddWithValue("@EstatusFactib", pEstatusFactib)
                cmd.Parameters.AddWithValue("@EstatusAnuencia", pEstatusAnuencia)
                cmd.Parameters.AddWithValue("@NoError", 1)
                cmd.Parameters.AddWithValue("@DescError", "ERROR")
                Dim adapt As SqlDataAdapter = New SqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim solicitudes = New List(Of clsSolicitud)
                If Convert.ToInt32(dt.Tables(0).Rows(0)("RecordCount")) > 0 Then
                    For Each row As DataRow In dt.Tables(1).Rows
                        Dim solicitud As clsSolicitud = New clsSolicitud()
                        solicitud.IdSol = Convert.ToInt32(row.Item("idsol"))
                        solicitud.Fecha = row.Item("mSolFecha")
                        solicitud.Nombre = ValidarDBNull(row.Item("mSolNombre"))
                        'solicitud.IdEstatus = Convert.ToInt32(row.Item("cEstatusSolicitud"))
                        solicitud.UsuCre = ValidarDBNull(row.Item("UsuCre"))
                        solicitud.FecCre = ValidarDBNull(row.Item("FechaCre"))
                        solicitud.UsuMod = ValidarDBNull(row.Item("UsuModif"))
                        solicitud.FecMod = ValidarDBNull(row.Item("FechaMod"))
                        solicitud.Calle = ValidarDBNull(row.Item("mSolCalle"))
                        solicitud.Col = ValidarDBNull(row.Item("mSolColonia"))
                        solicitud.Tramo = ValidarDBNull(row.Item("mSolTramo"))
                        solicitud.ubic = ValidarDBNull(row.Item("ubic"))
                        solicitud.EstatusDescrip = ValidarDBNull(row.Item("estdesc"))
                        solicitudes.Add(solicitud)
                    Next row
                End If

                Dim objeto As JQGridJsonResponse = New JQGridJsonResponse
                objeto.JQGridJsonResponse(Convert.ToInt32(dt.Tables(0).Rows(0)("PageCount")), Convert.ToInt32(dt.Tables(0).Rows(0)("CurrentPage")), Convert.ToInt32(dt.Tables(0).Rows(0)("RecordCount")), solicitudes)
                Return objeto
            End Using
        End Using
    End Function

    <WebMethod(Description:="Recaba todas las solicitudes activas")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetSolicitudes_psql(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, pFiltro As String, pEstatusSolicitud As String, pEstatusFactib As String, pEstatusAnuencia As String) As JQGridJsonResponse
        Return GetSolicitudesJSon_psql(pPageSize, pCurrentPage, pSortColumn, pSortOrder, pFiltro, pEstatusSolicitud, pEstatusFactib, pEstatusAnuencia)

    End Function

    Private Function GetSolicitudesJSon_psql(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, pFiltro As String, pEstatusSolicitud As String, pEstatusFactib As String, pEstatusAnuencia As String) As JQGridJsonResponse
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("SP_SolicitudesGrid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@Filtro", pFiltro)
                cmd.Parameters.AddWithValue("@EstatusSolicitud", pEstatusSolicitud)
                cmd.Parameters.AddWithValue("@EstatusFactib", pEstatusFactib)
                cmd.Parameters.AddWithValue("@EstatusAnuencia", pEstatusAnuencia)
                cmd.Parameters.AddWithValue("@NoError", 1)
                cmd.Parameters.AddWithValue("@DescError", "ERROR")
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim solicitudes = New List(Of clsSolicitud)
                If Convert.ToInt32(dt.Tables(0).Rows(0)("RecordCount")) > 0 Then
                    For Each row As DataRow In dt.Tables(1).Rows
                        Dim solicitud As clsSolicitud = New clsSolicitud()
                        solicitud.IdSol = Convert.ToInt32(row.Item("idsol"))
                        solicitud.Fecha = row.Item("mSolFecha")
                        solicitud.Nombre = ValidarDBNull(row.Item("mSolNombre"))
                        'solicitud.IdEstatus = Convert.ToInt32(row.Item("cEstatusSolicitud"))
                        solicitud.UsuCre = ValidarDBNull(row.Item("UsuCre"))
                        solicitud.FecCre = ValidarDBNull(row.Item("FechaCre"))
                        solicitud.UsuMod = ValidarDBNull(row.Item("UsuModif"))
                        solicitud.FecMod = ValidarDBNull(row.Item("FechaMod"))
                        solicitud.Calle = ValidarDBNull(row.Item("mSolCalle"))
                        solicitud.Col = ValidarDBNull(row.Item("mSolColonia"))
                        solicitud.Tramo = ValidarDBNull(row.Item("mSolTramo"))
                        solicitud.ubic = ValidarDBNull(row.Item("ubic"))
                        solicitud.EstatusDescrip = ValidarDBNull(row.Item("estdesc"))
                        solicitudes.Add(solicitud)
                    Next row
                End If

                Dim objeto As JQGridJsonResponse = New JQGridJsonResponse
                objeto.JQGridJsonResponse(Convert.ToInt32(dt.Tables(0).Rows(0)("PageCount")), Convert.ToInt32(dt.Tables(0).Rows(0)("CurrentPage")), Convert.ToInt32(dt.Tables(0).Rows(0)("RecordCount")), solicitudes)
                Return objeto
            End Using
        End Using
    End Function




    <WebMethod(Description:="Recaba todas las solicitudes activas")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetSolicitudesAnuPresup(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, pFiltro As String, pEstatusSolicitud As String, pEstatusFactib As String, pEstatusAnuencia As String) As JQGridJsonResponse
        Return GetSolicitudesAnuPresupJSon(pPageSize, pCurrentPage, pSortColumn, pSortOrder, pFiltro, pEstatusSolicitud, pEstatusFactib, pEstatusAnuencia)

    End Function

    Private Function GetSolicitudesAnuPresupJSon(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, pFiltro As String, pEstatusSolicitud As String, pEstatusFactib As String, pEstatusAnuencia As String) As JQGridJsonResponse
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf25").ConnectionString
        Dim dt As DataSet = New DataSet()

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("[SP_AnuLevGrid]", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@Filtro", pFiltro)
                cmd.Parameters.AddWithValue("@EstatusSolicitud", pEstatusSolicitud)
                cmd.Parameters.AddWithValue("@EstatusFactib", pEstatusFactib)
                cmd.Parameters.AddWithValue("@EstatusAnuencia", pEstatusAnuencia)
                cmd.Parameters.AddWithValue("@NoError", 1)
                cmd.Parameters.AddWithValue("@DescError", "ERROR")
                Dim adapt As SqlDataAdapter = New SqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim solicitudes = New List(Of clsSolicitud)
                If Convert.ToInt32(dt.Tables(0).Rows(0)("RecordCount")) > 0 Then
                    For Each row As DataRow In dt.Tables(1).Rows
                        Dim solicitud As clsSolicitud = New clsSolicitud()
                        solicitud.IdSol = row.Item("msolid")
                        solicitud.Fecha = row.Item("mSolFecha")
                        solicitud.Nombre = ValidarDBNull(row.Item("mSolNombre"))
                        'solicitud.IdEstatus = Convert.ToInt32(row.Item("cEstatusSolicitud"))
                        solicitud.UsuCre = ValidarDBNull(row.Item("UsrCre"))
                        solicitud.FecCre = ValidarDBNull(row.Item("FecCre"))
                        solicitud.UsuMod = ValidarDBNull(row.Item("UsrMod"))
                        solicitud.FecMod = ValidarDBNull(row.Item("FecMod"))
                        solicitud.Calle = ValidarDBNull(row.Item("mSolCalle"))
                        solicitud.Col = ValidarDBNull(row.Item("mSolColonia"))
                        solicitud.Tramo = ValidarDBNull(row.Item("mSolTramo"))
                        solicitud.ubic = ValidarDBNull(row.Item("ubic"))
                        solicitud.EstatusDescrip = ValidarDBNull(row.Item("cEstDescripcion"))
                        solicitud.MetrosLong = ValidarDBNull(row.Item("suma_mts_frente"))
                        solicitud.PorcentajeCapt = ValidarDBNull(row.Item("porcentaje"))
                        solicitud.NumDocs = ValidarDBNull(row.Item("levantamientos"))
                        solicitudes.Add(solicitud)
                    Next row
                End If

                Dim objeto As JQGridJsonResponse = New JQGridJsonResponse
                objeto.JQGridJsonResponse(Convert.ToInt32(dt.Tables(0).Rows(0)("PageCount")), Convert.ToInt32(dt.Tables(0).Rows(0)("CurrentPage")), Convert.ToInt32(dt.Tables(0).Rows(0)("RecordCount")), solicitudes)
                Return objeto
            End Using
        End Using
    End Function


    <WebMethod(Description:="Recaba todas las solicitudes activas")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetSolicitudesAnuPresup_psql(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, pFiltro As String, pEstatusSolicitud As String, pEstatusFactib As String, pEstatusAnuencia As String) As JQGridJsonResponse
        Return GetSolicitudesAnuPresupJSon_psql(pPageSize, pCurrentPage, pSortColumn, pSortOrder, pFiltro, pEstatusSolicitud, pEstatusFactib, pEstatusAnuencia)

    End Function

    Private Function GetSolicitudesAnuPresupJSon_psql(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, pFiltro As String, pEstatusSolicitud As String, pEstatusFactib As String, pEstatusAnuencia As String) As JQGridJsonResponse
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("[SP_AnuLevGrid]", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@Filtro", pFiltro)
                cmd.Parameters.AddWithValue("@EstatusSolicitud", pEstatusSolicitud)
                cmd.Parameters.AddWithValue("@EstatusFactib", pEstatusFactib)
                cmd.Parameters.AddWithValue("@EstatusAnuencia", pEstatusAnuencia)
                cmd.Parameters.AddWithValue("@NoError", 1)
                cmd.Parameters.AddWithValue("@DescError", "ERROR")
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim solicitudes = New List(Of clsSolicitud)
                If Convert.ToInt32(dt.Tables(0).Rows(0)("RecordCount")) > 0 Then
                    For Each row As DataRow In dt.Tables(1).Rows
                        Dim solicitud As clsSolicitud = New clsSolicitud()
                        solicitud.IdSol = row.Item("msolid")
                        solicitud.Fecha = row.Item("mSolFecha")
                        solicitud.Nombre = ValidarDBNull(row.Item("mSolNombre"))
                        'solicitud.IdEstatus = Convert.ToInt32(row.Item("cEstatusSolicitud"))
                        solicitud.UsuCre = ValidarDBNull(row.Item("UsrCre"))
                        solicitud.FecCre = ValidarDBNull(row.Item("FecCre"))
                        solicitud.UsuMod = ValidarDBNull(row.Item("UsrMod"))
                        solicitud.FecMod = ValidarDBNull(row.Item("FecMod"))
                        solicitud.Calle = ValidarDBNull(row.Item("mSolCalle"))
                        solicitud.Col = ValidarDBNull(row.Item("mSolColonia"))
                        solicitud.Tramo = ValidarDBNull(row.Item("mSolTramo"))
                        solicitud.ubic = ValidarDBNull(row.Item("ubic"))
                        solicitud.EstatusDescrip = ValidarDBNull(row.Item("cEstDescripcion"))
                        solicitud.MetrosLong = ValidarDBNull(row.Item("suma_mts_frente"))
                        solicitud.PorcentajeCapt = ValidarDBNull(row.Item("porcentaje"))
                        solicitud.NumDocs = ValidarDBNull(row.Item("levantamientos"))
                        solicitudes.Add(solicitud)
                    Next row
                End If

                Dim objeto As JQGridJsonResponse = New JQGridJsonResponse
                objeto.JQGridJsonResponse(Convert.ToInt32(dt.Tables(0).Rows(0)("PageCount")), Convert.ToInt32(dt.Tables(0).Rows(0)("CurrentPage")), Convert.ToInt32(dt.Tables(0).Rows(0)("RecordCount")), solicitudes)
                Return objeto
            End Using
        End Using
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
        Return ValidarDBNull
    End Function

End Class

