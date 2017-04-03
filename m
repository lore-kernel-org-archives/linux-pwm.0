From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH REGRESSION-FIX resend] pwm: lpss: Set enable-bit before
 waiting for update-bit
Date: Mon, 03 Apr 2017 17:22:46 +0300
Message-ID: <1491229366.708.102.camel@linux.intel.com>
References: <20170325140658.26868-1-hdegoede@redhat.com>
         <1490712327.708.30.camel@linux.intel.com>
         <d24997bc-9afc-00ec-425d-92a2d48ec2c6@redhat.com>
         <1490722132.708.43.camel@linux.intel.com>
         <1490722434.708.45.camel@linux.intel.com>
         <f2687abf-1fbb-de12-ab1f-be5056cddb70@redhat.com>
         <1490786665.708.47.camel@linux.intel.com>
         <3445f086-3619-33fb-7cfc-1c06b1ea654b@redhat.com>
         <1490809289.708.57.camel@linux.intel.com>
         <d399a9cb-7f73-08cd-47b5-f25aee416a6e@redhat.com>
         <1490990824.708.90.camel@linux.intel.com>
         <05b8cb4a-ae77-8a06-67de-a89b7333f651@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:31504 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752706AbdDCOZy (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 3 Apr 2017 10:25:54 -0400
In-Reply-To: <05b8cb4a-ae77-8a06-67de-a89b7333f651@redhat.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, "Koskinen, Ilkka" <ilkka.koskinen@intel.com>

On Fri, 2017-03-31 at 22:52 +0200, Hans de Goede wrote:
> Hi,
> 
> On 31-03-17 22:07, Andy Shevchenko wrote:
> > On Wed, 2017-03-29 at 20:25 +0200, Hans de Goede wrote:
> > > Hi,
> > > 
> > > On 29-03-17 19:41, Andy Shevchenko wrote:
> > > > On Wed, 2017-03-29 at 14:42 +0200, Hans de Goede wrote:
> > 
> > Thanks for your patience and valuable input.
> > 
> > So, I found CharryTrail with enabled PWM (UP board v0.4) and confirm
> > the
> > bug.
> > 
> > Moreover, I have re-tested again all 4 platforms with and without
> > your
> > fix, and I dunno how I did not notice this before, but looks like
> > either
> > mine (though commit message shows that I have tested on 3 platforms
> > at
> > least, so, I can re-test for sure) or Ilkka's patch broke it on all
> > platforms except Broxton / Apollo Lake.
> > 
> > So, summurize what we need is a quirk for Broxton / Apollo Lake. I
> > need
> > to check Gemini Lake also to be sure.
> > 
> > And we definitely need this as a fix for stable. I would appreciate
> > if
> > you can figure out which patch from previous series (b14e8ceff034
> > or 10d56a4cb1c6) broke it.
> 
> My patch commit msg says: "fixes
> 10d56a4cb1c6c894c60acbaec0f8aa44aba833b0"
> and unless my memory deceives me I tested that that was the bad commit
> by reverting it.

Oh, yes, thanks for pointing this out.

> 
> The problem for Cherry Trail is not perse the order in which the
> update / enable bits are written (AFAICT), but the waiting for
> the update bit to clear while the enable bit is not set, which
> is why my latest version only moves the wait.

And it looks sane.

> That wait was already present before 10d56a4cb1c6, but with a
> reasonable short timeout, and just continuing on after the
> timeout. 10d56a4cb1c6 makes pwm_lpss_apply() exit with an
> error (without ever setting the enable bit) when the timeout
> expires.
> 

> The troublesome commit caused 2 issues:
> 1) An IMHO unacceptable long timeout (0.5 seconds of near busy waiting
> on each enable
> )

The current clocks and divisor values allow us to set pulses up to
218 ms. I have no idea how we can decrease this significantly. 300 ms?
Or other way which I proposed to Mika and Ilkka during internal review
is to calculate it from last cycle.

> 2) Erroring out when the timeout expires without the update flag
> clearing

What would we do in such case? There is no recovery for us except
waiting more.

I'm about to submit a patch which splits Tangier out of Broxton
configuration (it should go before your fix) and then we need to
introduce a quirk for Broxton and derivatives (Apollo Lake, Gemini
Lake).

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
