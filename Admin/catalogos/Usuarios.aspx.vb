Imports System.Data

Partial Class Admin_catalogos_Usuarios
    Inherits System.Web.UI.Page
    
    Public objUsuarioEN As New clsUsuarios
    
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
        'CargarDatos()
        
    End Sub
    
    Private Function Lee_Permisos()
        Dim dt As Data.DataTable
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
        cmbRol.DataSource = clsUsuarios.Consulta_Rol(objUsuarioEN)
        cmbRol.DataValueField = "cRolId"
        cmbRol.DataTextField = "cRolNombre"
        cmbRol.DataBind()
        
        cmbRol.Items.Insert(0, objList)
        grvUsuarios.DataSource = clsUsuarios.Consulta_Usuarios(objUsuarioEN)
        grvUsuarios.DataBind()
        
        dt = clsUsuarios.Consulta_Usuarios(objUsuarioEN)
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
        grvUsuarios.SelectedIndex = row.RowIndex
        
        Response.Redirect("~/Admin/catalogos/UsuariosA.aspx")
    End Sub
    
    Protected Sub botones(sender As Object, e As CommandEventArgs)
        If e.CommandName = "Eliminar" Then
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
            
            'Dim row As GridViewRow = grvUsuarios.Rows(index)
            
            'Response.Redirect("~/catalogos/UsuariosA.aspx?id=" & index)
            Dim url As String = "UsuariosAB.aspx"
            ClientScript.RegisterStartupScript(Me.GetType(), "OpenWin", "<script>openNewWin('" & url & "')</script>")
        End If
        
        If e.CommandName = "Editar" Then
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
            'Dim strscript As String = "window.open('UsuariosA.aspx');"
            'ClientScript.RegisterClientScriptBlock(Me.GetType(), "strScript", strscript, True)
            'Dim row As GridViewRow = grvUsuarios.Rows(index)
            
            'Response.Redirect("~/catalogos/UsuariosA.aspx?id=" & index)
            Dim url As String = "UsuariosAB.aspx?id=" & index
            ClientScript.RegisterStartupScript(Me.GetType(), "OpenWin", "<script>openNewWin('" & url & "')</script>")
            
        End If
    End Sub
    
    Protected Sub grvUsuarios_PageIndexChanging(sender As Object, e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles grvUsuarios.PageIndexChanging
        grvUsuarios.PageIndex = e.NewPageIndex
        'grvUsuarios.DataBind()
        CargarDatos()
    End Sub
    
    Protected Sub btnBuscar2_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles btnBuscar2.Click
        objUsuarioEN.Nombre = Me.txtBuscar.Text
        objUsuarioEN.IdRol = Me.cmbRol.SelectedValue
        objUsuarioEN.Accion = "Buscar"
        grvUsuarios.DataSource = clsUsuarios.Buscar_Usuarios(objUsuarioEN)
        grvUsuarios.DataBind()
    End Sub
    
    Private Sub grvUsuarios_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grvUsuarios.RowDataBound
        Dim permisos As Data.DataTable
        Dim AccCons As Integer
        Dim AccEli As Integer
        
        If (e.Row.RowType = DataControlRowType.DataRow) Then
            Dim imgMod As Image
            Dim imgEli As Image
            imgMod = CType(e.Row.Cells(0).FindControl("Editar"), Image)
            imgEli = CType(e.Row.Cells(0).FindControl("Eliminar"), Image)
            
            permisos = Lee_Permisos()
            
            Dim usu As Label
            usu = CType(e.Row.Cells(0).FindControl("mUsuId"), Label)
            
            Dim i As Integer = usu.Text
            'Consultar
            AccCons = permisos.Rows(0).Item(5)
            If AccCons = 0 Then
                imgMod.ImageUrl = "../../Admin/imagenes/candado.png"
            ElseIf AccCons = 1 Then
                imgMod.Attributes.Add("onmouseover", "this.style.cursor='pointer'")
                imgMod.Attributes.Add("onclick", "openph(" & i & ")")
            End If
            
            'Eliminar
            AccEli = permisos.Rows(0).Item(4)
            If AccEli = 0 Then
                imgEli.ImageUrl = "../../Admin/imagenes/candado.png"
            ElseIf AccEli = 1 Then
                imgEli.Attributes.Add("onmouseover", "this.style.cursor='pointer'")
                imgEli.Attributes.Add("onclick", "openph(" & i & ")")
            End If
        End If
    End Sub
End Class