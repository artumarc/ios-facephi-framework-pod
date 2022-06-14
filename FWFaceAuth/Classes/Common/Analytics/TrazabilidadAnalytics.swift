//
//  TrazabilidadAnalytics.swift
//  FirebaseCore
//
//  Created by Jason Sa on 04/03/20.
//

import Foundation

class TrazabilidadAnalytics {
    
    struct ClaveFW {
        
        static let SCREEN_NAME = "screen_name"
        static let EVENT_ACTION = "event_action"
        static let EVENT_NAME = "event_name"
        static let NUMERO_CUENTA = "numero_cuenta"
        static let RANGO_EDAD = "rango_edad"
        static let RANGO_SALDO = "rango_saldo"
        static let REGIMEN = "regimen"
        static let ID_CLIENTE = "id_cliente"
        static let STEP = "step"
        
        //Trazabilidad hoja 8
        //Trazabilidad hoja 11
        static let RESULT_SCAN = "result_scan"
        static let MENSAJE_ERROR = "mensaje_error"
    }
    
    struct Event_Action_FW  {
        static let ACTION_OPEN = "open"
    }
    
    struct Screen_Name_FW {
        //Trazabilidad hoja 4
        static let CAPTURA_PASOS_PARA_RETIRO_SCREEN = "Captura_Pasos_Para_Retiro_Screen"
        
        //Trazabilidad hoja 5
        static let AHORROS_VOLUNTARIOS_SCREEN = "Camara_Rosto_Retivo_Av_Screen"
        
        //Trazabilidad hoja 6
        static let FOTO_RETIRO_SCREEN = "Foto_Retiro_Screen"
        
        //Trazabilidad hoja 7
        static let CAPTURA_INE_IFE_FRENTE_RETIRO_SCREEN = "Captura_INE_IFE_Frente_Retiro_Screen"
        
        //Trazabilidad hoja 8
        static let CAPTURA_INE_IFE_FRENTE_RETIRO_AV_SCREEN = "Scaner_INE_IFE_Frente_Retiro_av_Screen"
        
        //Trazabilidad hoja 9
        static let FRENTE_INE_IFE_RETIRO_AV_SCREEN = "Frente_INE_IFE_Retiro_av_Screen"
        
        //Trazabilidad hoja 10
        static let CAPTURA_VUELTA_INE_IFE_RETIRO_AV_SCREEN = "Captura_Vuelta_INE_IFE_Retiro_av_Screen"
        
        //Trazabilidad hoja 11
        static let SCANER_INE_IFE_VUELTA_RETIRO_SCREEN = "Scaner_INE_IFE_Vuelta_Retiro_Screen"
        
        //Trazabilidad hoja 12
        static let VUELTA_INE_IFE_RETIRO_SCREEN = "Vuelta_INE_IFE_Retiro_Screen"
    }
    
    struct Event_Name_FW {
        //Trazabilidad hoja 4
        static let PASOS_AV_ENTER = "Pasos_av_enter"//Pasos_retiro_av_enter
        static let CONTINUAR_AV_CLICK = "continuar_av_click​"//continuar_retiro_av_click
        static let AVISO_PRIVACIDAD_RETIRO_CLICK = "aviso_privacidad_retiro_click"
        
        
        //Trazabilidad hoja 5
        static let CAMARA_ROSTRO_RETIRO_AV_ENTER = "camara_rostro_retiro_av_enter"
        static let CERRAR_CAPTURA_RETIRO_AV_CLICK = "cerrar_captura_retiro_av_click"
        
        //Trazabilidad hoja 6
        static let FOTO_ENTER = "foto_enter"//foto_retiro_enter
        static let CONFIRMAR_FOTO_CLICK = "confirmar_foto_click​"//confirmar_foto_retiro_click
        static let REEMPLAZAR_FOTO_CLICK = "reemplazar_foto_click​"//reemplazar_foto_retiro_click
        
        //Trazabilidad hoja 7
        static let CAPTURA_INE_AV_ENTER = "captura_ine_av_enter​"//captura_ine_retiro_av_enter
        static let FRENTE_INE_AV_CLICK = "frente_ine_av_click​"//frente_ine_retiro_av_click
        
        //Trazabilidad hoja 8
        static let SCANER_FRENTE_RETIRO_AV_ENTER = "scaner_frente_retiro_av_enter"
        static let SCAN_CLICK = "scan_click"//scan_ine_retiro_av
        static let SUCCESS = "sucess"
        static let FAILED = "failed"
        
        //Trazabilidad hoja 9
        static let FRENTE_INE_RETIRO_AV_ENTER = "frente_ine_retiro_av_enter"
        static let RECAPTURA_FRENTE_AV_CLICK = "recapturar_frente_av_click​"//recaptura_frente_retiro_av_click
        static let CONFIRMAR_FRENTE_RETIRO_AV_CLICK = "confirmar_frente_retiro_av_click​"//confirmar_frente_retiro_av_click
        
        //Trazabilidad hoja 10
        static let CAPTURA_VUELTA_RETIRO_AV_ENTER = "captura_vuelta_retiro_av_enter"
        static let CAPTURA_VUELTA_RETIRO_CLICK = "captura_vuelta_retiro_click"
        
        //Trazabilidad hoja 11
        static let SCAN_INE_VUELTA_ENTER = "scan_ine_vuelta_enter"
        static let INE_RET_VUELTA_CERRA_CLICK = "ine_ret_vuelta_cerrar_click"
        static let RET_SCAN_VUELTA_INE = "ret_scan_vuelta_ine"
        
        //Trazabilidad hoja 12
        static let VUELTA_RETIRO_AV_ENTER = "vuelta_retiro_av_enter"
        static let RECAPTURA_VUELTA_RETIRO_CLICK = "recaptura_vuelta_retiro_click"
        static let CONFIRMAR_VUELTA_INE_RETIRO_CLICK = "confirmar_vuelta_ine_retiro_click"
    }
}
