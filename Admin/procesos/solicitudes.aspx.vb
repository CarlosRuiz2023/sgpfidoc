Imports System.Data
Imports System.Data.SqlClient
Partial Class Admin_procesos_solicitudes
    Inherits System.Web.UI.Page
    Public objUsuarioEN As New clsUsuarios
    Public objSol As New clsSolicitudes
    Public objCalles As New clsCalles
    Public objAva As New clsAvanzar
    Public objEstatusSol As New clsEstatusSol
    Public objOfi As New clsOficio
    Public funcion As New funciones
    Public permisosSol(4) As Integer
    Public permisosFact(4) As Integer
    Public permisosAnu(4) As Integer
    Private Shared dts As DataTable
    Private Shared dt As DataTable
    Private Shared permisos As DataTable
    Private Shared dtc As DataTable
    Private Shared dtava As DataTable
    Private Shared dtEstSol As DataTable
    Private Shared dtp As DataTable
    Shared conn As New clsConexion
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
       
        'Dim t As Integer = grvSolicitudes.Rows.Count.ToString()
        'lblTotalRegistros.Text = t
        If Not Page.IsPostBack Then
            If IsNothing(Session("USUARIO")) Then
                Session.Abandon()
                Response.Redirect("~/Default.aspx")
            End If

            'ViewState("SortDirection") = "DESC"
            'ViewState("SortExpression") = "mSolFecha"
            'Valida que el usuario tenga acceso a la gestion de solicitudes            
            '   CargarDatos()
            'DataBind()

        End If
            'GridViewPagingControl.pagingClickArgs = New EventHandler(AddressOf Paging_Click)

        'txtFec1.Attributes.Add("onBlur", "return validarfechas2('ContentPlaceHolder1_txtFec1');")
        'txtFec2.Attributes.Add("onBlur", "return validarfechas2('ContentPlaceHolder1_txtFec2');")
        'txtSolId.Attributes.Add("onkeypress", "return validarNumeros(event)")
        'txtFec1.Attributes.Add("onkeypress", "return fecha(event)")
        'txtFec2.Attributes.Add("onkeypress", "return fecha(event)")
        'txtCalle.Attributes.Add("onChange", "return conMayusculas(this);")
        'txtCol.Attributes.Add("onChange", "return conMayusculas(this);")
        'imgBuscar.Attributes.Add("onmouseover", "this.style.cursor='pointer'")
    End Sub

    Private Function Lee_Permisos()
        Dim dtp As DataTable
        'Dim cadena As String
        Dim objUsuarioEn As New clsUsuarios

        'donde el primer parametro es el usuario y el segundo es la opcion del catalogo de "Usuarios"
        dtp = objUsuarioEn.GetPermisos(Session("IDUSUARIO"), 6)

        'cadena = dt.Rows(0).Item(2)
        objUsuarioEn = Nothing
        Return dtp
    End Function
    Private Sub DeterminarPermisos()
        dtp = objUsuarioEN.GetPermisos(Session("IDUSUARIO"), 6)


        If dtp.Rows.Count > 0 Then
            permisosSol(0) = dtp.Rows(0).Item(2) 'Opción de Consulta
            permisosSol(1) = dtp.Rows(0).Item(3) 'Opción de Alta de Solicitud
            permisosSol(2) = dtp.Rows(0).Item(4) 'Opción de Modificación de Solicitud
            permisosSol(3) = dtp.Rows(0).Item(5) 'Opción de Modificación de Solicitud
            permisosSol(4) = dtp.Rows(0).Item(6) 'Opción de Modificación de Solicitud        
        End If


        'Anuencia
        dtp = objUsuarioEN.GetPermisos(Session("IDUSUARIO"), 7)
        If dtp.Rows.Count > 0 Then
            permisosAnu(0) = dtp.Rows(0).Item(2) 'Opción de Consulta de Anuencia
            permisosAnu(1) = dtp.Rows(0).Item(3) 'Opción de Alta de Anuencia
            permisosAnu(2) = dtp.Rows(0).Item(4) 'Opción de Eliminación de Anuencia
            permisosAnu(3) = dtp.Rows(0).Item(5) 'Opción de Modificar de Anuencia
            permisosAnu(4) = dtp.Rows(0).Item(6) 'Opción de Administración de Anuencia
        End If


        'Factibilidad
        dtp = objUsuarioEN.GetPermisos(Session("IDUSUARIO"), 4)
        If dtp.Rows.Count > 0 Then
            permisosFact(0) = dtp.Rows(0).Item(2) 'Opción de Consulta de Factibilidad
            permisosFact(1) = dtp.Rows(0).Item(3) 'Opción de Alta de Factibilidad
            permisosFact(2) = dtp.Rows(0).Item(4) 'Opción de Eliminación de Factibilidad
            permisosFact(3) = dtp.Rows(0).Item(5) 'Opción de Modificar de Factibilidad
            permisosFact(4) = dtp.Rows(0).Item(6) 'Opción de Administración de Factibilidad        
        End If
    End Sub

    ' Private Sub CargarDatos()
    '    DeterminarPermisos()

    'Valida si el usuario tiene privilegios para consultar las solicitudes
    '   If permisosSol(0) = 0 Then
    'MsgBox("NO TIENE PERMISOS PARA ESTA OPCION", MsgBoxStyle.Information)
    '       Response.Write("<script>alert('NO TIENE PERMISOS PARA ESTA OPCION'); window.location.href='../../inicio.aspx';</script>")
    'Response.Redirect("../../forms/Default.aspx")
    '       Exit Sub
    '    Else
    '       objEstatusSol.Accion = "Todos"
    '       dtEstSol = clsEstatusSol.Consulta_Estatus(objEstatusSol)
    '        cmbEstatus.DataSource = dtEstSol
    '       cmbEstatus.DataValueField = "cEstid"
    '      cmbEstatus.DataTextField = "cEstDescripcion"
    '       cmbEstatus.DataBind()
    '       cmbEstatus.Items.Insert(0, "TODOS")
    '       cmbEstatus.SelectedValue = hfEstatusSol.Value

    'Valida si permite dar de alta una solicitud
    '        If permisosSol(1) = 0 Then
    '           Agregar.Visible = False
    '       Else
    '          Agregar.Visible = True
    '          Agregar.Attributes.Add("onmouseover", "this.style.cursor='pointer'")
    'Agregar.Attributes.Add("onclick", "javascript:window.location.href='../../procesos/solicitudesAB.aspx'")
    '          Agregar.Attributes.Add("onclick", "openSol(" & 0 & ")")

    '        End If
    '       AsignarAccion()
    'Dim ban As Boolean = clsSolicitudes.Consulta_Solicitudes(objSol, dtc) 'Se reciben todos los valores del SP
    '       If ban Then
    '          grvSolicitudes.DataSource = dtc 'Se vincula el gridview al datasource "dt"
    '         grvSolicitudes.DataBind() 'Se cargan los valores en el datagrid
    '        lblTotalRegistros.Text = dtc.Rows.Count.ToString
    '   Else
    '      lblError.Visible = True
    '     lblError.Text = objSol.Mensaje
    'End If
    '
    'Dim t2 As Integer = dtc.Rows.Count.ToString()
    '       lblTotalRegistros.Text = t2
    '  End If
    'End Sub

    'Private Sub grvSolicitudes_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grvSolicitudes.RowDataBound

    'If (e.Row.RowType = DataControlRowType.DataRow) Then
    'Dim imgMod As Image
    'Dim imgEli As Image
    'Dim imgAva As Image
    ' Dim imgAnu As Image
    'Dim imgUsu As Image
    'Dim imgDis As Image


    '        imgMod = CType(e.Row.Cells(0).FindControl("Editar"), Image)
    '       imgEli = CType(e.Row.Cells(0).FindControl("Eliminar"), Image)
    '      imgAva = CType(e.Row.Cells(0).FindControl("Factibilidad"), Image)
    '     imgAnu = CType(e.Row.Cells(0).FindControl("Anuencia"), Image)
    '    imgUsu = CType(e.Row.Cells(0).FindControl("Cooperadores"), Image)
    '    imgDis = CType(e.Row.Cells(0).FindControl("Distancia"), Image)


    'Dim vid As Label
    '       vid = CType(e.Row.Cells(0).FindControl("msolid"), Label)
    '
    '
    ' Dim vEstSol As Label
    '      vEstSol = CType(e.Row.Cells(0).FindControl("cEstSol"), Label)

    'Dim vEstFact As Label
    '        vEstFact = CType(e.Row.Cells(0).FindControl("cEstId"), Label)

    'Dim vFileFact As Label
    '        vFileFact = CType(e.Row.Cells(0).FindControl("mFact"), Label)

    'Dim vEstAnu As Label
    '        vEstAnu = CType(e.Row.Cells(0).FindControl("mAnuEstatus"), Label)

    'Dim vFileAnu As Label
    '        vFileAnu = CType(e.Row.Cells(0).FindControl("mFileAnu"), Label)


    ''Valida si el usuario puede modificar la solicitud
    '        If permisosSol(3) = 0 Then
    '            imgMod.ImageUrl = "../../imagenes/candado.png"
    '        Else
    '            If vEstSol.Text = "INICIAL" Then
    '                imgMod.ImageUrl = "../../imagenes/editar_datos.png"
    '                imgMod.Attributes.Add("onmouseover", "this.style.cursor='pointer'")
    ''imgMod.Attributes.Add("onclick", "openSol(" & vid.Text & ")")
    '            End If
    '        End If

    ''Valida si el usuario puede cancelar la solicitud
    '        If permisosSol(2) = 0 Then
    '            imgEli.ImageUrl = "../../imagenes/candado.png"
    '        Else
    '            imgEli.ImageUrl = "../../imagenes/noaceptado16.png"
    '            imgEli.Attributes.Add("onmouseover", "this.style.cursor='pointer'")
    '            imgEli.Attributes.Add("onclick", "javascript:window.location.href='../../procesos/solicitudesAB.aspx?id=" & vid.Text & "'")
    '        End If

    ''Verifica  la columna de FACTIBILIDAD

    ''Valida si el usuario tiene opcion de consultar la factibilidad
    '        If permisosFact(0) = 0 Then
    '            imgAva.ImageUrl = "../../imagenes/candado.png"
    '        Else 'El usuario tiene permiso de consultar  factibilidades
    '            If vEstFact.Text = "" Then 'Si no existe factibilidad
    '                imgAva.ImageUrl = "../../imagenes/stop.ico"
    '                If permisosFact(1) = 1 Then  'Si el usuario puede dar de alta una factibilidad y no existe factibilidad capturada
    '                    imgAva.Attributes.Add("onmouseover", "this.style.cursor='pointer'")
    '                    imgAva.Attributes.Add("onclick", "javascript:window.location.href='../../procesos/avanzar.aspx?id=" & vid.Text & "'")
    '                End If
    '            Else
    '                If (vEstFact.Text = "2" Or vEstFact.Text = "3") Then 'La factibilidad tiene el estatus de PROCEDE o PROCEDE POR INSTRUCCION 
    '                    If vEstFact.Text = "2" Then 'Si la factibilidad tiene el estaus de PROCEDE
    '                        imgAva.ImageUrl = "../../imagenes/msgbox04.ico"
    '                    Else
    '                        imgAva.ImageUrl = "../../imagenes/msgbox03.ico"
    '                    End If
    '                    If permisosFact(3) = 1 And vEstSol.Text = "FACTIBILIDAD" Then 'Si el usuario tiene permiso de modificar la factibilidad y la solicitud esta en FACTIBILIDAD
    '                        imgAva.Attributes.Add("onmouseover", "this.style.cursor='pointer'")
    '                        imgAva.Attributes.Add("onclick", "javascript:window.location.href='../../procesos/avanzar.aspx?id=" & vid.Text & "'")
    '                    Else
    '                        If vFileFact.Text <> "" Then ' Si el documento existe y el usuario no tiene permiso de modificar la factibilidad
    '                            imgAva.Attributes.Add("onmouseover", "this.style.cursor='pointer'")
    '                            imgAva.Attributes.Add("onclick", "openDcto('" & vFileFact.Text & "')")
    '                        Else 'Si no existe el documento y el usuario no tiene permiso de modificar la factibilidad
    '                            imgAva.Attributes.Add("onclick", "<script>alert('NO EXISTE DOCUMENTO ESCANEADO');</script>")
    '                        End If
    '                    End If
    '                Else ' La factibilidad tiene el estatus de "NO PROCEDE"
    '                    imgAva.ImageUrl = "../../imagenes/msgbox02.ico"
    '                    If vFileFact.Text <> "" Then ' Si el documento existe y la factibilidad tiene el estatus de "NO PROCEDE"
    '                        imgAva.Attributes.Add("onmouseover", "this.style.cursor='pointer'")
    '                        imgAva.Attributes.Add("onclick", "openDcto('" & vFileFact.Text & "')")
    '                    Else 'Si no existe el documento
    '                        imgAva.Attributes.Add("onclick", "<script>alert('NO EXISTE DOCUMENTO ESCANEADO');</script>")
    '                    End If
    '                End If
    '            End If
    '        End If


    ''Valida la columna de ANUENCIA


    '        If permisosAnu(0) = 0 Then 'si el usuario no puede consultar las anuencias
    '            imgAnu.ImageUrl = "../../imagenes/candado.png"
    '        Else
    '            If vEstAnu.Text = "" Or vEstAnu.Text = "0" Then 'Si no existe anuencia
    '                imgAnu.ImageUrl = "../../imagenes/stop.ico"
    '                If permisosAnu(1) = 1 And permisosAnu(4) = 0 Then 'Si el usuario tiene permiso de dar de alta una anuencia y no pueda administrar las anuencias (sea usuario de promocion)
    '                    imgAnu.Attributes.Add("onmouseover", "this.style.cursor='pointer'")
    '                    imgAnu.Attributes.Add("onclick", "javascript:window.location.href='../../procesos/anuencia.aspx?id=" & vid.Text & "'")
    '                End If
    '            Else
    '                If vEstAnu.Text = "1" Or vEstAnu.Text = "2" Or vEstAnu.Text = "4" Then 'Si la anuencia se encuentra con el cooperador o en promocion
    '                    If vEstAnu.Text = "1" Then
    '                        imgAnu.ImageUrl = "../../imagenes/templateicon.ico"
    '                    Else
    '                        imgAnu.ImageUrl = "../../imagenes/wss.ico"
    '                    End If
    '                    If permisosAnu(3) = 1 And permisosAnu(4) = 0 Then 'Si el usuario tiene permiso de modificar una anuencia y no pueda administrar las anuencias (sea usuario de promocion)
    '                        imgAnu.Attributes.Add("onmouseover", "this.style.cursor='pointer'")
    '                        imgAnu.Attributes.Add("onclick", "javascript:window.location.href='../../procesos/anuencia.aspx?id=" & vid.Text & "'")
    '                    Else
    '                        If vFileAnu.Text <> "" Then ' Si el documento existe
    '                            imgAnu.Attributes.Add("onmouseover", "this.style.cursor='pointer'")
    '                            imgAnu.Attributes.Add("onclick", "openDcto('" & vFileAnu.Text & "')")
    '                        Else 'Si no existe el documento
    '                            imgAnu.Attributes.Add("onclick", "<script>alert('NO EXISTE DOCUMENTO ESCANEADO');</script>")
    '                        End If
    '                    End If
    '                Else
    '                    imgAnu.ImageUrl = "../../imagenes/scdrespl.ico"
    '                    If permisosAnu(4) = 1 Then 'Si el usuario tiene permisos de ADMINISTRAR (USUARIO DE CALIDAD)
    '                        imgAnu.Attributes.Add("onmouseover", "this.style.cursor='pointer'")
    '                        imgAnu.Attributes.Add("onclick", "javascript:window.location.href='../../procesos/porcentaje_anu.aspx?id=" & vid.Text & "'")
    '                    Else
    '                        If vFileAnu.Text <> "" Then ' Si el documento existe
    '                            imgAnu.Attributes.Add("onmouseover", "this.style.cursor='pointer'")
    '                            imgAnu.Attributes.Add("onclick", "openDcto('" & vFileAnu.Text & "')")
    '                        Else 'Si no existe el documento
    '                            imgAnu.Attributes.Add("onclick", "<script>alert('NO EXISTE DOCUMENTO ESCANEADO');</script>")
    '                        End If
    '                    End If
    '                End If
    '            End If
    '        End If

    '    End If

    'End Sub
    'Private Sub AsignarAccion()
    '    If txtSolId.Text <> "" Then
    '        objSol.Accion = "Consulta_IdSol"
    '        objSol.IdSol = txtSolId.Text
    '        cmbEstatus.SelectedIndex = 0
    '        txtFec1.Text = ""
    '        txtFec2.Text = ""
    '        txtCalle.Text = ""
    '        txtCol.Text = ""
    '    Else
    '        If cmbEstatus.SelectedValue <> "" And cmbEstatus.SelectedValue <> "TODOS" Then
    '            objSol.Accion = "Cons_EstSol"
    '            objSol.IdEstatus = cmbEstatus.SelectedValue
    '            txtFec1.Text = ""
    '            txtFec2.Text = ""
    '            txtCalle.Text = ""
    '            txtCol.Text = ""
    '        Else
    '            If txtFec1.Text <> "" And txtFec2.Text <> "" Then
    '                If IsDate(txtFec1.Text) And IsDate(txtFec2.Text) Then
    '                    objSol.Accion = "Consulta_Fec"
    '                    objSol.Fecha1 = txtFec1.Text
    '                    objSol.Fecha2 = txtFec2.Text
    '                Else
    '                    txtFec1.Text = ""
    '                    txtFec2.Text = ""
    '                End If
    '                txtCalle.Text = ""
    '                txtCol.Text = ""
    '            Else
    '                If txtCalle.Text <> "" Then
    '                    objSol.Accion = "Consulta_Calle"
    '                    objSol.Calle = txtCalle.Text
    '                    txtCol.Text = ""
    '                Else
    '                    If txtCol.Text <> "" Then
    '                        objSol.Accion = "Consulta_Col"
    '                        objSol.Col = txtCol.Text
    '                    Else
    '                        objSol.Accion = "Todos"
    '                    End If
    '                End If
    '            End If
    '        End If
    '    End If
    'End Sub
    'Protected Sub grvSolicitudes_PageIndexChanged(sender As Object, e As EventArgs) Handles grvSolicitudes.PageIndexChanged
    '    CargarDatos()
    'End Sub
    'Protected Sub grvSolicitudes_PageIndexChanging(sender As Object, e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles grvSolicitudes.PageIndexChanging
    '    grvSolicitudes.PageIndex = e.NewPageIndex
    '    hfEstatusSol.Value = cmbEstatus.SelectedValue
    '    grvSolicitudes.DataBind()
    'End Sub

    'Protected Sub btnBuscar2_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles btnBuscar2.Click
    '    hfEstatusSol.Value = cmbEstatus.SelectedValue
    '    CargarDatos()
    'End Sub

End Class