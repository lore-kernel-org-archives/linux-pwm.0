From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 03/15] pwm: lpss: Add range limit check
 for the base_unit register value
Date: Mon, 8 Jun 2020 15:51:56 +0300
Message-ID: <20200608125156.GL2428291@smile.fi.intel.com>
References: <20200607181840.13536-1-hdegoede@redhat.com>
 <20200607181840.13536-4-hdegoede@redhat.com>
 <20200608035023.GZ2428291@smile.fi.intel.com>
 <90769dc0-3174-195b-34e0-ef4bb9d9b982@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <90769dc0-3174-195b-34e0-ef4bb9d9b982@redhat.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Mon, Jun 08, 2020 at 01:07:12PM +0200, Hans de Goede wrote:
> On 6/8/20 5:50 AM, Andy Shevchenko wrote:
> > On Sun, Jun 07, 2020 at 08:18:28PM +0200, Hans de Goede wrote:
> > > When the user requests a high enough period ns value, then the
> > > calculations in pwm_lpss_prepare() might result in a base_unit value of 0.
> > > 
> > > But according to the data-sheet the way the PWM controller works is that
> > > each input clock-cycle the base_unit gets added to a N bit counter and
> > > that counter overflowing determines the PWM output frequency. Adding 0
> > > to the counter is a no-op. The data-sheet even explicitly states that
> > > writing 0 to the base_unit bits will result in the PWM outputting a
> > > continuous 0 signal.
> > 
> > So, and why it's a problem?
> 
> Lets sya the user requests a PWM output frequency of 100Hz on Cherry Trail
> which has a 19200000 Hz clock this will result in 100 * 65536 / 19200000 =
> 0.3 -> 0 as base-unit value. So instead of getting 100 Hz the user will
> now get a pin which is always outputting low.
> 
> OTOH if we clamp to 1 as lowest value, the user will get 192000000 / 65536
> = 292 Hz as output frequency which is as close to the requested value as
> we can get while actually still working as a PWM controller.

So, we should basically divide and round up, no?

At least for 0 we will get 0.

> > > base_unit values > (base_unit_range / 256), or iow base_unit values using
> > > the 8 most significant bits, cause loss of resolution of the duty-cycle.
> > > E.g. assuming a base_unit_range of 65536 steps, then a base_unit value of
> > > 768 (256 * 3), limits the duty-cycle resolution to 65536 / 768 = 85 steps.
> > > Clamp the max base_unit value to base_unit_range / 32 to ensure a
> > > duty-cycle resolution of at least 32 steps. This limits the maximum
> > > output frequency to 600 KHz / 780 KHz depending on the base clock.
> > 
> > This part I don't understand. Why we limiting base unit? I seems like a
> > deliberate regression.
> 
> The way the PWM controller works is that the base-unit gets added to
> say a 16 bit (on CHT) counter each input clock and then the highest 8
> bits of that counter get compared to the value programmed into the
> ON_TIME_DIV bits.
> 
> Lets say we do not clamp and allow any value and lets say the user
> selects an output frequency of half the input clock, so base-unit
> value is 32768, then the counter will only have 2 values:
> 0 and 32768 after that it will wrap around again. So any on time-div
> value < 128 will result in the output being always high and any
> value > 128 will result in the output being high/low 50% of the time
> and a value of 255 will make the output always low.
> 
> So in essence we now only have 3 duty cycle levels, which seems like
> a bad idea to me / not what a pwm controller is supposed to do.

It's exactly what is written in the documentation. I can't buy base unit clamp.
Though, I can buy, perhaps, on time divisor granularity, i.e.
  1/	0% - 25%-1 (0%)
  2/	25% - 50% - 75% (50%)
  3/	75%+1 - 100% (100%)
And so on till we got a maximum resolution (8 bits).

-- 
With Best Regards,
Andy Shevchenko
