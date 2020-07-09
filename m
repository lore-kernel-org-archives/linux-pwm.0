From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 06/16] pwm: lpss: Correct get_state result for
 base_unit == 0
Date: Thu, 9 Jul 2020 17:50:13 +0300
Message-ID: <20200709145013.GA3703480@smile.fi.intel.com>
References: <20200708211432.28612-1-hdegoede@redhat.com>
 <20200708211432.28612-7-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200708211432.28612-7-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Wed, Jul 08, 2020 at 11:14:22PM +0200, Hans de Goede wrote:
> The datasheet specifies that programming the base_unit part of the
> ctrl register to 0 results in a contineous low signal.
> 
> Adjust the get_state method to reflect this by setting pwm_state.period
> to 1 and duty_cycle to 0.

...

> +	if (freq == 0) {
> +		/* In this case the PWM outputs a continous low signal */

> +		state->period = 1;

I guess this should be something like half of the range (so base unit calc
will give 128). Because with period = 1 (too small) it will give too small
base unit (if apply) and as a result we get high frequency pulses.

> +		state->duty_cycle = 0;
> +	} else {
>  		state->period = NSEC_PER_SEC / (unsigned long)freq;
> +		on_time_div *= state->period;
> +		do_div(on_time_div, 255);
> +		state->duty_cycle = on_time_div;
> +	}

-- 
With Best Regards,
Andy Shevchenko
