Return-Path: <andriy.shevchenko@linux.intel.com>
Date: Mon, 24 Sep 2018 16:22:58 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/2] pwm: lpss: Add pwm_lpss_get_put_runtime_pm helper
 function
Message-ID: <20180924132258.GO15943@smile.fi.intel.com>
References: <20180911174533.4484-1-hdegoede@redhat.com>
 <20180911174533.4484-2-hdegoede@redhat.com>
 <20180924091653.GF15943@smile.fi.intel.com>
 <88a8e7b3-5c8e-2783-8972-1a1e495d3f28@redhat.com>
 <20180924100505.GK15943@smile.fi.intel.com>
 <658bf04b-5040-5eb4-6492-3ffad778e415@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <658bf04b-5040-5eb4-6492-3ffad778e415@redhat.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org

On Mon, Sep 24, 2018 at 02:13:03PM +0200, Hans de Goede wrote:
> On 24-09-18 12:05, Andy Shevchenko wrote:
> > On Mon, Sep 24, 2018 at 11:58:42AM +0200, Hans de Goede wrote:

> > Thanks.

> > I'm just wondering if we can leave pwm_lpss_apply() untouched and use a new helper for ->remove() and ->get_state() only.
> 
> The idea was to have a single place doing the pm_runtime_get() and
> pm_runtime_put() calls. Leaving pwm_lpss_apply() as is and this not
> using this helper there is fine with me, but then we might just as
> well directly do the [un]ref directly in >remove() and ->get_state()
> as well, that is just 2 lines (instead of 1) for each.
> 
> I'm not against leaving pwm_lpss_apply() as is, but then we might
> just as well drop this patch, so do you want to drop this patch
> for v2 ?

I would prefer not to change ->apply().
So, please, modify (I guess we still need some pm calls in ->remove()).
Perhaps it would also require Fixes tag to be applied.

> 
> Also do you have any remarks on the patch adding the get_stage
> callback before I send out a v2?

No, looks sane, just same comment as above per pm calls.


-- 
With Best Regards,
Andy Shevchenko
