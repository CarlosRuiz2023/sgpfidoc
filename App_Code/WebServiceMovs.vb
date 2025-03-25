Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports System.Web.Script.Services
Imports System.Web.Services
Imports Npgsql

<System.Web.Script.Services.ScriptService()> _
<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class WebServiceMovs
    Inherits System.Web.Services.WebService




    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetMovs_psql(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, fecini As String, fecfin As String, movtipo As Integer, idcoop As Integer) As JQGridJsonResponseMov
        Return GetMovsJSon_psql(pPageSize, pCurrentPage, pSortColumn, pSortOrder, fecini, fecfin, movtipo, idcoop)

    End Function

    Private Function GetMovsJSon_psql(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, fecini As String, fecfin As String, movtipo As Integer, idcoop As Integer) As JQGridJsonResponseMov
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()
        Dim pagecount As Integer
        Dim recordcount As Integer
        Dim currentpage As Integer




        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_movs_grid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@fecini", fecini)
                cmd.Parameters.AddWithValue("@fecfin", fecfin)
                cmd.Parameters.AddWithValue("@tipomov", movtipo)
                cmd.Parameters.AddWithValue("@idcoop", idcoop)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim movs = New List(Of clsMovtoFinanc)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim mov As clsMovtoFinanc = New clsMovtoFinanc()
                        mov.mov_obr = ValidarDBNull(row.Item("mov_obra_sifidoc_r"), "cadena")
                        mov.mov_coop = ValidarDBNull(row.Item("mov_coop_sifidoc_r"), "cadena")
                        mov.mov_fecha = ValidarDBNull(row.Item("mov_fecha_r"), "fecha")
                        mov.mov_monto = ValidarDBNull(row.Item("mov_monto_r"), "real")
                        mov.mov_fecha_cap = ValidarDBNull(row.Item("mov_fecha_cap_r"), "fecha")
                        mov.mov_ndep = ValidarDBNull(row.Item("mov_ndep_r"), "cadena")
                        mov.id = ValidarDBNull(row.Item("id_r"), "entero")
                        mov.obr_clv_int = ValidarDBNull(row.Item("obr_clv_int_r"), "integer")
                        mov.coo_clv2 = ValidarDBNull(row.Item("coo_clv2_r"), "integer")
                        mov.mov_descrip = ValidarDBNull(row.Item("mov_descrip_r"), "cadena")
                        mov.mov_tipo_int = ValidarDBNull(row.Item("mov_tipo_int_r"), "entero")
                        movs.Add(mov)
                    Next row
                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))

                Dim objeto As JQGridJsonResponseMov = New JQGridJsonResponseMov
                objeto.JQGridJsonResponseMov(pagecount, currentpage, recordcount, movs)
                Return objeto




            End Using
        End Using
    End Function


    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetMovsGrid2_psql(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, fecini As String, fecfin As String, fid As Integer) As JQGridJsonResponseMov2
        Return GetMovsGridJSon_2_psql(pPageSize, pCurrentPage, pSortColumn, pSortOrder, fecini, fecfin, fid)

    End Function

    Private Function GetMovsGridJSon_2_psql(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, fecini As String, fecfin As String, fid As Integer) As JQGridJsonResponseMov2
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()
        Dim pagecount As Integer
        Dim recordcount As Integer
        Dim currentpage As Integer




        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_bitacora_movs_grid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@pagesize", pPageSize)
                cmd.Parameters.AddWithValue("@currentpage", pPageNumber)
                cmd.Parameters.AddWithValue("@sortcolumn", pSortColumn)
                cmd.Parameters.AddWithValue("@sortorder", pSorterOrder)
                cmd.Parameters.AddWithValue("@fecini_in", fecini)
                cmd.Parameters.AddWithValue("@fecfin_in", fecfin)
                cmd.Parameters.AddWithValue("@fid_in", fid)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim movs = New List(Of clsMovtoFinanc2)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim mov As clsMovtoFinanc2 = New clsMovtoFinanc2()
                        mov.mov_obra_sifidoc = ValidarDBNull(row.Item("mov_obra_sifidoc_r"), "cadena")
                        mov.mov_coop_sifidoc = ValidarDBNull(row.Item("mov_coop_sifidoc_r"), "cadena")
                        mov.fec_mov_as400 = ValidarDBNull(row.Item("fec_mov_as400_r"), "fecha")
                        mov.usu_sifidoc = ValidarDBNull(row.Item("usu_sifidoc_r"), "cadena")
                        mov.monto_abono_sifidoc = ValidarDBNull(row.Item("monto_abono_sifidoc_r"), "real")
                        mov.monto_recargo_sifidoc = ValidarDBNull(row.Item("monto_recargo_sifidoc_r"), "real")
                        mov.tipo_mov_sifidoc = ValidarDBNull(row.Item("tipo_mov_sifidoc_r"), "entero")
                        mov.fec_aplic_mov = ValidarDBNull(row.Item("fec_aplic_mov_r"), "fecha")
                        mov.clave_sifidoc = ValidarDBNull(row.Item("clave_sifidoc_r"), "cadena")
                        mov.consecutivo_sifidoc = ValidarDBNull(row.Item("consecutivo_sifidoc_r"), "entero")
                        mov.fid = ValidarDBNull(row.Item("fid_r"), "entero")
                        mov.usucre = ValidarDBNull(row.Item("usucre_r"), "cadena")
                        mov.monto_mov = ValidarDBNull(row.Item("monto_mov_r"), "real")
                        mov.tipo_mov = ValidarDBNull(row.Item("tipo_mov_r"), "entero")
                        mov.id_mov = ValidarDBNull(row.Item("id_mov_r"), "entero")
                        mov.folio_cajas = ValidarDBNull(row.Item("folio_cajas_r"), "cadena")
                        mov.titulomov = ValidarDBNull(row.Item("titulo_mov_r"), "cadena")
                        mov.estatus_mov = ValidarDBNull(row.Item("estatus_mov_r"), "cadena")
                        movs.Add(mov)
                    Next row
                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))

                Dim objeto As JQGridJsonResponseMov2 = New JQGridJsonResponseMov2
                objeto.JQGridJsonResponseMov2(pagecount, currentpage, recordcount, movs)
                Return objeto




            End Using
        End Using
    End Function

    <WebMethod(Description:="Recaba todas los movmientos financieros de la cartera de cobranza")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetMovsCobGrid_psql(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, fecini As String, fecfin As String, obra_coop_s As String) As JQGridJsonResponseMovCob
        Return GetMovsCobGridJSon_psql(pPageSize, pCurrentPage, pSortColumn, pSortOrder, fecini, fecfin, obra_coop_s)

    End Function

    Private Function GetMovsCobGridJSon_psql(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, fecini As String, fecfin As String, obra_coop_s As String) As JQGridJsonResponseMovCob
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()
        Dim pagecount As Integer
        Dim recordcount As Integer
        Dim currentpage As Integer




        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public3.sp_bitacora_movs_grid2", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@pagesize", pPageSize)
                cmd.Parameters.AddWithValue("@currentpage", pPageNumber)
                cmd.Parameters.AddWithValue("@sortcolumn", pSortColumn)
                cmd.Parameters.AddWithValue("@sortorder", pSorterOrder)
                cmd.Parameters.AddWithValue("@fecini_in", fecini)
                cmd.Parameters.AddWithValue("@fecfin_in", fecfin)
                cmd.Parameters.AddWithValue("@obra_coop_s_in", obra_coop_s)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim movs = New List(Of clsMovtoFinancCob)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim mov As clsMovtoFinancCob = New clsMovtoFinancCob()
                        mov.mov_obr = ValidarDBNull(row.Item("mov_obr_r"), "cadena")
                        mov.mov_coop = ValidarDBNull(row.Item("mov_coop_r"), "cadena")
                        mov.mov_fecha = ValidarDBNull(row.Item("mov_fecha_r"), "fecha")
                        mov.mov_usu = ValidarDBNull(row.Item("mov_usu_r"), "cadena")
                        mov.mov_cap = ValidarDBNull(row.Item("mov_cap_r"), "real")
                        mov.mov_nor = ValidarDBNull(row.Item("mov_nor_r"), "real")
                        mov.mov_mora = ValidarDBNull(row.Item("mov_mora_r"), "real")
                        mov.mov_tipo = ValidarDBNull(row.Item("mov_tipo_r"), "entero")
                        mov.mov_fecha_cap = ValidarDBNull(row.Item("mov_fecha_cap_r"), "fecha")
                        mov.mov_ndep = ValidarDBNull(row.Item("mov_ndep_r"), "cadena")
                        mov.mov_clv1 = ValidarDBNull(row.Item("mov_clv1_r"), "cadena")
                        mov.mov_greq = ValidarDBNull(row.Item("mov_greq_r"), "real")
                        mov.mov_gejec = ValidarDBNull(row.Item("mov_gejec_r"), "real")
                        mov.mov_recargos = ValidarDBNull(row.Item("mov_recargos_r"), "real")
                        mov.mov_capital = ValidarDBNull(row.Item("mov_capital_r"), "real")
                        mov.mov_devolver = ValidarDBNull(row.Item("mov_devolver_r"), "real")
                        mov.id = ValidarDBNull(row.Item("id_r"), "entero")
                        mov.id2 = ValidarDBNull(row.Item("id2_r"), "entero")
                        mov.fid = ValidarDBNull(row.Item("fid_r"), "entero")
                        mov.cactivo = ValidarDBNull(row.Item("cactivo_r"), "entero")
                        mov.mov_cargo_pagado = ValidarDBNull(row.Item("mov_cargo_pagado_r"), "entero")
                        mov.titulomov = ValidarDBNull(row.Item("titulomov_r"), "cadena")
                        movs.Add(mov)
                    Next row
                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))

                Dim objeto As JQGridJsonResponseMovCob = New JQGridJsonResponseMovCob
                objeto.JQGridJsonResponseMovCob(pagecount, currentpage, recordcount, movs)
                Return objeto


            End Using
        End Using
    End Function
    <WebMethod(Description:="Retorna datos de un predio seleccionado")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function RegMov(objMovFinanc As clsMovtoFinanc) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim numerror As Integer = 0
        Dim idmov As Integer
        Dim messerror As String = Nothing

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_mov_financ", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure

                cmd.Parameters.AddWithValue("@mov_obrx", objMovFinanc.mov_obr)
                cmd.Parameters.AddWithValue("@mov_coopx", objMovFinanc.mov_coop)
                cmd.Parameters.AddWithValue("@mov_fechax", objMovFinanc.mov_fecha)
                cmd.Parameters.AddWithValue("@mov_usux", objMovFinanc.mov_usu)
                cmd.Parameters.AddWithValue("@mov_montox", objMovFinanc.mov_monto)
                cmd.Parameters.AddWithValue("@mov_fecha_capx", objMovFinanc.mov_fecha_cap)
                cmd.Parameters.AddWithValue("@mov_ndepx", objMovFinanc.mov_ndep)
                cmd.Parameters.AddWithValue("@mov_devolverx", objMovFinanc.mov_devolver)
                cmd.Parameters.AddWithValue("@mov_capitalx", objMovFinanc.mov_capital)
                cmd.Parameters.AddWithValue("@idx", objMovFinanc.id)
                cmd.Parameters.AddWithValue("@obr_clv_intx", objMovFinanc.obr_clv_int)
                cmd.Parameters.AddWithValue("@coo_clv2x", objMovFinanc.coo_clv2)
                cmd.Parameters.AddWithValue("@mov_tipo_intx", objMovFinanc.mov_tipo_int)
                cmd.Parameters.AddWithValue("@mov_descripx", objMovFinanc.mov_descrip)
                cmd.Parameters.AddWithValue("@accionx", objMovFinanc.accion)

                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@noerror", NpgsqlTypes.NpgsqlDbType.Integer, 36)
                parIdError.Direction = ParameterDirection.Output
                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@descerror", NpgsqlTypes.NpgsqlDbType.Varchar, 255) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output
                Dim parpresupx As NpgsqlParameter = New NpgsqlParameter("@idmov", NpgsqlTypes.NpgsqlDbType.Integer, 36) ' .Value = Space(1000)
                parpresupx.Direction = ParameterDirection.Output


                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)
                cmd.Parameters.Add(parpresupx)

                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                idmov = cmd.Parameters("@idmov").Value()
                numerror = cmd.Parameters("@noerror").Value()
                messerror = cmd.Parameters("@descerror").Value()
                con.Close()
            End Using
        End Using
        Try
            If numerror > 0 Then
                Return messerror & ":0"
            Else
                Return "Accion ejecutada correctamente:" & idmov.ToString
            End If
        Catch ex As SqlException
            Return ex.Message & "No.Error:" & numerror.ToString() & "Mensaje error:" & messerror
        End Try
    End Function

    <WebMethod(Description:="Retorna sector,subsector,nombre_actual,nombre_ant de las colonias de DU")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetTipoMov(tipo_mov As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim ds As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_tipomovq", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@accion", tipo_mov)
                adapt.Fill(ds, "tipomov")
                Try
                    Dim sb = New StringBuilder()
                    Using writer = New StringWriter(sb)
                        ds.WriteXml(writer)
                        Dim xml As String = sb.ToString()
                        Return xml
                    End Using
                Catch ex As Exception
                    Return "Error " & ex.Message
                End Try
                con.Close()
            End Using
        End Using

    End Function

    <WebMethod(Description:="Retorna el conjunto de registros del catalago de Tipo de Movimientos para llenar los Combos")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetTipoRecargo(accion As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim ds As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public3.sp_tipo_recargo_q", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@accion", accion)
                adapt.Fill(ds, "tipo_recargo")
                Try
                    Dim sb = New StringBuilder()
                    Using writer = New StringWriter(sb)
                        ds.WriteXml(writer)
                        Dim xml As String = sb.ToString()
                        Return xml
                    End Using
                Catch ex As Exception
                    Return "Error " & ex.Message
                End Try
                con.Close()
            End Using
        End Using

    End Function

    <WebMethod(Description:="Retorna los pagos correspondientes a un fid")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetPagos(fid As Integer, accion As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim ds As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_pagos_q", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@fidx", fid)
                cmd.Parameters.AddWithValue("@accionx", accion)
                adapt.Fill(ds, "pagos")
                Try
                    Dim sb = New StringBuilder()
                    Using writer = New StringWriter(sb)
                        ds.WriteXml(writer)
                        Dim xml As String = sb.ToString()
                        Return xml
                    End Using
                Catch ex As Exception
                    Return "Error " & ex.Message
                End Try
                con.Close()
            End Using
        End Using

    End Function


    <WebMethod(Description:="Recaba todas los movmientos financieros de la cartera de cobranza")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetCargosPagados_CVall_psql(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, coop_s As String, tipo_mov As String) As JQGridJsonResponseCargosPagados
        Return GetCargosPagados_psql(pPageSize, pCurrentPage, pSortColumn, pSortOrder, coop_s, tipo_mov)

    End Function

    Private Function GetCargosPagados_psql(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, coop_s As String, tipo_mov As String) As JQGridJsonResponseCargosPagados
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()
        Dim pagecount As Integer
        Dim recordcount As Integer
        Dim currentpage As Integer

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public3.sp_cargos_pagados_grid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@pagesize", pPageSize)
                cmd.Parameters.AddWithValue("@currentpage", pPageNumber)
                cmd.Parameters.AddWithValue("@sortcolumn", pSortColumn)
                cmd.Parameters.AddWithValue("@sortorder", pSorterOrder)
                cmd.Parameters.AddWithValue("@coop_sx", coop_s)
                cmd.Parameters.AddWithValue("@movtipo", tipo_mov)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim cargos_pagados = New List(Of clsCargosPagados)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim cargo_pagado As clsCargosPagados = New clsCargosPagados()
                        cargo_pagado.clv_coo = ValidarDBNull(row.Item("coo_clv_r"), "cadena")
                        cargo_pagado.monto_pagado = ValidarDBNull(row.Item("monto_pagado_r"), "real")
                        cargo_pagado.idpago = ValidarDBNull(row.Item("idpago_r"), "entero")
                        cargo_pagado.idcargo = ValidarDBNull(row.Item("idcargo_r"), "entero")
                        cargo_pagado.fecha_pago = ValidarDBNull(row.Item("fecha_pago_r"), "fecha")
                        cargo_pagado.fecha_cargo = ValidarDBNull(row.Item("fecha_cargo_r"), "fecha")
                        cargo_pagado.coo_clv2 = ValidarDBNull(row.Item("coo_clv2_r"), "cadena")
                        cargo_pagado.tipo_mov = ValidarDBNull(row.Item("tipo_mov_r"), "cadena")
                        cargos_pagados.Add(cargo_pagado)
                    Next row
                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))

                Dim objeto As JQGridJsonResponseCargosPagados = New JQGridJsonResponseCargosPagados
                objeto.JQGridJsonResponseCargosPagados(pagecount, currentpage, recordcount, cargos_pagados)
                Return objeto


            End Using
        End Using
    End Function

    <WebMethod(Description:="Recaba todas los movmientos financieros de la cartera de cobranza")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetAbonosCapital_CVall_psql(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, coop_s As String) As JQGridJsonResponseAbonoCapital
        Return GetAbonosCapital_psql(pPageSize, pCurrentPage, pSortColumn, pSortOrder, coop_s)

    End Function

    Private Function GetAbonosCapital_psql(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, coop_s As String) As JQGridJsonResponseAbonoCapital
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()
        Dim pagecount As Integer
        Dim recordcount As Integer
        Dim currentpage As Integer

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public3.sp_abonos_capital_grid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@pagesize", pPageSize)
                cmd.Parameters.AddWithValue("@currentpage", pPageNumber)
                cmd.Parameters.AddWithValue("@sortcolumn", pSortColumn)
                cmd.Parameters.AddWithValue("@sortorder", pSorterOrder)
                cmd.Parameters.AddWithValue("@coop_sx", coop_s)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim abonos_capital = New List(Of clsAbonoCapital)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim abono_capital As clsAbonoCapital = New clsAbonoCapital()
                        abono_capital.clv_coo = ValidarDBNull(row.Item("clv_coo_r"), "cadena")
                        abono_capital.monto_abonar = ValidarDBNull(row.Item("monto_abonar_r"), "real")
                        abono_capital.idpago = ValidarDBNull(row.Item("idpago_r"), "entero")
                        abono_capital.fecha_pago = ValidarDBNull(row.Item("fecha_pago_r"), "fecha")
                        abono_capital.coo_clv2 = ValidarDBNull(row.Item("coo_clv2_r"), "cadena")
                        abono_capital.folio_caja = ValidarDBNull(row.Item("folio_caja_r"), "cadena")
                        abonos_capital.Add(abono_capital)
                    Next row
                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))

                Dim objeto As JQGridJsonResponseAbonoCapital = New JQGridJsonResponseAbonoCapital
                objeto.JQGridJsonResponseAbonoCapital(pagecount, currentpage, recordcount, abonos_capital)
                Return objeto
            End Using
        End Using
    End Function

    <WebMethod(Description:="Registra el movimiento en la tabla de movimientos de cartera vencida total CV_all")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GestionMovtoFinanc_CVall(objMovtoCV_all As clsMovtoFinancCob, idusu As Integer, accion As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public3.sp_movs_financ_cv_all", con)
                Dim custDA As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@mov_obr_in", objMovtoCV_all.mov_obr)
                cmd.Parameters.AddWithValue("@mov_coop_in", objMovtoCV_all.mov_coop)
                cmd.Parameters.AddWithValue("@mov_fecha_in", objMovtoCV_all.mov_fecha)
                cmd.Parameters.AddWithValue("@mov_usu_in", objMovtoCV_all.mov_usu)
                cmd.Parameters.AddWithValue("@mov_cap_int_in", objMovtoCV_all.mov_cap)
                cmd.Parameters.AddWithValue("@mov_nor_in", objMovtoCV_all.mov_nor)
                cmd.Parameters.AddWithValue("@mov_mora_in", objMovtoCV_all.mov_mora)
                cmd.Parameters.AddWithValue("@mov_tipo_in", objMovtoCV_all.mov_tipo)
                cmd.Parameters.AddWithValue("@mov_fecha_cap_in", objMovtoCV_all.mov_fecha_cap)
                cmd.Parameters.AddWithValue("@mov_ndep_in", objMovtoCV_all.mov_ndep)
                cmd.Parameters.AddWithValue("@mov_clv1_in", objMovtoCV_all.mov_clv1)
                cmd.Parameters.AddWithValue("@mov_greq_in", objMovtoCV_all.mov_greq)
                cmd.Parameters.AddWithValue("@mov_gejec_in", objMovtoCV_all.mov_gejec)
                cmd.Parameters.AddWithValue("@mov_recargos_in", objMovtoCV_all.mov_recargos)
                cmd.Parameters.AddWithValue("@mov_capital_in", objMovtoCV_all.mov_capital)
                cmd.Parameters.AddWithValue("@mov_devolver_in", objMovtoCV_all.mov_devolver)
                cmd.Parameters.AddWithValue("@id_in", objMovtoCV_all.id)
                cmd.Parameters.AddWithValue("@id2_in", objMovtoCV_all.id2)
                cmd.Parameters.AddWithValue("@fid_in", objMovtoCV_all.fid)
                cmd.Parameters.AddWithValue("@cactivo_in", objMovtoCV_all.cactivo)
                cmd.Parameters.AddWithValue("@mov_cargo_pagado_in", objMovtoCV_all.mov_cargo_pagado)
                cmd.Parameters.AddWithValue("@titulomov_in", objMovtoCV_all.titulomov)
                cmd.Parameters.AddWithValue("@idusu_in", idusu)
                cmd.Parameters.AddWithValue("@accion_in", accion)

                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@noerror", NpgsqlTypes.NpgsqlDbType.Integer, 36)
                parIdError.Direction = ParameterDirection.Output
                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@descerror", NpgsqlTypes.NpgsqlDbType.Varchar, 255) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output

                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)


                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                numerror = cmd.Parameters("@noerror").Value()
                messerror = cmd.Parameters("@descerror").Value()
                con.Close()
            End Using
        End Using
        Try
            Return numerror.ToString + ":" + messerror
        Catch ex As Exception
            Return "Error " & ex.Message
        End Try
    End Function


    <WebMethod(Description:="Retorna datos de un predio seleccionado")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function TransPago(objTransPago As clsTransPago) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing


        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_trans_pago", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure

                cmd.Parameters.AddWithValue("@fid_o_in", objTransPago.fid_o)
                cmd.Parameters.AddWithValue("@fid_d_in", objTransPago.fid_d)
                cmd.Parameters.AddWithValue("@id_mov_in", objTransPago.id_mov)
                cmd.Parameters.AddWithValue("@monto_trans_in", objTransPago.monto_trans)
                cmd.Parameters.AddWithValue("@idusu_in", objTransPago.idusu)

                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@noerror", NpgsqlTypes.NpgsqlDbType.Integer, 36)
                parIdError.Direction = ParameterDirection.Output
                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@descerror", NpgsqlTypes.NpgsqlDbType.Varchar, 255) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output

                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)

                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                numerror = cmd.Parameters("@NoError").Value()
                messerror = cmd.Parameters("@DescError").Value()

                con.Close()

            End Using
        End Using

        Try
            Return "Pago transferido correctamente"
        Catch ex As SqlException
            Return ex.Message & "No.Error:" & numerror.ToString() & "Mensaje error:" & messerror
        End Try
    End Function



    Private Function ValidarDBNull(objParametro As Object, tipodato As String) As Object
        If IsDBNull(objParametro.ToString) Then
            ValidarDBNull = ""
        Else
            If objParametro.ToString = "" Then
                If tipodato = "entero" Then
                    ValidarDBNull = 0
                Else
                    If tipodato = "fecha" Then
                        ValidarDBNull = "01/01/1900"
                    Else
                        If tipodato = "real" Then
                            ValidarDBNull = "0.0"
                        Else
                            If tipodato = "hora" Then
                                ValidarDBNull = "00:00:00"
                            Else
                                ValidarDBNull = ""
                            End If
                        End If
                    End If
                End If
            Else
                ValidarDBNull = objParametro.ToString
            End If
        End If
        Return ValidarDBNull
    End Function


End Class