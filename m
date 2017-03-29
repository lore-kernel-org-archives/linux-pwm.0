From: Ilkka Koskinen <ilkka.koskinen@intel.com>
Subject: Re: [PATCH REGRESSION-FIX resend] pwm: lpss: Set enable-bit before
 waiting for update-bit
Date: Tue, 28 Mar 2017 21:50:13 -0700
Message-ID: <20170329045013.GB166986@kammari>
References: <20170325140658.26868-1-hdegoede@redhat.com>
 <1490712327.708.30.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:14147 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751626AbdC2EuG (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 29 Mar 2017 00:50:06 -0400
Content-Disposition: inline
In-Reply-To: <1490712327.708.30.camel@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org

On Tue, Mar 28, 2017 at 05:45:27PM +0300, Andy Shevchenko wrote:
> On Sat, 2017-03-25 at 15:06 +0100, Hans de Goede wrote:
> > Hi Andy, Thierry,
> > 
> > This patch fixes a regression with the pwm-lpss driver in 4.11,
> > where it once turned off will not turn back on again on some
> > machines. Yet it has been silent around this patch for some
> > time now. Can you please review this and get it queued as a fix
> > for 4.11 ?
> 
> I have tested this patch (*) on 3 boards:
> 1) internal development board (ApolloLake)
> 2) MinnowBoard MAX (BayTrail)
> 3) Intel Edison / Arduino break out (Tangier)
> 4) ...not yet... (CherryTrail / Braswell)
> 
> So, the patch *broke* functionality on 1), while 2) and 3) are survived.

I was told that it broke the functionality on Joule as well, which isn't
suprising given that it did the same thing on ApolloLake

> 
> (*) The base is my eds branch (https://github.com/andy-shev/linux/tree/e
> ds, v4.11-rc4 based) + few pin control related patches to enable PWM
> output.
> 
> P.S. I'll continue looking for CherryTrail / Braswell based board to
> have some coverage there in the future.
> 
> -- 
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pwm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
