"""
Scott Renton, Feb 2019
dspace loader variables
"""
ALL_VARS = {
    'EX_FOLD': '/dspaceExisting/',
    'N_FOLD' : '/dspaceNew/',
    'MAP_FILE' : 'mapping.txt',
    'BIT_DIR' : 'bitstreamdirectory',
    'DC_HEADER' : 'dublin_core',
    'API_URL' : 'http://test.vernonapi.is.ed.ac.uk/vcms-api/oecgi4.exe/datafiles/OBJECT/?query=',
    'FIELDS' : '&fields=id,accession_no,ob_display,name,other_name,object_type,brief_desc,classification,collection,controlling_institution,cataloguer,cataloguer_notes,material,measure_desc,signature_date,prod_pri_person_name,prod_pri_person,prod_pri_role,prod_pri_person_gender,prod_pri_person_ethnicity,prod_pri_person_lifeyears,prod_pri_person_nationality,prod_pri_person_bio_display,prod_pri_technique,prod_pri_place,prod_pri_place_role,prod_pri_date,prod_pri_date_notes,prod_pri_earliest,prod_pri_latest,prod_pri_period,curr_owner,acq_notes,prov_notes,credit_line,physical_notes,sound,decoration_desc,pa_others_desc,subject_person,subject_role,subject_person_notes,subject_person_gender,subject_person_ethnicity,subject_place,subject_place_notes,subject_event,subject_event_notes,subject_period,subject_period_notes,subject_date,subject_object,subject_class,subject_class_notes,subject_notes,general_flag,av,av_primary_image,user_auth_mv1,user_auth_mv2,user_auth_mv3,user_auth_mv4,user_value_1,user_text_1,user_text_2,user_text_3,user_text_4,user_text_5,user_sym_1,user_sym_2,user_sym_3,user_sym_4,user_sym_5,user_sym_6,user_sym_7,user_sym_8,user_sym_9,user_sym_10,user_sym_11,user_sym_12,user_sym_13,user_sym_14,user_sym_15,user_sym_16,user_sym_17,user_sym_18,user_sym_19,user_sym_20,user_sym_21,user_sym_22,user_sym_23,user_sym_24,user_sym_25,user_sym_26,user_sym_27,user_sym_28,user_sym_29,user_sym_30,user_sym_31,user_sym_32,user_sym_33,user_sym_34,user_sym_35,user_sym_36,user_sym_37,user_sym_38,user_sym_39,user_sym_40,user_sym_41,user_sym_42,user_sym_43,user_sym_44,user_sym_45,user_sym_46,user_sym_47,user_sym_48,user_sym_49,user_sym_50,user_sym_51,user_sym_54,user_sym_55,user_sym_56,user_sym_57,prod_notes,prod_det_person,prod_det_role,user_auth_mv5,user_sym_59,user_sym_60,user_sym_58,av_notes,au_related,user_sym_61,user_sym_62,user_sym_63,user_sym_64,user_sym_66,usual_loc_being,usual_loc_external_being,user_sym_67,user_sym_68',
    'LIMIT' : '&limit=10000',
    'API_AV_CHECK_URL': 'http://test.vernonapi.is.ed.ac.uk/vcms-api/oecgi4.exe/datafiles/AV?query=',
    'ST_CECILIA_QUERY': 'slist:"StCeciliasItems")',
    'MIMED_QUERY' : 'squery:"MIMEdSkylight")',
    'PUBLIC_ART_QUERY': 'squery:"Public%20Art")',
    'ART_QUERY' : 'squery:"PO.1455976789.IS-LAC-2008.19")',
    'ART_PUBLIC_IMAGES_QUERY' : '(squery:"PO.1530279910.IS-LAC-2079.441")'
}
