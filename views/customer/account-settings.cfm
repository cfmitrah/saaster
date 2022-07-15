<cfscript>

    objPlan = new com.plans(language=session.lng);
    moduleArray = new com.modules().getAllModules();

</cfscript>

<cfinclude template="/includes/header.cfm">
<cfinclude template="/includes/navigation.cfm">

<div class="page-wrapper">
    <div class="container-xl">

        <cfoutput>
        <div class="page-header mb-3">
            <h2 class="page-title">#getTrans('txtAccountSettings')#</h2>

            <ol class="breadcrumb breadcrumb-dots" aria-label="breadcrumbs">
                <li class="breadcrumb-item"><a href="#application.mainURL#/dashboard">Dashboard</a></li>
                <li class="breadcrumb-item active" aria-current="page">#getTrans('txtAccountSettings')#</li>
            </ol>

        </div>

        <cfif structKeyExists(session, "alert")>
            #session.alert#
        </cfif>

        <div class="row">

            <div class="col-lg-4 mb-3">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">#getTrans('txtMyProfile')#</h3>
                    </div>
                    <div class="card-body">
                        <div class="list-group">
                            <a href="#application.mainURL#/account-settings/my-profile" class="list-group-item list-group-item-action flex-column align-items-start">
                                <div class="d-flex justify-content-between">
                                    <h4 class="mb-1"><b>#getTrans('txtEditProfile')#</b></h4>
                                </div>
                                <p class="mb-1 ">#getTrans('txtEditYourProfile')#</p>
                            </a>
                            <a href="#application.mainURL#/account-settings/reset-password" class="list-group-item list-group-item-action flex-column align-items-start">
                                <div class="d-flex justify-content-between">
                                    <h4 class="mb-1"><b>#getTrans('titResetPassword')#</b></h4>
                                </div>
                                <p class="mb-1 ">#getTrans('txtResetOwnPassword')#</p>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <cfif session.admin>
                <div class="col-lg-4 mb-3">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">#getTrans('titGeneralSettings')#</h3>
                        </div>
                        <div class="card-body">
                            <div class="list-group">
                                <a href="#application.mainURL#/account-settings/company" class="list-group-item list-group-item-action flex-column align-items-start">
                                    <div class="d-flex justify-content-between">
                                        <h4 class="mb-1"><b>#getTrans('titMyCompany')#</b></h4>
                                    </div>
                                    <p class="mb-1 ">#getTrans('txtMyCompanyDescription')#</p>
                                </a>
                                <a href="#application.mainURL#/account-settings/users" class="list-group-item list-group-item-action flex-column align-items-start">
                                    <div class="d-flex justify-content-between">
                                        <h4 class="mb-1"><b>#getTrans('titUser')#</b></h4>
                                    </div>
                                    <p class="mb-1 ">#getTrans('txtAddOrEditUser')#</p>
                                </a>
                                <cfif getCustomerData.intCustParentID eq 0 and session.superadmin>
                                    <a href="#application.mainURL#/account-settings/tenants" class="list-group-item list-group-item-action flex-column align-items-start">
                                        <div class="d-flex justify-content-between">
                                            <h4 class="mb-1"><b>#getTrans('titMandanten')#</b></h4>
                                        </div>
                                        <p class="mb-1 ">#getTrans('txtAddOrEditTenants')#</p>
                                    </a>
                                </cfif>
                                <a href="#application.mainURL#/account-settings/invoices" class="list-group-item list-group-item-action flex-column align-items-start">
                                    <div class="d-flex justify-content-between">
                                        <h4 class="mb-1"><b>#getTrans('titInvoices')#</b></h4>
                                    </div>
                                    <p class="mb-1 ">#getTrans('txtViewInvoices')#</p>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 mb-3">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">#getTrans('titPlansAndModules')#</h3>
                        </div>
                        <div class="card-body ">

                            <cfinclude  template="/includes/plan_view.cfm">

                            <cfif session.superAdmin>
                                <cfif session.currentPlan.planID gt 0>
                                    <a href="#application.mainURL#/account-settings/plans" class="list-group-item list-group-item-action flex-column align-items-start">
                                        <div class="d-flex justify-content-between">
                                            <h4 class="mb-1"><b>#getTrans('titPlans')#</b></h4>
                                        </div>
                                        <p class="mb-1">#getTrans('txtUpdatePlan')#</p>
                                    </a>
                                <cfelse>
                                    <p>#getTrans('msgNoPlanBooked')# - <a href="#application.mainURL#/account-settings/plans">#getTrans('txtBookNow')#</a></p>
                                </cfif>
                            </cfif>

                            <cfif arrayLen(moduleArray)>

                                <a href="#application.mainURL#/account-settings/modules" class="list-group-item list-group-item-action flex-column align-items-start">
                                    <div class="d-flex justify-content-between">
                                        <h4 class="mb-1"><b>#getTrans('titModules')#</b></h4>
                                    </div>
                                    <p class="mb-1">#getTrans('txtAddOrEditModules')#</p>
                                </a>

                            </cfif>

                        </div>
                    </div>
                </div>
            </cfif>

        </div>
        </cfoutput>
    </div>
</div>
<cfinclude template="/includes/footer.cfm">