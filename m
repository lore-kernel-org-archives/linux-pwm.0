From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 04/16] pwm: lpss: Add range limit check for the
 base_unit register value
Date: Thu, 9 Jul 2020 17:51:12 +0300
Message-ID: <20200709145112.GB3703480@smile.fi.intel.com>
References: <20200708211432.28612-1-hdegoede@redhat.com>
 <20200708211432.28612-5-hdegoede@redhat.com>
 <20200709125342.GX3703480@smile.fi.intel.com>
 <4ff9dc18-fa59-d9a3-c7bf-9f95c62fc356@redhat.com>
 <20200709142136.GZ3703480@smile.fi.intel.com>
 <c7925c63-9187-f89f-3a01-2ff252012615@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c7925c63-9187-f89f-3a01-2ff252012615@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Thu, Jul 09, 2020 at 04:33:50PM +0200, Hans de Goede wrote:
> On 7/9/20 4:21 PM, Andy Shevchenko wrote:
> > On Thu, Jul 09, 2020 at 03:23:13PM +0200, Hans de Goede wrote:

...

> > You can use clamp_val().
> 
> I did not know about that, that will work nicely I will switch to clamp_val
> for the next version. I assume it is ok to keep your Reviewed-by with this
> very minor change?

Sure.

-- 
With Best Regards,
Andy Shevchenko
