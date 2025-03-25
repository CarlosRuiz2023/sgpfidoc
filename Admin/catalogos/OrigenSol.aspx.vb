Imports System.Data

Partial Class Admin_catalogos_OrigenSol
    Inherits System.Web.UI.Page
    Public objUsuarioEN As New clsUsuarios
    Public objOrigen As New clsOrigen

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim permisos As Data.DataTable
        Dim AccCons As Integer
        Dim AccAlta As Integer

        If Not IsPostBack Then
            If IsNothing(Session("USUARIO")) Then
                Session.Abandon()
                Response.Redirect("~/Default.aspx")
                Exit Sub
            End If

            permisos = Lee_Permisos()

            AccCons = permisos.Rows(0).Item(2) 'Consultar
            AccAlta = permisos.Rows(0).Item(3) 'Agregar
            'Permiso consultar
            If AccCons = "0" Then
                'MsgBox("NO TIENE PERMISOS PARA ESTA OPCION", MsgBoxStyle.Information)
                Response.Write("<script>alert('NO TIENE PERMISOS PARA ESTA OPCION'); window.location.href='../../inicio.aspx';</script>")
                'Response.Redirect("../../forms/Default.aspx")
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

        'btnAgregar.Attributes.Add("onmouseover", "this.style.cursor='pointer'")
    End Sub

    Protected Sub CargarDatos()
        Dim dt As DataTable = New DataTable
        Dim objList As New ListItem("", 0)
        objOrigen.Accion = "Todos"
        clsOrigen.Consulta(objOrigen, cmbOrigen.DataSource)
        cmbOrigen.DataValueField = "cOrigId"
        cmbOrigen.DataTextField = "cOrigNombre"
        cmbOrigen.DataBind()
        cmbOrigen.Items.Insert(0, objList)
        clsOrigen.Consulta(objOrigen, grvOrigen.DataSource)
        grvOrigen.DataBind()

        Dim ban As Boolean = clsOrigen.Consulta(objOrigen, dt)
        Dim t2 As Integer = dt.Rows.Count.ToString()
        lblTotalRegistros.Text = t2
    End Sub

    Private Function Lee_Permisos()
        Dim dt As DataTable
        'Dim cadena As String
        Dim objUsuarioEn As New clsUsuarios
        'donde el primer parametro es el usuario y el segundo es la opcion del catalogo de "Usuarios"

        dt = objUsuarioEn.GetPermisos(Session("IDUSUARIO"), 16)
        'cadena = dt.Rows(0).Item(2)

        objUsuarioEn = Nothing
        Return dt
    End Function

    'Protected Sub btnAgregar_Click(sender As Object, e As EventArgs) Handles btnAgregar.Click
    '    Response.Redirect("~/catalogos/UsuariosA.aspx")
    'End Sub
    Protected Sub imageButtonClick(sender As Object, e As EventArgs)
        Dim imageButton As ImageButton = CType(sender, ImageButton)
        Dim tableCell As TableCell = imageButton.Parent
        Dim row As GridViewRow = tableCell.Parent
        grvOrigen.SelectedIndex = row.RowIndex
        Response.Redirect("~/catalogos/ModulosAB.aspx")
    End Sub

    Protected Sub botones(sender As Object, e As CommandEventArgs)
        If e.CommandName = "Eliminar" Then
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
            objOrigen.Accion = "Eliminar"
            objOrigen.IdOrigen = index
            Dim ban As Integer = clsOrigen.Insertar(objOrigen)
            CargarDatos()
        End If

    End Sub

    Protected Sub btnBuscar_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles btnBuscar.Click
        'objUsuarioEN.Nombre = Me.txtBuscar.Text
        objOrigen.IdOrigen = Me.cmbOrigen.SelectedValue
        'objUsuarioEN.Nombre = Me.txtBuscar.Text
        objOrigen.Accion = "Buscar"

        clsOrigen.Consulta(objOrigen, grvOrigen.DataSource)
        grvOrigen.DataBind()
    End Sub

    Private Sub grvModulos_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grvOrigen.RowDataBound
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
            usu = CType(e.Row.Cells(0).FindControl("cOrigId"), Label)

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
            AccEli = permisos.Rows(0).Item(4)
            If AccEli = 0 Then
                'imgEli.ImageUrl = "~/imagenes/candado.png"
                'imgEli.ImageUrl. = "../../imagenes/candado.png"
            ElseIf AccEli = 1 Then
                'imgEli.Attributes.Add("onmouseover", "this.style.cursor='pointer'")
                'imgEli.Attributes.Add("onclick", "openph(" & i & ")")

            End If
        End If
    End Sub

End Class
