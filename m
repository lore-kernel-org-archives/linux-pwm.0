From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH REGRESSION-FIX resend] pwm: lpss: Set enable-bit before
 waiting for update-bit
Date: Tue, 28 Mar 2017 17:45:27 +0300
Message-ID: <1490712327.708.30.camel@linux.intel.com>
References: <20170325140658.26868-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:17884 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751903AbdC1Opf (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 28 Mar 2017 10:45:35 -0400
In-Reply-To: <20170325140658.26868-1-hdegoede@redhat.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, "Koskinen, Ilkka" <ilkka.koskinen@intel.com>

On Sat, 2017-03-25 at 15:06 +0100, Hans de Goede wrote:
> Hi Andy, Thierry,
> 
> This patch fixes a regression with the pwm-lpss driver in 4.11,
> where it once turned off will not turn back on again on some
> machines. Yet it has been silent around this patch for some
> time now. Can you please review this and get it queued as a fix
> for 4.11 ?

I have tested this patch (*) on 3 boards:
1) internal development board (ApolloLake)
2) MinnowBoard MAX (BayTrail)
3) Intel Edison / Arduino break out (Tangier)
4) ...not yet... (CherryTrail / Braswell)

So, the patch *broke* functionality on 1), while 2) and 3) are survived.

(*) The base is my eds branch (https://github.com/andy-shev/linux/tree/e
ds, v4.11-rc4 based) + few pin control related patches to enable PWM
output.

P.S. I'll continue looking for CherryTrail / Braswell based board to
have some coverage there in the future.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
