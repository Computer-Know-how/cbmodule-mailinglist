<cfoutput>
	<cfset currentRow = 0>
	<cfset displayMonth = "">
	<cfparam name="url.year" default="#year(now())#">
	<cfset yearArray = []>
	<cfsavecontent variable="mailingList">
		<cfloop array="#prc.mailings#" index="mailing">
			<!--- Keep track of where we are at in the array --->
			<cfset currentRow++>
			<!--- What is the month of this mailing? --->
			<cfset currentMonth = datePart('m',mailing.getMailingDate())>
			<!--- What is the year of this mailing? --->
			<cfset currentYear = year(mailing.getMailingDate())>
			<!--- If the year is not in the year array then add it --->
			<cfif !yearArray.contains(currentYear)>
				<cfset arrayAppend(yearArray, currentYear)>
			</cfif>
			<!--- Only render the year according to the url year variable --->
			<cfif currentYear eq url.year>
				<!--- If the month changed...start a new month box --->
				<cfif currentMonth neq displayMonth>
				<!--- Not the first time through...end the box --->
				<cfif displayMonth neq "">
					</div>
				</div>
				</cfif>

					<div class="main-column">
						<h2 class="faq-title">#monthAsString(currentMonth)#</h2>

						<div class="accordion in collapse" id="accordion-#currentMonth#" style="height: auto;">
					<!--- Set the display month to the current month --->
					<cfset displayMonth = currentMonth>
					</cfif>
							<!--- Display the mailing --->
							<div class="accordion-group">
								<div class="accordion-heading">
									<a class="accordion-toggle collapsed" data-parent="##accordion-#currentMonth#" data-toggle="collapse" href="##collapse-#mailing.getMailingID()#"><b>#dateFormat(mailing.getMailingDate(), 'mmmm d, yyyy')#</b>:  #mailing.getSubject()#</a>
								</div>

								<div class="accordion-body collapse" id="collapse-#mailing.getMailingID()#" style="height: 0px;">
									<div class="accordion-inner">
										#mailing.getContent()#
									</div>
								</div>
							</div>
				</cfif>
			<!--- Last time through...end the box --->
			<cfif currentRow eq arrayLen(prc.mailings)>
				</div>
			</div>
			</cfif>
		</cfloop>
	</cfsavecontent>

	<div class="cb-mailinglist">
		<div class="row show-grid">
			<div class="span12">
				<div class="press-release-header">
					<cfloop array="#yearArray#" index="i">
						<cfif arrayFind(yearArray, i) neq arrayLen(yearArray)>
							<cfif i eq url.year>
								<b>#i#</b> |
							<cfelse>
								<a href="/index.cfm/press-releases?year=#i#">#i#</a> |
							</cfif>
						<cfelse>
							<cfif i eq url.year>
								<b>#i#</b>
							<cfelse>
								<a href="/index.cfm/press-releases?year=#i#">#i#</a>
							</cfif>
						</cfif>
					</cfloop>
				</div>
			</div>
			<div class="span9">
				#mailingList#
			</div>
			<div class="span3 two-columns-left sidebar" id="left-sidebar" style="margin-top: 10px;">
				<div class="sidebar-baloon sidebar-grey-box">
					<p>Join the "Press Release" list.  Add your email now.</p>
					#html.startForm(name="subscription",action="cbMailingList.listRender.subscribeToList",class="cb-mailinglist-subscribe")#
						#html.hiddenField(name="_returnTo",value=cb.linkSelf())#
						#html.hiddenField(name="listID",value=prc.listID)#
						#html.textField(name="emailAddress",class="cb-mailinglist-subscribe-email")#
						<input type="submit" value="Join" class="cb-mailinglist-subscribe-join btn btn-primary">
					#html.endForm()#
				</div>
			</div>
		</div>
	</div>
</cfoutput>
