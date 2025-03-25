Imports System.Data

Partial Class Admin_catalogos_EstatusSol
    Inherits System.Web.UI.Page

    Public objUsuarioEN As New clsUsuarios
    Public objEstatus As New clsEstatusSol

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim permisos As DataTable
        Dim AccCons As Integer
        Dim AccAlta As Integer

        If Not IsPostBack Then
            If IsNothing(Session("USUARIO")) Then
                Session.Abandon()
                Response.Redirect("~/login.aspx")
                Exit Sub
            End If

            permisos = Lee_Permisos()

            AccCons = permisos.Rows(0).Item(2) 'Consultar
            AccAlta = permisos.Rows(0).Item(3) 'Agregar
            'Permiso consultar
            If AccCons = "0" Then
                'MsgBox("NO TIENE PERMISOS PARA ESTA OPCION", MsgBoxStyle.Information)
                Response.Write("<script>alert('NO TIENE PERMISOS PARA ESTA OPCION'); window.location.href='../../inicio.aspx';</script>")
                'Response.Redirect("../../forms/login.aspx")
                Exit Sub
            End If

            If AccAlta = 0 Then
                Agregar.Visible = False
            ElseIf AccAlta = 1 Then
                Agregar.Attributes.Add("onmouseover", "this.style.cursor='pointer'")
                Agregar.Attributes.Add("onclick", "openph(0)")
            End If

            CargarDatos()
        End If
        'CargarDatos()

    End Sub

    Private Function Lee_Permisos()
        Dim dt As DataTable
        'Dim cadena As String
        Dim objUsuarioEn As New clsUsuarios

        'donde el primer parametro es el usuario y el segundo es la opcion del catalogo de "Usuarios"

        dt = objUsuarioEn.GetPermisos(Session("IDUSUARIO"), 1)

        'cadena = dt.Rows(0).Item(2)

        objUsuarioEn = Nothing
        Return dt
    End Function

    Private Sub CargarDatos()
        Dim dt As DataTable
        Dim objList As New ListItem("", 0)

        objEstatus.Accion = "Todos"
        cmbEstatus.DataSource = clsEstatusSol.Consulta_Estatus(objEstatus)
        cmbEstatus.DataValueField = "cEstId"
        cmbEstatus.DataTextField = "cEstDescripcion"
        cmbEstatus.DataBind()

        cmbEstatus.Items.Insert(0, objList)
        grvEstatus.DataSource = clsEstatusSol.Consulta_Estatus(objEstatus)
        grvEstatus.DataBind()

        dt = clsEstatusSol.Consulta_Estatus(objEstatus)
        Dim t2 As Integer = dt.Rows.Count.ToString()
        lblTotalRegistros.Text = t2
    End Sub

    'Protected Sub btnAgregar_Click(sender As Object, e As EventArgs) Handles btnAgregar.Click
    '    Response.Redirect("~/catalogos/UsuariosA.aspx")
    'End Sub

    Protected Sub imageButtonClick(sender As Object, e As EventArgs)
        Dim imageButton As ImageButton = CType(sender, ImageButton)
        Dim tableCell As TableCell = imageButton.Parent
        Dim row As GridViewRow = tableCell.Parent
        grvEstatus.SelectedIndex = row.RowIndex

        Response.Redirect("~/catalogos/UsuariosA.aspx")

    End Sub


    Protected Sub botones(sender As Object, e As CommandEventArgs)
        If e.CommandName = "Eliminar" Then
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
            objEstatus.Accion = "Eliminar"
            objEstatus.IdEstatus = index
            Dim ban As Integer = clsEstatusSol.Insertar(objEstatus)
            CargarDatos()
        End If

    End Sub

    Protected Sub btnOpenPop_Click(ByVal sender As Object, ByVal e As EventArgs)

        Dim url As String = "http://www.dotnetcurry.com"

        ClientScript.RegisterStartupScript(Me.GetType(), "OpenWin", "<script>openNewWin('" & url & "')</script>")

    End Sub

    Protected Sub grvUsuarios_PageIndexChanging(sender As Object, e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles grvEstatus.PageIndexChanging
        grvEstatus.PageIndex = e.NewPageIndex
        grvEstatus.DataBind()
    End Sub


    Protected Sub btnBuscar2_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles btnBuscar2.Click
        'objUsuarioEN.Nombre = Me.txtBuscar.Text
        objEstatus.IdEstatus = cmbEstatus.SelectedValue
        objEstatus.Accion = "Buscar"

        grvEstatus.DataSource = clsEstatusSol.Consulta_Estatus(objEstatus)
        grvEstatus.DataBind()
    End Sub

    Private Sub grvUsuarios_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grvEstatus.RowDataBound
        Dim permisos As DataTable
        Dim AccCons As Integer
        Dim AccEli As Integer


        If (e.Row.RowType = DataControlRowType.DataRow) Then
            Dim imgMod As Image
            Dim imgEli As ImageButton
            imgMod = CType(e.Row.Cells(0).FindControl("Editar"), Image)
            imgEli = CType(e.Row.Cells(0).FindControl("Eliminar"), ImageButton)

            permisos = Lee_Permisos()

            Dim usu As Label
            usu = CType(e.Row.Cells(0).FindControl("cEstId"), Label)

            Dim i As Integer = usu.Text
            'Consultar
            AccCons = permisos.Rows(0).Item(5)
            If AccCons = 0 Then
                imgMod.ImageUrl = "../../imagenes/candado.png"
            ElseIf AccCons = 1 Then
                imgMod.Attributes.Add("onmouseover", "this.style.cursor='pointer'")
                imgMod.Attributes.Add("onclick", "openph(" & i & ")")
            End If

            'Eliminar
            'AccEli = permisos.Rows(0).Item(4)
            'If AccEli = 0 Then
            '    'imgEli.ImageUrl = "../../imagenes/candado.png"

            'ElseIf AccEli = 1 Then
            '    'imgEli.ImageUrl = "../../imagenes/candado.png"
            '    'imgEli.Attributes.Add("onmouseover", "this.style.cursor='pointer'")
            '    'imgEli.Attributes.Add("onclick", "openph(" & i & ")")
            'End If
        End If
    End Sub

End Class
