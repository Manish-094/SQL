SELECT tn.OWNER,tn.TABLE_NAME,t.column_name,t.data_type,t.data_length,t.nullable
FROM view_table_names tn
JOIN ALL_TAB_COLUMNS t
on tn.table_name = t.table_name
order by tn.table_name,t.column_name;



--procedures
select proc.object_name as procedure_name,
       args.argument_name,
       args.in_out,
       args.data_type,
       args.data_length,
       proc.owner as schema_name
from all_procedures proc
left join all_arguments args
    on proc.object_id = args.object_id
where proc.owner  in ('IND15902','IND15903','IND15904','IND15905')
      and object_type = 'PROCEDURE';
         

--functions
SELECT func.object_name AS function_name,
       args.argument_name,
       args.data_type,
       func.status,
       args.data_length,
       func.owner AS schema_name
FROM all_objects func
     JOIN all_arguments args
    ON func.object_id = args.object_id
WHERE func.owner IN ('IND15902', 'IND15903', 'IND15904', 'IND15905')
      AND func.object_type = 'FUNCTION'
ORDER BY schema_name,
         function_name,
         args.position;

         
         
         
--indexes
SELECT ind.index_name,
       ind.table_name,
       ind.uniqueness,
       ind.index_type,
       col.column_name,
       ind.owner AS schema_name
FROM all_indexes ind
   left JOIN all_ind_columns col
    ON ind.owner = col.index_owner
    AND ind.index_name = col.index_name
WHERE ind.owner IN ('IND15902','IND15903','IND15904','IND15905')
      AND ind.table_owner NOT LIKE 'SYS%'
ORDER BY schema_name,
         table_name,
         index_name,
         column_position;
         
         
         




select * from ADVP_AGENT_DETAILS_FIN;

select * from ADVP_AGENT_DASHBOARD;

select * from NEMO_STAGING_VW_USMBRANCHMAP_DUMP_NEW;

select * from ADVP_RNR_CONTEST_MASTER;
select * from ADVP_RNR_CONTEST_SUMMARY;

select * from all_objects
where owner in ('IND15902','IND15903','IND15904','IND15905')
and object_name = upper('policy_tb_dub');

 
select * from customer_tb_dub
where  ad_code = 'NO USM';
 
select * from customer_tb_dub
where trim(ad_code) <> ad_code
union all
select * from customer_tb_dub
where trim(dum_uid) <> dum_uid;

--PLOICY_TB_DUB TABLE : ALL DISTINCT PROCEDURE
select DISTINCT name
from all_source where type = 'PROCEDURE'

and (text like '%INTO POLICY_TB_DUB%'
   OR text like '%into policy_tb_dub%')
ORDER BY name;

select * from ab_userroles;


select text from dba_source where name = 'P_NEMO_AP_UPDATING_PAYMENT_BIRTHDAY_LINK';


select proc.object_name as procedure_name,
       args.argument_name,
       args.in_out,
       args.data_type,
       args.data_length,
       proc.owner as schema_name
from all_procedures proc
left join all_arguments args
    on proc.object_id = args.object_id
where proc.owner  in ('IND15902')
      and object_type = 'PROCEDURE';
         


--PROCEDURES
select owner,object_name from all_procedures 
where owner in ('IND15902','IND15903','IND15904','IND15905')
order by object_name;

--TRIGGERS
select owner,trigger_name,trigger_type,table_owner,table_name from all_triggers 
where owner in ('IND16801','IND15902','IND15901','IND15903','IND15904','IND15905');

--INDEXES
select owner,index_name,index_type,table_name,table_owner,uniqueness from all_indexes
where owner in('IND16801','IND15902','IND15901','IND15903','IND15904','IND15905');

--views
select * from all_views
where owner in ('IND16801','IND15902','IND15901','IND15903','IND15904','IND15905');

--sequences
select sequence_owner,sequence_name from all_sequences
where sequence_owner in ('IND16801','IND15902','IND15901','IND15903','IND15904','IND15905');

--FUNCTIONS
select object_name,status,owner from all_objects 
where object_type = upper('FUNCTION')
and owner in ('IND16801','IND15902','IND15901','IND15903','IND15904','IND15905');

---------------------------------------------
select object_name,object_type from all_objects
where owner = 'IND16801'
ORDER BY OBJECT_TYPE;

select distinct owner from all_objects;

select object_name,object_type from all_objects
where owner = 'IND15905'
ORDER BY OBJECT_TYPE;

select COUNT(*) from all_objects
where owner = 'IND15905'
ORDER BY OBJECT_TYPE;

SELECT OWNER,TABLE_NAME FROM ALL_TABLES
WHERE OWNER IN ('IND15902','IND15903','IND15904','IND15905');
