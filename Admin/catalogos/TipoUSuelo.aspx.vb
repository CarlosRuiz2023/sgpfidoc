Imports System.Data

Partial Class Admin_catalogos_TipoUSuelo
    Inherits System.Web.UI.Page
    Public objUsuarioEN As New clsUsuarios
    Public objTiposS As New clsTiposS

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim permisos As DataTable
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

    Protected Sub CargarDatos()
        Dim dt As DataTable

        objTiposS.Accion = "Todos"

        Dim objList As New ListItem("", 0)
        cmbTUSuelo.DataSource = clsTiposS.Consulta_TiposS(objTiposS)
        cmbTUSuelo.DataValueField = "cTUSueId"
        cmbTUSuelo.DataTextField = "cTUSueNombre"
        cmbTUSuelo.DataBind()
        cmbTUSuelo.Items.Insert(0, objList)
        grvTiposS.DataSource = clsTiposS.Consulta_TiposS(objTiposS)
        grvTiposS.DataBind()

        dt = clsTiposS.Consulta_TiposS(objTiposS)
        Dim t2 As Integer = dt.Rows.Count.ToString()
        lblTotalRegistros.Text = t2
    End Sub

    Private Function Lee_Permisos()
        Dim dt As DataTable
        'Dim cadena As String
        Dim objUsuarioEn As New clsUsuarios
        'donde el primer parametro es el usuario y el segundo es la opcion del catalogo de "Usuarios"

        dt = objUsuarioEn.GetPermisos(Session("IDUSUARIO"), 14)
        'cadena = dt.Rows(0).Item(2)

        objUsuarioEn = Nothing
        Return dt
    End Function

    Private Sub grvTiposS_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grvTiposS.RowDataBound
        Dim permisos As DataTable
        Dim AccCons As Integer
        Dim AccEli As Integer

        If (e.Row.RowType = DataControlRowType.DataRow) Then
            Dim imgMod As Image
            Dim imgEli As Image
            imgMod = CType(e.Row.Cells(0).FindControl("Editar"), Image)
            imgEli = CType(e.Row.Cells(0).FindControl("Eliminar"), Image)

            permisos = Lee_Permisos()

            Dim usu As Label
            usu = CType(e.Row.Cells(0).FindControl("cTUSueId"), Label)

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
                imgEli.ImageUrl = "../../imagenes/candado.png"
            ElseIf AccEli = 1 Then
                imgEli.Attributes.Add("onmouseover", "this.style.cursor='pointer'")
                imgEli.Attributes.Add("onclick", "openph(" & i & ")")
            End If
        End If
    End Sub
End Class
