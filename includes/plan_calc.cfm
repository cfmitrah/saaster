
<cfscript>

    // This file is loading via ajax called in /customer/plans.cfm
    if (structKeyExists(url, "plan_id") and structKeyExists(url, "recurring")) {

        // Get the booked plan
        bookedPlan = session.currentPlan;

        // Get the currency of the last invoice
        currency = application.objCustomer.getCustomerData(session.customer_id).strCurrency;

        // Init prices
        objPrices = new com.prices(language=session.lng, currency=currency);

        // Get the currency id of the last invoice
        currencyID = objPrices.getCurrency(currency).id;
        if (currencyID eq 0) {
            currencyID = objPrices.getCurrency().id;
        }

        // Init
        objPlans = new com.plans(language=session.lng, currencyID=currencyID);
        objBooking = new com.book(type="plan", language=session.lng);

        // Get plan data using the plan id
        planDetail = objPlans.getPlanDetail(url.plan_id);

        // Get the booking link
        switch (url.recurring) {
            case "yearly":
                bookingLink = planDetail.bookingLinkY;
                break;
            case "monthly":
                bookingLink = planDetail.bookingLinkM;
                break;
            case "onetime":
                bookingLink = planDetail.bookingLinkO;
                break;
            default:
                bookingLink = "";
        }

        if (!len(trim(bookingLink))) {
            abort;
        }

        if (planDetail.itsFree) {
            bookingLink = planDetail.bookingLinkO;
        }

        checkBooking = objBooking.checkBooking(session.customer_id, planDetail, url.recurring);
        if (!isStruct(checkBooking)) {
            abort;
        }

        // Amount to pay today
        amountToPay = 0;
        if (structKeyExists(checkBooking, "amountToPay")) {
            if (isStruct(checkBooking.amountToPay) and structKeyExists(checkBooking.amountToPay, "toPayNow")) {
                amountToPay = checkBooking.amountToPay.toPayNow;
            } else {
                amountToPay = checkBooking.amountToPay;
            }
        }

        //dump(checkBooking);
        //dump(planDetail);





    } else {
        abort;
    }

</cfscript>

<cfoutput>

<!--- Same plan and recurring? --->
<cfif (bookedPlan.planID eq url.plan_id) and ((bookedPlan.recurring eq url.recurring) or planDetail.itsFree)>

    <cfinclude template="/includes/plan_view.cfm">

    <cfif bookedPlan.status eq "expired">
        <cfif url.recurring eq "monthly">
            <p class="mt-4"><a href="#planDetail.bookingLinkM#" class="btn btn-success plan w-100">#getTrans('txtBookNow')#</a></p>
        <cfelse>
            <p class="mt-4"><a href="#planDetail.bookingLinkY#" class="btn btn-success plan w-100">#getTrans('txtBookNow')#</a></p>
        </cfif>
    </cfif>

<cfelse>

    <cfset message = checkBooking.message>

    <h1 class="mb-3">#message.title#</h1>

    <cfif checkBooking.canBook>

        <p>#message.message#</p>

    <cfelse>

        <p class="text-red">#message.message#</p>

    </cfif>



    <cfif amountToPay gt 0>
        <p>#getTrans('txtToPayToday')# <b>#planDetail.currencySign# #lsCurrencyFormat(amountToPay, "none")#</b></p>
    </cfif>

    <cfset bookingButton = getTrans('txtBookNow')>
    <cfset bookingLink = bookingLink>

    <cfif structKeyExists(message, "button") and len(trim(message.button))>
        <cfset bookingButton = message.button>
    </cfif>
    <cfif structKeyExists(message, "link") and len(trim(message.link))>
        <cfset bookingLink = message.link>
    </cfif>

    <p class="mt-4"><a href="#bookingLink#" class="btn btn-success plan w-100">#bookingButton#</a></p>


</cfif>

</cfoutput>