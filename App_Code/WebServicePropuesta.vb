Imports System.Data.SqlClient
Imports System.Web.Script.Services
Imports System.Web.Services

' Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente.
<System.Web.Script.Services.ScriptService()> _
<WebService(Namespace: ="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo: =WsiProfiles.BasicProfile1_1)>
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()>
Public Class WebServicePropuesta
    Inherits System.Web.Services.WebService

    <WebMethod(Description:="Actualiza el estatus de una obra en la base de datos")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function ActualizarEstatusObra(idObra As Integer, nuevoEstatus As String) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf25").ConnectionString
        Dim resultado As String = "Error al actualizar el estatus"

        Try
            Using con As New SqlConnection(constr)
                con.Open()
                Dim query As String = "UPDATE obras SET estatus = @nuevoEstatus WHERE id_obra = @idObra"

                Using cmd As New SqlCommand(query, con)
                    cmd.Parameters.AddWithValue("@idObra", idObra)
                    cmd.Parameters.AddWithValue("@nuevoEstatus", nuevoEstatus)
                    Dim filasAfectadas As Integer = cmd.ExecuteNonQuery()

                    If filasAfectadas > 0 Then
                        resultado = "Estatus actualizado correctamente"
                    Else
                        resultado = "No se encontró la obra con el ID proporcionado"
                    End If
                End Using
            End Using
        Catch ex As Exception
            resultado = "Error: " & ex.Message
        End Try

        Return resultado
    End Function

    <WebMethod(Description:="Actualiza el saldo de un cooperador")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function ActualizarSaldoCooperador(ByVal idCooperador As Integer, ByVal nuevoSaldo As Decimal) As String
        Dim resultado As String = "Error al actualizar saldo"
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf25").ConnectionString

        Try
            Using con As New SqlConnection(constr)
                con.Open()
                Using cmd As New SqlCommand("UPDATE tbl_cooperadores SET saldo = @NuevoSaldo WHERE id_cooperador = @IdCooperador", con)
                    cmd.Parameters.AddWithValue("@NuevoSaldo", nuevoSaldo)
                    cmd.Parameters.AddWithValue("@IdCooperador", idCooperador)

                    Dim filasAfectadas As Integer = cmd.ExecuteNonQuery()
                    If filasAfectadas > 0 Then
                        resultado = "Saldo actualizado correctamente"
                    Else
                        resultado = "No se encontró el cooperador con el ID proporcionado"
                    End If
                End Using
            End Using
        Catch ex As Exception
            resultado = "Error: " & ex.Message
        End Try

        Return resultado
    End Function

    <WebMethod(Description:="Inserta una nueva obra en la base de datos")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function InsertarObra(obra As clsObra) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf25").ConnectionString
        Dim resultado As String = "Error al insertar la obra"

        Try
            Using con As New SqlConnection(constr)
                con.Open()
                Dim query As String = "INSERT INTO obras (geom, idsol, tramo, sector, subsector, cvecalle, idpoligono, calle, colonia, id_implan, usrmod, fec_mod, obr_fec_pub1, evid_pub1, obr_fec_pub2, evid_pub2, col_clv2, limite1, limite2, col_nom, cestatus, nomprog, progmun, progcoop, descrip_tipo_obr, obr_clv, obr_mts, obr_cost, obr_int, obr_fecha, obr_cost_total, obr_inc, obr_fecinip, obr_fecvenp, obr_npago, obr_opergob, obr_fec_ini_proc, obr_idtipo_recurso, obr_descrip_tipo_recurso, obr_fec_ini_cob, obr_clv_int, obr_prog2, obr_clv2, obr_sis, obr_status, obr_fec_can, no_contrato, gastos_admvos, evid_obra_proc, evid_termino_obra, obr_nat, obr_num_coops, obr_num_coops_s) " &
            "VALUES (@geom, @idsol, @tramo, @sector, @subsector, @cvecalle, @idpoligono, @calle, @colonia, @id_implan, @usrmod, @fec_mod, @obr_fec_pub1, @evid_pub1, @obr_fec_pub2, @evid_pub2, @col_clv2, @limite1, @limite2, @col_nom, @cestatus, @nomprog, @progmun, @progcoop, @descrip_tipo_obr, @obr_clv, @obr_mts, @obr_cost, @obr_int, @obr_fecha, @obr_cost_total, @obr_inc, @obr_fecinip, @obr_fecvenp, @obr_npago, @obr_opergob, @obr_fec_ini_proc, @obr_idtipo_recurso, @obr_descrip_tipo_recurso, @obr_fec_ini_cob, @obr_clv_int, @obr_prog2, @obr_clv2, @obr_sis, @obr_status, @obr_fec_can, @no_contrato, @gastos_admvos, @evid_obra_proc, @evid_termino_obra, @obr_nat, @obr_num_coops, @obr_num_coops_s)"
                Using cmd As New SqlCommand(query, con)
                    ' Se asignan los parámetros usando las propiedades del objeto "obra"
                    cmd.Parameters.AddWithValue("@geom", obra.geom)
                    cmd.Parameters.AddWithValue("@idsol", obra.idsol)
                    cmd.Parameters.AddWithValue("@tramo", obra.tramo)
                    cmd.Parameters.AddWithValue("@sector", obra.sector)
                    cmd.Parameters.AddWithValue("@subsector", obra.subsector)
                    cmd.Parameters.AddWithValue("@cvecalle", obra.cvecalle)
                    cmd.Parameters.AddWithValue("@idpoligono", obra.idpoligono)
                    cmd.Parameters.AddWithValue("@calle", obra.calle)
                    cmd.Parameters.AddWithValue("@colonia", obra.colonia)
                    cmd.Parameters.AddWithValue("@id_implan", obra.id_implan)
                    cmd.Parameters.AddWithValue("@usrmod", obra.usrmod)
                    cmd.Parameters.AddWithValue("@fec_mod", obra.fec_mod)
                    cmd.Parameters.AddWithValue("@obr_fec_pub1", obra.obr_fec_pub1)
                    cmd.Parameters.AddWithValue("@evid_pub1", obra.evid_pub1)
                    cmd.Parameters.AddWithValue("@obr_fec_pub2", obra.obr_fec_pub2)
                    cmd.Parameters.AddWithValue("@evid_pub2", obra.evid_pub2)
                    cmd.Parameters.AddWithValue("@col_clv2", obra.col_clv2)
                    cmd.Parameters.AddWithValue("@limite1", obra.limite1)
                    cmd.Parameters.AddWithValue("@limite2", obra.limite2)
                    cmd.Parameters.AddWithValue("@col_nom", obra.col_nom)
                    cmd.Parameters.AddWithValue("@cestatus", obra.cestatus)
                    cmd.Parameters.AddWithValue("@nomprog", obra.nomprog)
                    cmd.Parameters.AddWithValue("@progmun", obra.progmun)
                    cmd.Parameters.AddWithValue("@progcoop", obra.progcoop)
                    cmd.Parameters.AddWithValue("@descrip_tipo_obr", obra.descrip_tipo_obr)
                    cmd.Parameters.AddWithValue("@obr_clv", obra.obr_clv)
                    cmd.Parameters.AddWithValue("@obr_mts", obra.obr_mts)
                    cmd.Parameters.AddWithValue("@obr_cost", obra.obr_cost)
                    cmd.Parameters.AddWithValue("@obr_int", obra.obr_int)
                    cmd.Parameters.AddWithValue("@obr_fecha", obra.obr_fecha)
                    cmd.Parameters.AddWithValue("@obr_cost_total", obra.obr_cost_total)
                    cmd.Parameters.AddWithValue("@obr_inc", obra.obr_inc)
                    cmd.Parameters.AddWithValue("@obr_fecinip", obra.obr_fecinip)
                    cmd.Parameters.AddWithValue("@obr_fecvenp", obra.obr_fecvenp)
                    cmd.Parameters.AddWithValue("@obr_npago", obra.obr_npago)
                    cmd.Parameters.AddWithValue("@obr_opergob", obra.obr_opergob)
                    cmd.Parameters.AddWithValue("@obr_fec_ini_proc", obra.obr_fec_ini_proc)
                    cmd.Parameters.AddWithValue("@obr_idtipo_recurso", obra.obr_idtipo_recurso)
                    cmd.Parameters.AddWithValue("@obr_descrip_tipo_recurso", obra.obr_descrip_tipo_recurso)
                    cmd.Parameters.AddWithValue("@obr_fec_ini_cob", obra.obr_fec_ini_cob)
                    cmd.Parameters.AddWithValue("@obr_clv_int", obra.obr_clv_int)
                    cmd.Parameters.AddWithValue("@obr_prog2", obra.obr_prog2)
                    cmd.Parameters.AddWithValue("@obr_clv2", obra.obr_clv2)
                    cmd.Parameters.AddWithValue("@obr_sis", obra.obr_sis)
                    cmd.Parameters.AddWithValue("@obr_status", obra.obr_status)
                    cmd.Parameters.AddWithValue("@obr_fec_can", obra.obr_fec_can)
                    cmd.Parameters.AddWithValue("@no_contrato", obra.no_contrato)
                    cmd.Parameters.AddWithValue("@gastos_admvos", obra.gastos_admvos)
                    cmd.Parameters.AddWithValue("@evid_obra_proc", obra.evid_obra_proc)
                    cmd.Parameters.AddWithValue("@evid_termino_obra", obra.evid_termino_obra)
                    cmd.Parameters.AddWithValue("@obr_nat", obra.obr_nat)
                    cmd.Parameters.AddWithValue("@obr_num_coops", obra.obr_num_coops)
                    cmd.Parameters.AddWithValue("@obr_num_coops_s", obra.obr_num_coops_s)

                    Dim filasAfectadas As Integer = cmd.ExecuteNonQuery()
                    If filasAfectadas > 0 Then
                        resultado = "Obra insertada correctamente"
                    Else
                        resultado = "No se pudo insertar la obra"
                    End If
                End Using
            End Using
        Catch ex As Exception
            resultado = "Error: " & ex.Message
        End Try

        Return resultado
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