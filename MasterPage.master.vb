Imports System.Data
Imports System.Collections.Generic

Partial Class MasterPage
    Inherits System.Web.UI.MasterPage
    Public objUsuarios As New clsUsuarios
    Public cadena As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim dt As DataTable
        If Not IsNothing(Session("USUARIO")) Then
            objUsuarios.IdUsuario = Session("USUARIO")
            dt = clsUsuarios.Consulta_UsuariosPsql(objUsuarios)
            lblUsuario.Text = "Bienvenid@:" & dt.Rows(0).Item("musunombrer").ToString() & ":" & dt.Rows(0).Item("musuidr").ToString()
        Else
            lblUsuario.Text = ""
            Session.Abandon()
            Response.Redirect("~/Default.aspx")
        End If
    End Sub

    Protected Sub lnkCerrar_Click(sender As Object, e As EventArgs) Handles lnkCerrar.Click
        Session.Abandon()
        Response.Redirect("~/Default.aspx")
    End Sub

    Protected Sub Menu2_MenuItemClick(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.MenuEventArgs) Handles Menu2.MenuItemClick
        Dim opc As String = ""
        Dim ventana As String = ""
        Dim aux As String = ""
        Dim usuario() As String
        aux = lblUsuario.Text
        usuario = aux.Split(":")

        If (e.Item.Text = "OIDs" Or e.Item.Text = "Obras" Or e.Item.Text = "Cooperadores" Or e.Item.Text = "DETERMINANTES" Or e.Item.Text = "REQUERIMIENTOS" Or e.Item.Text = "Catalogos" Or e.Item.Text = "UTILERIAS" Or e.Item.Text = "ASAMBLEAS" Or e.Item.Text = "Contratistas" Or e.Item.Text = "COMITES") Then
            Response.Redirect("~/Admin/Inicio.aspx")
        Else

            If (e.Item.Text = "Adeudos para generar Carta de Término de Obra") Then
                opc = "&opcmenu=1"
                ventana = "determinantes"
            End If
            If (e.Item.Text = "Adeudos para notificar Carta de Término de Obra") Then
                opc = "&opcmenu=2"
                ventana = "determinantes"
            End If
            If (e.Item.Text = "Adeudos para Determinar") Then
                opc = "&opcmenu=3"
                ventana = "determinantes"
            End If
            If (e.Item.Text = "Determinantes generados sin entregar") Then
                opc = "&opcmenu=4"
                ventana = "determinantes"
            End If
            If (e.Item.Text = "Determinantes sin notificar") Then
                opc = "&opcmenu=5"
                ventana = "determinantes"
            End If
            If (e.Item.Text = "Determinantes notificados") Then
                opc = "&opcmenu=6"
                ventana = "determinantes"
            End If
            If (e.Item.Text = "Requerimientos Generados") Then
                opc = "&opcmenu=7"
                ventana = "requerimientos"
            End If
            If (e.Item.Text = "Consultar Poligonos de Obra") Then
                opc = ""
                ventana = "pobra"
            End If
            If (e.Item.Text = "Calles Desarrollo Urbano") Then
                opc = ""
                ventana = "calle_du"
            End If
            If (e.Item.Text = "Consultar Obra") Then
                opc = ""
                ventana = "obra"
            End If
            If (e.Item.Text = "Act. Costo Obra") Then
                opc = ""
                ventana = "obras_vencidas_rec"
            End If

            If (e.Item.Text = "Consultar Cooperador") Then
                opc = ""
                ventana = "coop"
            End If
            If (e.Item.Text = "Gestión Contratistas") Then
                opc = ""
                ventana = "contratista"
            End If
            If (e.Item.Text = "Contratos") Then
                opc = ""
                ventana = "contrato"
            End If
            If (e.Item.Text = "Obra-->Contratos") Then
                If (usuario(2) = "46" Or usuario(2) = "95" Or usuario(2) = "47") Then
                    opc = ""
                    ventana = "obra_contrato"
                Else
                    ventana = ""
                End If
            End If
            If (e.Item.Text = "Gestión Comités") Then
                opc = ""
                ventana = "comite"
            End If
            If (e.Item.Text = "Acuerdos por Comité") Then
                opc = ""
                ventana = "comite_acuerdo"
            End If
            If (e.Item.Text = "Usuarios") Then
                opc = "&opcmenu=8"
                ventana = "usuarios"
            End If

            If (e.Item.Text = "Roles de Usuario") Then
                If (usuario(2) = "46") Then
                    opc = ""
                    ventana = "roles"
                Else
                    ventana = ""
                End If
            End If
            If (e.Item.Text = "Tipo Recurso Obra") Then 
                If (usuario(2) = "46") Then
                    opc = ""
                    ventana = "tipo_recurso_obra"
                Else
                    ventana = ""
                End If
            End If
            If (e.Item.Text = "Tipo Asamblea") Then
                If (usuario(2) = "46") Then
                    opc = ""
                    ventana = "tasamblea"
                Else
                    ventana = ""
                End If
            End If
            If (e.Item.Text = "Tipo Comité Técnico") Then
                If (usuario(2) = "46") Then
                    opc = ""
                    ventana = "tcomite"
                Else
                    ventana = ""
                End If
            End If
            If (e.Item.Text = "Tipo Anexo Contrato") Then
                If (usuario(2) = "46") Then
                    opc = ""
                    ventana = "tanexo_contrato"
                Else
                    ventana = ""
                End If
            End If
            If (e.Item.Text = "Tipo Asignacion") Then
                If (usuario(2) = "46") Then
                    opc = ""
                    ventana = "tasignacion"
                Else
                    ventana = ""
                End If
            End If
            If (e.Item.Text = "Formato Comité Técnico") Then
                If (usuario(2) = "46") Then
                    opc = ""
                    ventana = "fcomite"
                Else
                    ventana = ""
                End If
            End If
            If (e.Item.Text = "Estatus Asamblea") Then
                If (usuario(2) = "46") Then
                    opc = ""
                    ventana = "estatus_asamblea"
                Else
                    ventana = ""
                End If
            End If
            If (e.Item.Text = "Acciones") Then
                If (usuario(2) = "46") Then
                    opc = ""
                    ventana = "accion"
                Else
                    ventana = ""
                End If
            End If

            If (e.Item.Text = "Tareas") Then
                If (usuario(2) = "46") Then
                    opc = ""
                    ventana = "tarea"
                Else
                    ventana = ""
                End If
            End If


            If (e.Item.Text = "Actualizar Pagos") Then
                opc = ""
                ventana = "pagos"
                'ventana = ""
            End If

            If (e.Item.Text = "Reportes Generales") Then
                opc = ""
                ventana = "exp_coops_txt"
            End If

            If (e.Item.Text = "Reporte Obras") Then
                opc = ""
                ventana = "reportes_obras"
            End If

            If (e.Item.Text = "Consultar Asambleas") Then
                opc = ""
                ventana = "asamblea"
            End If

            If (e.Item.Text = "Cargar CV") Then
                opc = ""
                ventana = "cv"
            End If

            If (e.Item.Text = "Cooperadores CV") Then
                opc = ""
                ventana = "coop_cv"
            End If

            If (e.Item.Text = "Cartera Vencida Final") Then
                opc = ""
                ventana = "cartera_vencida"
            End If
            If (e.Item.Text = "Transf. Pagos") Then
                If (usuario(2) = "46" Or usuario(2) = "109" Or usuario(2) = "21") Then
                    opc = ""
                    ventana = "trans_pagos"
                Else
                    ventana = ""
                End If
            End If
            If (ventana <> "") Then
                Response.Redirect("~/Admin/procesos/consultar_" & ventana & ".aspx?" & opc & "&idusu=" & usuario(2))
            End If
        End If

    End Sub

End Class