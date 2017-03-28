From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH REGRESSION-FIX resend] pwm: lpss: Set enable-bit before
 waiting for update-bit
Date: Tue, 28 Mar 2017 20:28:52 +0300
Message-ID: <1490722132.708.43.camel@linux.intel.com>
References: <20170325140658.26868-1-hdegoede@redhat.com>
         <1490712327.708.30.camel@linux.intel.com>
         <d24997bc-9afc-00ec-425d-92a2d48ec2c6@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:16107 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751980AbdC1R3B (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 28 Mar 2017 13:29:01 -0400
In-Reply-To: <d24997bc-9afc-00ec-425d-92a2d48ec2c6@redhat.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, "Koskinen, Ilkka" <ilkka.koskinen@intel.com>

On Tue, 2017-03-28 at 19:20 +0200, Hans de Goede wrote:
> Hi,
> 
> On 03/28/2017 04:45 PM, Andy Shevchenko wrote:
> > On Sat, 2017-03-25 at 15:06 +0100, Hans de Goede wrote:
> > > Hi Andy, Thierry,
> > > 
> > > This patch fixes a regression with the pwm-lpss driver in 4.11,
> > > where it once turned off will not turn back on again on some
> > > machines. Yet it has been silent around this patch for some
> > > time now. Can you please review this and get it queued as a fix
> > > for 4.11 ?
> > 
> > I have tested this patch (*) on 3 boards:
> > 1) internal development board (ApolloLake)
> > 2) MinnowBoard MAX (BayTrail)
> > 3) Intel Edison / Arduino break out (Tangier)
> > 4) ...not yet... (CherryTrail / Braswell)
> > 
> > So, the patch *broke* functionality on 1), while 2) and 3) are
> > survived.
> 
> Bummer, so on Apollo Lake we need to set the update bit
> *and* wait for it to get acked before setting enable ?

It's designed behaviour as far as I know.

Let me cite a bit of documentation (the wordings is the same across
*all* supported Intel SoCs):

--- 8< --- 8< ---

9.8.2 Programming Sequence
To ensure that there are no operational issues with PWM the following
programming sequences must be performed in the order defined.

• Initial Enable or First Activation
— Program the Base Unit and On Time Divisor values
— Set the Software Update Bit
— Enable the PWM Output by setting the PWM Enable bit
— Repeat the above steps for the next PWM module

• Dynamic update while PWM is Enabled
— Program the Base Unit and On Time Divisor values
— Set the Software Update Bit
— Repeat the above steps for the next PWM module

--- 8< --- 8< ---

(I'm a bit confused about last item in each list, it doesn't clarify
should we use _same_ values or different ones. I hope it just a
recommendation how to program multiple PWMs, not an *obligation*)

> 
> NOte my patch does not change the order of writes, only when we
> do the wait.
> 
> The only good options I see to fix this is to introduce SoC family
> specific code paths :|
> 
> If you can whip up a new version which is tested on Apollo Lake
> and Bay Trail I can run some tests on Cherry Trail.
> 
> Regards,
> 
> Hans
> 
> 
> 
> > 
> > (*) The base is my eds branch (https://github.com/andy-shev/linux/tr
> > ee/e
> > ds, v4.11-rc4 based) + few pin control related patches to enable PWM
> > output.
> > 
> > P.S. I'll continue looking for CherryTrail / Braswell based board to
> > have some coverage there in the future.
> > 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
