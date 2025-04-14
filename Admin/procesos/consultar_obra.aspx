<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterPage.master" CodeFile="consultar_obra.aspx.vb" Inherits="Admin_procesos_consultar_obra" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">    

<script type="text/javascript" src="../js/consultar_obra.js"></script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server"> 
    <div id="bodegadatos"></div>
         
<label>Nombre de Calle:</label><input type="text" name="calle" id="txtnomcalle" style="width:250px" maxlength ="120"/><br/><br/>        
<label>ClvObra (SGPFIDOC):</label><input type="text" name="obr_clv_int" id="txtclvsgp" style="width:250px" maxlength ="10"/><br/><br/>        
<label>Obra (SIFIDOC):</label><input type="text" name="obra" id="txtnumobra" style="width:250px" maxlength="10"/>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="buscar_obra"><== Buscar obra ==></a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="alta_obra"><== Alta obra ==></a><br/><br/>
 
<table id="grid"></table>
<div id="pager"></div>&nbsp       
 
<div id="boxes">        
    <div id="dialogoobraS" class="window"> 
       <div id="tituloobraS"> 
         <p style="text-align:center">GESTION DE OBRA</p>
         Usuario: <label for="idusu" id="lblidusu"></label><br/> 
         IdObra: <label for="obr_clv_int" id="lblobr_clv_int"></label><br/> 
         Acción:<label for="accion" id="lblaccionobraS"></label><br/> 
       </div>
       <div class="datos" id="bodyobraS">      
          <br/>             
          <br/>             
          <label for="name" id="lblubic">*OID:</label><select name="ubicobra" id="lstubicobra" onchange="consulta_oid(this.value)"></select><br/><br/>
          &nbsp&nbsp&nbsp&nbsp&nbsp<label for="name" id="lblcalle">*CALLE:</label><br/><br/>
          &nbsp&nbsp&nbsp&nbsp&nbsp<label for="name" id="lblcolonia">*COLONIA:</label><br/><br/> 
          &nbsp&nbsp&nbsp&nbsp&nbsp<label for="name" id="lbletiquetatramo">*TRAMO:</label><br/><br/>
          &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<label for="name" id="lbltramolim1">*Limite 1 del TRAMO:</label><br/><br/>
          &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<label for="name" id="lbltramolim2">*Limite 2 del TRAMO:</label><br/><br/>                
         

          <label for="name" id="lbltipoobra">*Tipo de Obra:</label><select name="tipoobra" id="lsttipoobra"></select><br/><br/>
          <label for="name" id="lblprograma">*Programa (SGPFIDOC):</label><select name="programa" id="lstprograma"></select><br/><br/>
          <label for="name">*Costo x Mto. Lineal:</label><input type="text" name="costoxmto" id="txtcostoxmto" class="numbersOnly" size="6" maxlength="8"/><br/><br/>
          <label for="name" id="lblfecinipag">*Fecha de Inicio de Pagos (dd/mm/aaaa):</label><input type="text" name="fecinipag" id="txtfecinipag" size="10" maxlength="10" onkeyup = "this.value=formateafecha(this.value);" onblur="FechaVencPagos(txtnumpag.value)"/>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<label for="name" id="lblnumpagos">*Número de Pagos:</label><input type="text"  size="6" maxlength="5" id="txtnumpag" name="numpag" onkeyup="FechaVencPagos(this.value)"/><br/><br/>
          <label for="name" id="llfecven1">Fecha de vencimiento de pagos (dd/mm/aaaa):</label><label for="name" id="lblfecvenc"></label><br/><br/>          
          
          <label for="name" id="lblestatusobra">Estatus de Obra:</label><select name="estatusobra" id="lstestatusobra"></select><br/><br/>
       </div>                  
       <div class="botonesA" id="botonesC">
          <p style="text-align:right"><a href="#" class ="posicion_boton_accion_obraS">Aceptar</a>&nbsp&nbsp&nbsp<a href="#" class="posicion_boton_cancelar_obraS">Cancelar</a></p>                
       </div>
    </div>     
    <div id="dialogoobraproc" class="window">        
       <table class="t_modulo">
          <tbody> 
              <tr>
                  <td colspan="6" class="titulo_modulo">CAMBIAR DE ESTATUS DE OBRA DE  PROCESO</td>
              </tr>   
              <tr>
                  <td class="f">CALLE:</td>
                  <td class="e" colspan="5"><label id="lblnomcalle"/></td>
              </tr>
              <tr>
                  <td class="f">COLONIA:</td>
                  <td class="e" colspan="5"><label id="lblnomcolonia"/></td>
              </tr>
              <tr>
                  <td class="f">TRAMO:</td>
                  <td class="e" colspan="5"><label id="lblnomtramo"/></td>
              </tr>
              <tr>
                  <td class="f">Programa:</td>
                  <td class="e"><label id="lblprog"/></td>
                  <td class="f">Estatus Obra:</td>
                  <td class="e"><label id="lblestatus_obra"/></td>
                  <td  class="f">Tipo de Obra:</td>
                  <td  class="e"><label id="lbltipo_obra"/></td>
              </tr>
              <tr>
                  <td class="f">Fecha Inicio Promoción:</td>
                  <td class="e"><label id="lblfecinirec"/></td>
                  <td class="f">Fecha Fin Recaudación:</td>
                  <td class="e"><label id="lblfecfinrec"/></td>
                  <td  class="f">*Fecha Inicio Proceso:</td>
                  <td  class="e"><input class="dato_captura" type="text" name="feciniproc" id="txtfeciniproc" size="10" maxlength="10"  onkeyup = "this.value=formateafecha(this.value);"/></td>
              </tr>
              <tr>
                  <td  class="f">*Gastos Administrativos:</td>
                  <td  class="e" colspan="2"><input class="dato_captura_float" type="text" name="gastos_admvos" id="txtgastos_admvos"   size="10" maxlength="10"/></td>                  
                  <td  class="f">*Tipo Recurso:</td>
                  <td  class="e" colspan="2"><select class="select_captura" name="tipo_recurso" id="lsttipo_recurso"></select></td>                   
              </tr>
              <tr>
                  <td  class="f" colspan="2">*No. Contrato:</td>
                  <td  colspan="2"><select class="select_captura" name="num_contrato" id="lstcontratos"></select></td> 
                  <td  class="boton_dialog" colspan="2"><a href="#" class ="asignar_contrato">>>></a></td>
                                
              </tr>
              <tr>
                  <td colspan="6">
                      <table id="grid_contratos"></table>
                      <div id="pager_id_contrato"></div>                      
                  </td>
              </tr>
              <tr class="renglon_sistema">                    
                  <td>oid:</td>
                  <td  class="columna_sistema"><label id="lbloid_proc"/></td>
                  <td>obr_clv_int:</td>
                  <td  class="columna_sistema"><label id="lblobr_clv_int_proc"/></td>
                  <td>idusu:</td>
                  <td  class="columna_sistema"><label id="lblidusu_proc"/></td>                  
              </tr>
              <tr class="renglon_sistema">
                  <td>obra_s:</td>
                  <td class="columna_sistema"><label id="lblobra_s"/></td>
                  <td>Cuenta Contable:</td>
                  <td class="columna_sistema"><label id="lblctacontable_proc"/></td>
                  <td>ACCION:</td>
                  <td class="columna_sistema"><label id="lblaccion_proc"/></td>                  
              </tr>   
              <tr>                               
                  <td  colspan="3" class="boton_dialog"><a href="#" class ="posicion_boton_accion_obra_proc">ACEPTAR</a></td>
                  <td  colspan="3" class="boton_dialog"><a href="#" class ="posicion_boton_cancelar_obra_proc">CANCELAR</a></td>
              </tr>
          </tbody>
       </table>
    </div>     
    <div id="dialogoobrajur1" class="window"> 
       <div id="tituloobra_jur1"> 
         <p style="text-align:center">PROCESO JURIDICO DE OBRA</p>
         Usuario: <label for="idusu" id="lblusu_jur1"></label><br/> 
         oid: <label for="oid" id="lbloid_jur1"></label><br/> 
         IdObra_int: <label for="obr_clv_int" id="lbl_obr_int_jur1"></label><br/> 
         IdObra_txt: <label for="obr_clv" id="lbl_obr_int_txt_jur1"></label><br/>                   
         Estatus Obra_Actual:<label for="est_act" id="lblestatus_obr_jur1"></label><br/>  
         Acción:<label for="accion" id="lblaccion_obr_jur1"></label><br/> 
       </div>
       <div class="datos" id="bodyObra_jur1">          
          &nbsp&nbsp&nbsp&nbsp&nbsp<label for="name" id="lbljur1">*Fecha de Publicación 1:</label><input type="text" name="fecpub1" id="txtfecpub1" size="10" maxlength="10" onkeyup = "this.value=formateafecha(this.value);"/><br/><br/>          
          &nbsp&nbsp&nbsp&nbsp&nbsp<label for="name" id="lbljur2">*Evidencia de Publicación 1:</label><input type="file" name="evidpub1" id="evidpub1"/>&nbsp&nbsp<a href="#" id="file_evidpub1" class="verarchivo_file_evidpub1"></a><br/><br/>           
          &nbsp&nbsp&nbsp&nbsp&nbsp<label for="name" id="lbljur3">*Fecha de Publicación 2:</label><input type="text" name="fecpub2" id="txtfecpub2" size="10" maxlength="10" onkeyup = "this.value=formateafecha(this.value);"/><br/><br/>
          &nbsp&nbsp&nbsp&nbsp&nbsp<label for="name" id="lbljur4">*Evidencia de Publicación 2:</label><input type="file" name="evidpub2" id="evidpub2"/>&nbsp&nbsp<a href="#" id="file_evidpub2" class="verarchivo_file_evidpub2"></a><br/><br/>
          &nbsp&nbsp&nbsp&nbsp&nbsp<label for="name" id="lbljur5">*Costo de la Obra:</label><input type="text" name="costo_obra" id="txtcosto_obra" size="15" maxlength="15" class="numbersOnly"/><br/><br/>          
          &nbsp&nbsp&nbsp&nbsp&nbsp<label for="name" id="lbljur6">*Naturaleza de la Obra:</label><br/><br/>
          &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<label><input type="checkbox" id="chkBanq" name="Banquetas"/>Banquetas y guarniciones.</label><br/>
          &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<label><input type="checkbox" id="chkPav" name="Pavimento"/>Pavimento.</label><br/>
          &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<label><input type="checkbox" id="chkAtarj" name="Atarjea"/>Atarjeas.</label><br/>
          &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<label><input type="checkbox" id="chkRed" name="Redes"/>Instalación de redes de distribución.</label><br/>
          &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<label><input type="checkbox" id="chkAlum" name="Alumbrado"/>Alumbrado público.</label><br/>
          &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<label><input type="checkbox" id="chkDren" name="Drenaje"/>Instralación de drenaje.</label><br/>
          &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<label><input type="checkbox" id="chkVias" name="Vias"/>Apertura de nuevas vías públicas.</label><br/>
          &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<label><input type="checkbox" id="chkJard" name="Jardines"/>Jardines y obras de equipamiento urbano.</label><br/>
       </div>                  
       <div class="botonesA" id="botones_jur1">
          <p style="text-align:right"><a href="#" class ="posicion_boton_accion_obra_jur1">Aceptar</a>&nbsp&nbsp&nbsp<a href="#" class="posicion_boton_cancelar_obra_jur1">Cancelar</a></p>                
       </div>
    </div>             
    <div id="dialogo_obrterm" class="window">        
       <table class="t_modulo">
          <tbody> 
              <tr>
                  <td colspan="4" class="titulo_modulo">CAMBIAR ESTATUS DE PROCESO --> TERMINADA VENCIDA</td>
              </tr>   
              <tr>
                  <td class="f">CALLE:</td>
                  <td colspan="3" class="e"><label id="lblcalle_obra_term"/></td>
              </tr>
              <tr>
                  <td class="f">COLONIA:</td>
                  <td colspan="3" class="e"><label id="lblcolonia_obra_term"/></td>
              </tr>
              <tr>
                  <td class="f">TRAMO:</td>
                  <td colspan="3" class="e"><label id="lbltramo_obra_term"/></td>
              </tr>              
              <tr>              
                  <td  class="f">Fecha Inicio de Proceso:</td>
                  <td  class="e"><label id="lblfeciniproc_obra_term"/></td>
                  <td  class="f">*Fecha Terminada Vencida:</td>
                  <td  class="e"><label id="lblfecha_inicio_cobranza_capt"/></td>                  
              </tr>
              <tr>                  
                  <td colspan="6">
                      <table id="grid_contrato_anexos"></table>
                      <div id="pager_contrato_anexos"></div>                      
                  </td>                  
              </tr>              
              <tr class="renglon_sistema">                    
                  <td>oid:</td>
                  <td  class="columna_sistema"><label id="lbloid_obra_term"/></td>
                  <td>obr_clv_int:</td>
                  <td  class="columna_sistema"><label id="lblobr_clv_int_obra_term"/></td>                  
              </tr>              
              <tr class="renglon_sistema">
                  <td>obra_s:</td>
                  <td class="columna_sistema"><label id="lblobra_s_obra_term"/></td>
                  <td>IdTipoRecurso:</td>
                  <td class="columna_sistema"><label id="lblid_tipo_recurso"/></td>                  
              </tr>
              <tr class="renglon_sistema">
                  <td>idusu:</td>
                  <td  class="columna_sistema"><label id="lblidusu_obra_term"/></td>                  
                  <td>accion:</td>
                  <td class="columna_sistema"><label id="lblaccion_obra_term"/></td>                  
              </tr>   
              <tr>                               
                  <td  class="boton_dialog" colspan="2"><a href="#" class ="posicion_boton_accion_obra_term">ACEPTAR</a></td>
                  <td  class="boton_dialog" colspan="2"><a href="#" class ="posicion_boton_cancelar_obra_term">CANCELAR</a></td>
              </tr>
          </tbody>
       </table>
    </div>     
        
    <div id="dialogofichapagomes" class="window"> 
       <div id="titulofichapagomes"> 
         <p style="text-align:center">FICHAS DE PAGO MENSUALES</p>
         Clave de Obra:<label for="obr_clv_int" id="lblobrclvint_x"></label><br/><br/>
         Clave de Obra (SIFIDOC):<label for="obr_clv_int_s" id="lblobrclv_s"></label><br/><br/>
       </div>
       <div class="datos" id="body_fichapagomes">                     
           Periodo de Recaudación:&nbsp&nbsp&nbsp<label for="fecinipag_x" id="lblfecinipag_x"></label>&nbsp&nbsp&nbspde&nbsp&nbsp&nbsp<label for="fecfinpag_x" id="lblfecfinpag_x"></label><br/><br/>
           No. de Pagos:&nbsp&nbsp&nbsp<label for="num_pagos" id="lblnumfichas_x"></label><br/><br/>
           Se genera ficha número:&nbsp&nbsp&nbsp<label for="numfichaactual" id="lblnumfichaactual"></label>&nbsp&nbsp&nbspde&nbsp&nbsp&nbsp<label for="num_fichas" id="lblnumfichas_y"></label><br/><br/>                    
       </div>                  
       <div class="botonesA" id="botones_fichapagomes">
          <p style="text-align:right"><a href="#" class ="posicion_boton_accion_ficha_pago_mes">Generar</a>&nbsp&nbsp&nbsp<a href="#" class="posicion_boton_cancelar_ficha_pago_mes">Cancelar</a></p>                
       </div>
    </div>         
    <div id="mask"></div>
    <div id="rep_xls"></div>

 </div>
</asp:Content>