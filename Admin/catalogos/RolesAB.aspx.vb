Imports System.Data
Imports System.Data.SqlClient

Partial Class Admin_catalogos_RolesAB
    Inherits System.Web.UI.Page

    Public objUsuarioEN As New clsUsuarios
    Public funcion As New funciones
    Dim strMensajeError As Object

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            If Not IsNothing(Session("USUARIO")) Then
                CargarDatos()
            Else
                Session.Abandon()
                Response.Redirect("~/Default.aspx")
            End If

        End If
    End Sub

    Private Sub CargarDatos()

        'grvRoles.DataSource = clsUsuarios.Consulta_Roles(objUsuarioEN)
        'grvRoles.DataBind()       

        Dim vId As Integer = funcion.LeerRequest("id", Request)

        If vId <> 0 Then
            objUsuarioEN.IdRol = vId

            Dim dt As DataTable
            dt = clsUsuarios.Consulta_Rol(objUsuarioEN)

            Me.txtRol.Text = dt.Rows(0).Item("cRolNombre")
            If IsDBNull(dt.Rows(0).Item("cRolDescripcion")) Then
                Me.txtDescripcion.Text = ""
            Else
                Me.txtDescripcion.Text = dt.Rows(0).Item("cRolDescripcion")
            End If

            If IsDBNull(dt.Rows(0).Item("cRolEstatus")) Then
                Me.chkactivo.Checked = False
            ElseIf dt.Rows(0).Item("cRolEstatus") = 1 Then
                Me.chkactivo.Checked = True
            ElseIf dt.Rows(0).Item("cRolEstatus") = 0 Then
                Me.chkactivo.Checked = False
            End If

            'txtEmpleado.DataBind()
            grvPermisos.DataSource = clsUsuarios.Consulta_Permiso(objUsuarioEN)
            grvPermisos.DataBind()

            Me.lblCapturo.Text = dt.Rows(0).Item("UsuCre")
            Me.lblFecCap.Text = dt.Rows(0).Item("FecCre")
            Me.lblModifico.Text = dt.Rows(0).Item("UsuMod")
            Me.lblFecMod.Text = dt.Rows(0).Item("FecMod")
        End If

        'Dim dtt As DataTable
        'dtt = clsUsuarios.Consulta_Permiso(objUsuarioEN)

        If grvPermisos.Rows.Count = 0 Then
            grvPermisos.DataSource = clsUsuarios.Llenar(objUsuarioEN)
            grvPermisos.DataBind()

        End If

        'Me.txtEmpleado.Text = vId      

    End Sub

    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Dim ban As Integer = 0
        Dim vId As Integer = funcion.LeerRequest("id", Request)

        Try
            objUsuarioEN.RolTxt = Me.txtRol.Text
            objUsuarioEN.RolDesc = Me.txtDescripcion.Text

            Dim dtu As DataTable
            objUsuarioEN.Accion = "Consulta"
            Dim u As Integer = Session("USUARIO")
            objUsuarioEN.IdUsuario = u
            dtu = clsUsuarios.Consulta_Usuarios(objUsuarioEN)

            If chkactivo.Checked = True Then
                objUsuarioEN.Activo = 1
            Else
                objUsuarioEN.Activo = 0
            End If

            If vId <> 0 Then
                objUsuarioEN.IdRol = vId
                If clsUsuarios.Consulta_Permiso(objUsuarioEN).Rows.Count = 0 Then
                    objUsuarioEN.UsuCre = dtu.Rows(0).Item(2)
                    objUsuarioEN.AccionP = "Insertar"
                Else
                    objUsuarioEN.UsuMod = dtu.Rows(0).Item(2)
                    objUsuarioEN.AccionP = "Actualizar"
                    objUsuarioEN.Accion = "Actualizar"
                End If

            Else
                objUsuarioEN.IdRol = 0
                objUsuarioEN.UsuCre = dtu.Rows(0).Item(2)
                objUsuarioEN.Accion = "Insertar"
                objUsuarioEN.AccionP = "Insertar"
            End If

            ban = clsUsuarios.InsertarRol(objUsuarioEN)

            For Each row As GridViewRow In grvPermisos.Rows

                If row.RowType = DataControlRowType.DataRow Then
                    Dim m As Integer = Convert.ToInt32(row.Cells(0).Text)
                    Dim chkCons As CheckBox = TryCast(row.Cells(2).FindControl("chkConsultar"), CheckBox)
                    Dim chkAlta As CheckBox = TryCast(row.Cells(3).FindControl("chkAgregar"), CheckBox)
                    Dim chkBaja As CheckBox = TryCast(row.Cells(4).FindControl("chkBaja"), CheckBox)
                    Dim chkMod As CheckBox = TryCast(row.Cells(5).FindControl("chkMod"), CheckBox)
                    Dim chkAdmon As CheckBox = TryCast(row.Cells(6).FindControl("chkAdmon"), CheckBox)

                    If chkCons.Checked Then
                        objUsuarioEN.cConsultar = 1
                    Else
                        objUsuarioEN.cConsultar = 0
                    End If

                    If chkAlta.Checked Then
                        objUsuarioEN.cAlta = 1
                    Else
                        objUsuarioEN.cAlta = 0
                    End If

                    If chkBaja.Checked Then
                        objUsuarioEN.cBaja = 1
                    Else
                        objUsuarioEN.cBaja = 0
                    End If

                    If chkMod.Checked Then
                        objUsuarioEN.cMod = 1
                    Else
                        objUsuarioEN.cMod = 0
                    End If

                    If chkAdmon.Checked Then
                        objUsuarioEN.cAdmon = 1
                    Else
                        objUsuarioEN.cAdmon = 0
                    End If

                    objUsuarioEN.IdMod = m
                    clsUsuarios.Inserta_Permiso(objUsuarioEN)
                End If
            Next

            'clsUsuarios.Inserta_Permiso(objUsuarioEN)

            If ban >= 0 Then
                'Limpiar()
                'lblComentario.Text = "Registro Ingresado"
                'objAlumnoEN.Nombre = ""
                'dgvClientes.DataSource = AlumnoENTIDAD.Buscar(objAlumnoEN)
                'Response.Redirect("~/catalogos/Usuarios.aspx")
                Dim script As String = "<script type='text/javascript'>" & _
                                    "window.opener.location.reload(true); window.close();" & _
                                "</script>"

                ScriptManager.RegisterStartupScript(Me, GetType(Page), "alerta", script, False)
            Else
                MsgBox(strMensajeError)
                strMensajeError = ""
            End If

        Catch ex1 As SqlException
            lblError.Text = "Ha ocurrido un error.  Datos no guardados  " & ex1.Message
        Catch ex2 As Exception
            lblError.Text = "Ha ocurrido un error.  Datos no guardados  " & ex2.Message
        End Try

    End Sub

    Protected Sub grvPermisos_RowDataBound(ByVal sender As Object, ByVal e As GridViewRowEventArgs) Handles grvPermisos.RowDataBound

        If (e.Row.RowType = DataControlRowType.DataRow) Then

            'For Each row As DataControlFieldCell In e.Row.Cells

            '    For Each control As Control In row.Controls
            '        Dim imgButton As ImageButton = TryCast(control, ImageButton)
            '    Next
            'Next

            'For Each rowItem As GridViewRow In GridView1.Rows
            Dim cmbMod As DropDownList
            Dim chkAccCons As CheckBox
            cmbMod = CType(e.Row.Cells(0).FindControl("cmbModulos"), DropDownList)
            chkAccCons = CType(e.Row.Cells(1).FindControl("chkConsultar"), CheckBox)

            'Dim ddlCountries As DropDownList = CType(e.Row.FindControl("ddlCountries"), DropDownList)
            Dim vId As Integer = funcion.LeerRequest("id", Request)

            'cmbMod.DataSource = clsUsuarios.Consulta_Modulo(objUsuarioEN)

            'cmbMod.DataTextField = "cModNombre"
            'cmbMod.DataValueField = "cModId"
            'cmbMod.DataBind()

            Dim dr As DataRowView = e.Row.DataItem
            'cmbMod.SelectedValue = dr("mModId").ToString

            'If vId <> 0 Then
            '    objUsuarioEN.IdUsuario = vId

            '    Dim dtt As DataTable
            '    dtt = clsUsuarios.Consulta_Usuarios(objUsuarioEN)

            '    Me.txtRol.Text = dtt.Rows(0).Item(9)

            '    'txtEmpleado.DataBind()
            'End If

            objUsuarioEN.IdRol = Val(vId)

            Dim dt As DataTable
            dt = clsUsuarios.Consulta_Permiso(objUsuarioEN)

            'chkAccCons.Checked = dt.Rows(0).Item(3)

            'Add Default Item in the DropDownList
            'cmbMod.Items.Insert(0, New ListItem("Seleccionar"))

            'Select the Country of Customer in DropDownList
            'Dim country As String = CType(e.Row.FindControl("lblCountry"), Label).Text
            'cmbModulos.Items.FindByValue(country).Selected = True
            'Next
        End If
    End Sub
    Protected Sub cmbModulos_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim dd As DropDownList = sender
        Dim objFila As GridViewRow = dd.Parent.Parent
        Dim Codigo As Integer = objFila.RowIndex

        Dim cmbMod As DropDownList
        cmbMod.SelectedValue = Val(grvPermisos.Rows.Item(Codigo).Cells(0).Text)

    End Sub

    'Private Sub lnkAgregar_Click(sender As Object, e As EventArgs) Handles lnkAgregar.Click

    '    Dim dt As New DataTable

    '    dt.Columns.Add("A", Type.GetType("System.String"))
    '    dt.Columns.Add("B", Type.GetType("System.String"))

    '    Dim dr As DataRow

    '    For Each rowItem As GridViewRow In grvPermisos.Rows
    '        dr = dt.NewRow()
    '        Dim cmbMod As DropDownList
    '        cmbMod = CType(rowItem.FindControl("cmbModulos"), DropDownList)
    '        Dim chkAccCons As CheckBox
    '        chkAccCons = CType(rowItem.FindControl("chkConsultar"), CheckBox)
    '        'chkAccCons = CType(rowItem.DataItem, Data.DataRowView).Item("chkConsultar")

    '        grvPermisos.DataSource = dt

    '        dr(0) = cmbMod.SelectedItem.Text
    '        dr(1) = chkAccCons.Checked


    '        dt.Rows.Add(dr)
    '    Next

    '    'dr = dt.NewRow()
    '    'dt.Rows.Add(dr)

    '    dt.AcceptChanges()
    '    grvPermisos.DataSource = dt
    '    grvPermisos.DataBind()
    'End Sub

End Class
