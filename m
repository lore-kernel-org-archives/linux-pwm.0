From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH REGRESSION-FIX resend] pwm: lpss: Set enable-bit before
 waiting for update-bit
Date: Fri, 31 Mar 2017 23:07:04 +0300
Message-ID: <1490990824.708.90.camel@linux.intel.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:34990 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755104AbdCaUHI (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 31 Mar 2017 16:07:08 -0400
In-Reply-To: <d399a9cb-7f73-08cd-47b5-f25aee416a6e@redhat.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, "Koskinen, Ilkka" <ilkka.koskinen@intel.com>

On Wed, 2017-03-29 at 20:25 +0200, Hans de Goede wrote:
> Hi,
> 
> On 29-03-17 19:41, Andy Shevchenko wrote:
> > On Wed, 2017-03-29 at 14:42 +0200, Hans de Goede wrote:

Thanks for your patience and valuable input.

So, I found CharryTrail with enabled PWM (UP board v0.4) and confirm the
bug.

Moreover, I have re-tested again all 4 platforms with and without your
fix, and I dunno how I did not notice this before, but looks like either
mine (though commit message shows that I have tested on 3 platforms at
least, so, I can re-test for sure) or Ilkka's patch broke it on all
platforms except Broxton / Apollo Lake.

So, summurize what we need is a quirk for Broxton / Apollo Lake. I need
to check Gemini Lake also to be sure.

And we definitely need this as a fix for stable. I would appreciate if
you can figure out which patch from previous series (b14e8ceff034
or 10d56a4cb1c6) broke it.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
