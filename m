From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH REGRESSION-FIX resend] pwm: lpss: Set enable-bit before
 waiting for update-bit
Date: Wed, 29 Mar 2017 20:41:29 +0300
Message-ID: <1490809289.708.57.camel@linux.intel.com>
References: <20170325140658.26868-1-hdegoede@redhat.com>
         <1490712327.708.30.camel@linux.intel.com>
         <d24997bc-9afc-00ec-425d-92a2d48ec2c6@redhat.com>
         <1490722132.708.43.camel@linux.intel.com>
         <1490722434.708.45.camel@linux.intel.com>
         <f2687abf-1fbb-de12-ab1f-be5056cddb70@redhat.com>
         <1490786665.708.47.camel@linux.intel.com>
         <3445f086-3619-33fb-7cfc-1c06b1ea654b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:59619 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753144AbdC2Rle (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 29 Mar 2017 13:41:34 -0400
In-Reply-To: <3445f086-3619-33fb-7cfc-1c06b1ea654b@redhat.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, "Koskinen, Ilkka" <ilkka.koskinen@intel.com>

On Wed, 2017-03-29 at 14:42 +0200, Hans de Goede wrote:
> On 29-03-17 13:24, Andy Shevchenko wrote:
> > On Tue, 2017-03-28 at 21:16 +0200, Hans de Goede wrote:
> > > On 03/28/2017 07:33 PM, Andy Shevchenko wrote:
> > > > On Tue, 2017-03-28 at 20:28 +0300, Andy Shevchenko wrote:
> > > > > On Tue, 2017-03-28 at 19:20 +0200, Hans de Goede wrote:

> > > > > Let me cite a bit of documentation (the wordings is the same
> > > > > across
> > > > > *all* supported Intel SoCs):
> > > > > 
> > > > > --- 8< --- 8< ---
> > > > > 
> > > > > 9.8.2 Programming Sequence
> > > > > To ensure that there are no operational issues with PWM the
> > > > > following
> > > > > programming sequences must be performed in the order defined.
> > > > > 
> > > > > • Initial Enable or First Activation
> > > > > — Program the Base Unit and On Time Divisor values
> > > > > — Set the Software Update Bit
> > > > > — Enable the PWM Output by setting the PWM Enable bit
> > > > > — Repeat the above steps for the next PWM module
> > > > > 
> > > > > • Dynamic update while PWM is Enabled
> > > > > — Program the Base Unit and On Time Divisor values
> > > > > — Set the Software Update Bit
> > > > > — Repeat the above steps for the next PWM module
> > > > > 

> > > > 9.8.1 Functional Description
> > > > Software controls the PWM block by updating the PWMCTRL register
> > > > and
> > > > setting the sw_update bit whenever a change in frequency or duty
> > > > cycle
> > > > of the PWM output signal is required. When the sw_update bit is
> > > > set
> > > > the
> > > > PWM block applies the new settings at the start of the next
> > > > output
> > > > cycle
> > > > and resets the sw_update bit.
> > > > 
> > > > --- 8< --- 8< ---
> > > 
> > > Right, notice the "pplies the new settings at the start of the
> > > next
> > > output cycle"
> > > with the enable bit not set the next cycle never starts, at least
> > > that
> > > seems to
> > > be the case on Cherry Trail.
> > 
> > So, you are telling that "Initial Enable or First Activation" is
> > buggy
> > in your case?
> 
> No what I'm saying is that if you set the update bit to 1 while the
> enable
> bit is 0 and then wait for the update bit to clear it will never clear
> because it will clear when "the PWM block applies the new settings at
> the start of the next output cycle" and there is no start of the next
> output cycle with enable being 0 because then there is no output.

Okay, in that case, why it works on the rest of SoCs either way?

To me it sounds that spec doesn't clarify what exactly enable bit does
vs. SW update one in actual hardware.

> 
> IOW it seems that the cherrytrail hw is following the spec at least
> how I read it.

Spec doesn't clarify whether we should wait or not for SW update bit to
be cleared when we enable PWM.

> Either way I think the best way to resolve this is by having different
> code paths on enable for Cherry Trail vs Apollo Lake. As I already
> said
> I will happily test a patch for this on Cherry Trail.

I have one more theory, but would like to check first.

Can you add something like the following whenever you about to set
values to PWM (in either case if it's enabled or not)

{
void __iomem *x = iomap(phys_base + 0x800, 8);
pr_info("Values are: %x %x\n", readl(x+0), readl(x+4));
iounmap(x);
pr_info("PWMCTRL: %x\n", readl(base));
}
...

update register
...


I would like to see this when it works and when it doesn't.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
