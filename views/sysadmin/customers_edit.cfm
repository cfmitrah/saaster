<cfscript>
    // Exception handling for sef and customer id
    param name="thiscontent.thisID" default=0 type="numeric";
    thisCustomerID = thiscontent.thisID;

    if(not isNumeric(thisCustomerID) or thisCustomerID lte 0) {
        location url="#application.mainURL#/sysadmin/customers" addtoken="false";
    }

    qCustomers = application.objCustomer.getCustomerData(thisCustomerID);
    qCountries = application.objGlobal.getCountry(language=session.lng);

    // Set default values
    custCompany = qCustomers.strCompanyName;
    custContactPerson = qCustomers.strContactPerson;
    custAddress = qCustomers.strAddress;
    custAddress2 = qCustomers.strAddress2;
    custZIP = qCustomers.strZIP;
    custCity = qCustomers.strCity;
    countryID = qCustomers.intCountryID;
    custEmail = qCustomers.strEmail;
    custPhone = qCustomers.strPhone;
    custWebsite = qCustomers.strWebsite;
    custBillingAccountName = qCustomers.strBillingAccountName;
    custBillingEmail = qCustomers.strBillingEmail;
    custBillingAddress = qCustomers.strBillingAddress;
    custBillingInfo = qCustomers.strBillingInfo;

    if(structKeyExists(session, "company") and len(trim(session.company))) {
        custCompany = session.company;
    }

    if(structKeyExists(session, "contact") and len(trim(session.contact))){
        custContactPerson = session.contact;
    }

    if(structKeyExists(session, "address") and len(trim(session.address))){
        custAddress = session.address;
    }

    if(structKeyExists(session, "address2") and len(trim(session.address2))){
        custAddress2 = session.address2;
    }

    if(structKeyExists(session, "zip") and len(trim(session.zip))){
        custZIP = session.zip;
    }
    
    if(structKeyExists(session, "city") and len(trim(session.city))){
        custCity = session.city;
    }

    if(structKeyExists(session, "countryID") and len(trim(session.countryID))){
        countryID = session.countryID;
    }

    if(structKeyExists(session, "email") and len(trim(session.email))){
        custEmail = session.email;
    }

    if(structKeyExists(session, "phone") and len(trim(session.phone))){
        custPhone = session.phone;
    }

    if(structKeyExists(session, "website") and len(trim(session.website))){
        custWebsite = session.website;
    }
    
    if(structKeyExists(session, "billing_name") and len(trim(session.billing_name))){
        custBillingAccountName = session.billing_name;
    }

    if(structKeyExists(session, "billing_email") and len(trim(session.billing_email))){
        custBillingEmail = session.billing_email;
    }

    if(structKeyExists(session, "billing_address") and len(trim(session.billing_address))){
        custBillingAddress = session.billing_address;
    }

    if(structKeyExists(session, "billing_info") and len(trim(session.billing_info))){
        custBillingInfo = session.billing_info
    }
</cfscript>

<cfinclude template="/includes/header.cfm">

<cfinclude template="/includes/navigation.cfm">

<div class="page-wrapper">
    <cfoutput>
        <div class="container-xl">

            <div class="row mb-3">
                <div class="col-md-12 col-lg-12">

                    <div class="page-header col-lg-9 col-md-8 col-sm-8 col-xs-12 float-start">
                        <ol class="breadcrumb breadcrumb-dots">
                            <li class="breadcrumb-item"><a href="#application.mainURL#/dashboard">Dashboard</a></li>
                            <li class="breadcrumb-item">Sysadmin</li>
                            <li class="breadcrumb-item"><a href="#application.mainURL#/sysadmin/customers">Customers</a></li>
                            <li class="breadcrumb-item active">#qCustomers.strCompanyName#</li>
                        </ol>
                    </div>
                </div>
            </div>
            <cfif structKeyExists(session, "alert")>
                #session.alert#
            </cfif>
        </div>
        <div class="container-xl">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Edit: #qCustomers.strCompanyName#</h3>
                        </div>
                        <div class="card-body">
                            <div class="col-lg-12">
                                <form class="card" id="submit_form" method="post" action="#application.mainURL#/sysadm/customers">
                                    <input type="hidden" name="edit_company_btn">
                                    <div class="card-header">
                                        <h3 class="card-title">Edit company</h3>
                                    </div>
                                    <div class="card-body">                                    
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Company Name *</label>
                                                    <input type="text" name="company" class="form-control" value="#HTMLEditFormat(custCompany)#" minlength="3" maxlength="100" required>
                                                </div>
                                            </div>    
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Contact person *</label>
                                                    <input type="text" name="contact" class="form-control" value="#HTMLEditFormat(custContactPerson)#" minlength="3" maxlength="100" required>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Address *</label>
                                                    <input type="text" name="address" class="form-control" value="#HTMLEditFormat(custAddress)#" minlength="3" maxlength="100" required>
                                                </div>
                                            </div> 
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Additional address</label>
                                                    <input type="text" name="address2" class="form-control" value="#HTMLEditFormat(custAddress2)#" maxlength="100">
                                                </div>
                                            </div>                                        
                                            <div class="col-sm-6 col-md-3">
                                                <div class="mb-3">
                                                    <label class="form-label">ZIP *</label>
                                                    <input type="text" name="zip" class="form-control" value="#HTMLEditFormat(custZIP)#" minlength="4" maxlength="10" required>
                                                </div>
                                            </div>
                                            <div class="col-md-5">
                                                <div class="mb-3">
                                                    <label class="form-label">City *</label>
                                                    <input type="text" name="city" class="form-control" value="#HTMLEditFormat(custCity)#" minlength="3" maxlength="100" required>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 col-md-4">
                                                <div class="mb-3">
                                                    <label class="form-label">Country</label>                                    
                                                    <select name="countryID" type="text" class="form-select" placeholder="Country" id="select-users">
                                                        <cfloop query="qCountries">
                                                            <option value="#qCountries.intCountryID#" <cfif qCountries.intCountryID eq countryID>selected</cfif>>#qCountries.strCountryName#</option>
                                                        </cfloop>
                                                    </select>
                                                </div>
                                            </div>  
                                            <div class="col-md-5">
                                                <div class="mb-3">
                                                    <label class="form-label">Email address</label>
                                                    <input type="email" class="form-control" name="email" value="#custEmail#" maxlength="100">
                                                </div>
                                            </div>
                                            <div class="col-sm-6 col-md-3">
                                                <div class="mb-3">
                                                    <label class="form-label">Phone</label>
                                                    <input type="text" class="form-control" name="phone" value="#HTMLEditFormat(custPhone)#" maxlength="100">
                                                </div>
                                            </div>
                                            <div class="col-sm-6 col-md-4">
                                                <div class="mb-3">
                                                    <label class="form-label">Website</label>
                                                    <input type="text" class="form-control" name="website" value="#HTMLEditFormat(custWebsite)#" maxlength="100">
                                                </div>
                                            </div>
                                            <input type="hidden" name="redirect" value="#thisCustomerID#">                                                         
                                        </div>
                                    </div>
                                    <div class="card-header">
                                        <h3 class="card-title">Invoice settings</h3>
                                    </div>
                                    <div class="card-body">                                    
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Company Name</label>
                                                    <input type="text" name="billing_name" class="form-control" value="#HTMLEditFormat(custBillingAccountName)#" maxlength="100">
                                                </div>
                                            </div>    
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Invoice email address</label>
                                                    <input type="email" name="billing_email" class="form-control" value="#custBillingEmail#" maxlength="100">
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Invoice address</label>
                                                    <textarea class="form-control" name="billing_address" rows="6">#custBillingAddress#</textarea>
                                                </div>
                                            </div> 
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Invoice information</label>
                                                    <textarea class="form-control" name="billing_info" rows="6">#custBillingInfo#</textarea>
                                                </div>
                                            </div>                                                       
                                        </div>
                                    </div>
                                    <div class="card-footer text-right">
                                        <button type="submit" id="submit_button" class="btn btn-primary">Save</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="card-footer">
                        
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </cfoutput>
    <cfinclude template="/includes/footer.cfm">
</div>
