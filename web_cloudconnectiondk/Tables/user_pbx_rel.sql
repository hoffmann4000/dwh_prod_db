CREATE TABLE [web_cloudconnectiondk].[user_pbx_rel] (
    [id]                        BIGINT         NULL,
    [user_id]                   BIGINT         NULL,
    [pbx_id]                    BIGINT         NULL,
    [name]                      NVARCHAR (255) NULL,
    [localnumber]               NVARCHAR (32)  NULL,
    [mobile_number]             NVARCHAR (16)  NULL,
    [display_number]            NVARCHAR (16)  NULL,
    [display_number_for_mobile] NVARCHAR (16)  NULL,
    [display_number_for_skype]  NVARCHAR (16)  NULL,
    [sip_password]              NVARCHAR (64)  NULL,
    [timeout]                   BIGINT         NULL,
    [unified_busy]              TINYINT        NULL,
    [unified_blf]               SMALLINT       NULL,
    [callwaiting]               TINYINT        NULL,
    [forward]                   NVARCHAR (255) NULL,
    [mac]                       NVARCHAR (255) NULL,
    [line_number]               SMALLINT       NULL,
    [sip_endpoint_type_id]      BIGINT         NULL,
    [clir]                      TINYINT        NULL,
    [clir_mobile]               SMALLINT       NULL,
    [clir_skype]                TINYINT        NULL,
    [vm_login]                  NVARCHAR (16)  NULL,
    [vm_email]                  SMALLINT       NULL,
    [vm_email_delete]           SMALLINT       NULL,
    [sip_active]                SMALLINT       NULL,
    [vm_sms]                    TINYINT        NULL,
    [localnumber_in]            BIGINT         NULL,
    [mobile_in]                 INT            NULL,
    [skype_in]                  INT            NULL,
    [dnd]                       DATETIME2 (0)  NULL,
    [active_profile]            BIGINT         NULL,
    [provision_language_id]     BIGINT         NULL,
    [no_transfer_outgoing]      TINYINT        NULL,
    [mobileapp_show]            SMALLINT       NULL,
    [outgoing_trunk_id]         BIGINT         NULL,
    [skype_id]                  NVARCHAR (255) NULL,
    [skype_number]              NVARCHAR (16)  NULL,
    [skype_active]              BIGINT         NULL,
    [sidecars_count]            NVARCHAR (50)  NULL,
    [read_dnd]                  SMALLINT       NULL,
    [sip_provision_destination] INT            NULL,
    [user_ntp_usage]            INT            NULL,
    [dashboard_show]            INT            NULL,
    [enable_automatic_profiles] SMALLINT       NULL,
    [local_calls_only]          SMALLINT       NULL,
    [load_dato]                 DATETIME2 (7)  NULL
);


GO

