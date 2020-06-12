From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 03/15] pwm: lpss: Add range limit check for the
 base_unit register value
Date: Fri, 12 Jun 2020 14:57:32 +0300
Message-ID: <20200612115732.GC2428291@smile.fi.intel.com>
References: <20200607181840.13536-1-hdegoede@redhat.com>
 <20200607181840.13536-4-hdegoede@redhat.com>
 <20200608035023.GZ2428291@smile.fi.intel.com>
 <90769dc0-3174-195b-34e0-ef4bb9d9b982@redhat.com>
 <20200611221242.3bjqvnhcwwxaocxy@taurus.defre.kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200611221242.3bjqvnhcwwxaocxy@taurus.defre.kleine-koenig.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Hans de Goede <hdegoede@redhat.com>, Thierry Reding <thierry.reding@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Fri, Jun 12, 2020 at 12:12:42AM +0200, Uwe Kleine-König wrote:
> On Mon, Jun 08, 2020 at 01:07:12PM +0200, Hans de Goede wrote:
> > On 6/8/20 5:50 AM, Andy Shevchenko wrote:
> > > On Sun, Jun 07, 2020 at 08:18:28PM +0200, Hans de Goede wrote:
> > > > When the user requests a high enough period ns value, then the
> > > > calculations in pwm_lpss_prepare() might result in a base_unit value of 0.
> > > > 
> > > > But according to the data-sheet the way the PWM controller works is that
> > > > each input clock-cycle the base_unit gets added to a N bit counter and
> > > > that counter overflowing determines the PWM output frequency. Adding 0
> > > > to the counter is a no-op. The data-sheet even explicitly states that
> > > > writing 0 to the base_unit bits will result in the PWM outputting a
> > > > continuous 0 signal.
> > > 
> > > So, and why it's a problem?
> > 
> > Lets sya the user requests a PWM output frequency of 100Hz on Cherry Trail
> > which has a 19200000 Hz clock this will result in 100 * 65536 / 19200000 =
> > 0.3 -> 0 as base-unit value. So instead of getting 100 Hz the user will
> > now get a pin which is always outputting low.
> 
> I didn't follow the complete discussion but note that the general rule
> is:
> 
> 	round period down to the next possible implementable period
> 	round duty_cycle down to the next possible implementable duty_cycle
> 
> so if a small enough period (and so a small duty_cycle) is requested it
> is expected that duty_cycle will be zero.

...which brings me an idea that PWM framework should expose API to get a
capabilities, like DMA Engine has.

In such capabilities, in particular, caller can get ranges of the correct
frequencies of the underneath hardware.

-- 
With Best Regards,
Andy Shevchenko
