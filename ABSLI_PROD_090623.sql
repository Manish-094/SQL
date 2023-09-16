--uat : ind#5901
--prod : wesley#123

--ADVP_POLICY_DETAILS DATA RELATED TO POLICY
--NEMO_STAGING_TPOL_01 TAKE DATA FROM SOURCE AND FILL INTO ADVP_POLICY_DETAILS
SELECT 
   NAME,
   TYPE,
   TEXT 
FROM ALL_SOURCE
WHERE TYPE = 'PROCEDURE'
AND TEXT LIKE '%NEMO_STAGING_TPOL_01%';

SELECT * FROM ADVP_STAGING_TPOLC_DUMP; --POLICY_ID(POL_ID) AND CLIENT_ID(CLI_ID)

--ADVP_POLICY_DETAILS
--P_NEMO_INCREMENTAL_OTHER_CHANNELS_UPDATE_JOB_SAMPLE
--P_NEMO_INCREMENTAL_TABLES_CREATION_JOB
--P_NEMO_INCREMENTAL_OTHER_CHANNELS_UPDATE_JOB
--PAT_SS3TOTABLE_AUTO
--P_NEMO_INCREMENTAL_JOB_TPOL
--P_NEMO_INCREMENTAL_JOB_TPOL_TPREG
--TESTJOBT_P_NEMO_INCREMENTAL_OTHER_CHANNELS_UPDATE_JOB
--P_NEMO_INCREMENTAL_TABLES_CREATION_JOB_TPOL
--P_NEMO_INCREMENTAL_TABLES_JOBS_3

--NEMO_STAGING_TPOL_01
--P_NEMO_TPOL --DONE
--PAT_NEMO_INCREMENTAL_TPOL 
--PAT_NEMO_INCREMENTAL_TPOL
--P_NEMO_INCREMENTAL_TABLES_CREATION_JOB --DONE
--P_NEMO_INCREMENTAL_JOB --DONE
--P_NEMO_INCREMENTAL_JOB_TPOL --DONE
--P_NEMO_INCREMENTAL_JOB_TPOL_TPREG



--POLICY_TB_DUB
--P_NEMO_INCREMENTAL_TABLES_JOBS_1
--P_NEMO_AP_UPDATING_PAYMENT_BIRTHDAY_LINK
--P_NEMO_INCREMENTAL_OTHER_CHANNELS_UPDATE_JOB_SAMPLE
--P_NEMO_AP_DAILY_UPDATED_COUNT
--P_NEMO_INCREMENTAL_TABLES_CREATION_JOB
--P_NEMO_INCREMENTAL_JOB_HL_FALLBACK_TABLES
--P_NEMO_INCREMENTAL_OTHER_CHANNELS_UPDATE_JOB
--P_NEMO_AP_PAYMENT_PAID
--P_NEMO_INCREMENTAL_JOB_TPOL
--P_NEMO_INCREMENTAL_TABLES_CREATION_JOB_TPOL
--P_NEMO_AP_ENACH_DETAILS
--P_NEMO_INCREMENTAL_TABLES_JOBS_3


---------------------------------------------------------------

--POLICY_TB_DUB
--P_NEMO_AP_POLICY_DETAILS_STATUS_NEW
--P_NEMO_AP_REVIVAL_LIST_REVISED
--P_NEMO_AP_POLICY_DETAILS_STATUS_NEW
--P_NEMO_AP_POLICY_DETAILS_STATUS_OLD
--P_NEMO_AP_AGENT_LISTING
--P_NEMO_AP_REVIVAL_LIST
--P_NEMO_INCREMENTAL_JOB_12122021
--P_NEMO_AP_POLICY_DETAILS_STATUS_1305
--P_NEMO_AP_RECOMM_PREAPPROVED_OFFERS_LISTING
--P_NEMO_AP_UPDATING_PAYMENT_BIRTHDAY_LINK
--P_NEMO_AP_ENACH_TRANSACTION_DETAILS
--P_NEMO_AP_RENEWAL_LISTING
--P_NEMO_AP_ALL_CUSTOMER_PRODUCT_LIST
--P_NEMO_AP_ALL_CUSTOMERS_OLD
--P_NEMO_AP_ALL_CUSTOMERS
--P_NEMO_AP_BIRTHDAY_LISTING
--P_NEMO_AP_CUSTOMER_ADD_RMV_FAMILY
--P_NEMO_AP_CUSTOMER_FAMILY_VIEW
--P_NEMO_AP_CUSTOMER_LIST
--P_NEMO_AP_PAYMENT_OVERDUE
--P_NEMO_AP_POLICY_DETAILS_STATUS
--P_NEMO_AP_RECOMM_RETENTION
--P_NEMO_AP_POLICY_DISPATCH_REPORT
--P_NEMO_AP_PORTFOLIO_POLICY_STATUS
--P_NEMO_AP_REPORTEEDETAIL
--P_NEMO_AP_ADVISOR_AGENTT_DASHBOARD
--P_NEMO_AP_DAILY_UPDATED_COUNT
--AP_AGENT_DASHBOARD_JOB_SCHEDULER
--P_NEMO_INCREMENTAL_JOB_REVIVAL_LSITING
--P_NEMO_REPORTEEDETAIL_INC
--P_NEMO_AP_RENEWAL_LISTING_DOWNLOAD
--P_NEMO_AP_POLICY_DETAILS_STATUS_DAILY_LOG
--P_NEMO_AP_CONTEST_SUMMARY_POLI_WISE_DTS
--P_NEMO_INCREMENTAL_JOB
--P_NEMO_AP_BIRTHDAY_LISTING_NEW
--P_NEMO_AP_ALL_CUSTOMERS_DOWNLOAD
--P_NEMO_AP_AGENT_GLOBAL_SEARCH_LISTING
--P_NEMO_AP_AGENT_MANAGER_DETAILS
--P_NEMO_INCREMENTAL_POLICY_STATUS_ADVISOR_UPDATE_JOB
--P_NEMO_AP_REVIVAL_LIST_DWLD
--P_NEMO_AP_POLICY_DETAILS_STATUS_BUP
--P_NEMO_AP_ENACH_DETAILS
--P_NEMO_REPORTEEDETAIL_JOB_SCHEDULER
--P_DAILY_BIRTHDAY_JOB
--P_NEMO_AP_ACCUMULATED_BONUS
--P_OVERDUE_JOB
--P_DAILY_OVERDUE_JOB
--P_NEMO_AP_POLICY_DETAIL_POLICY_STATUS
--P_NEMO_AP_MANAGER_RENEWAL
--P_NEMO_AP_MANAGER_RENEWAL_APC
--P_NEMO_AP_MANAGER_RENEWAL_ORG