From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 10/15] pwm: crc: Implement apply() method to support
 the new atomic PWM API
Date: Tue, 9 Jun 2020 14:32:20 +0300
Message-ID: <20200609113220.GM2428291@smile.fi.intel.com>
References: <20200607181840.13536-1-hdegoede@redhat.com>
 <20200607181840.13536-11-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:14623 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbgFILcV (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 9 Jun 2020 07:32:21 -0400
Content-Disposition: inline
In-Reply-To: <20200607181840.13536-11-hdegoede@redhat.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org

On Sun, Jun 07, 2020 at 08:18:35PM +0200, Hans de Goede wrote:
> Replace the enable, disable and config pwm_ops with an apply op,
> to support the new atomic PWM API.

...

> -static int crc_pwm_calc_clk_div(int period_ns)
> +static int crc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			 const struct pwm_state *state)
>  {
> -	int clk_div;
> -
> -	clk_div = PWM_BASE_CLK_MHZ * period_ns / (256 * NSEC_PER_MHZ);
> -	/* clk_div 1 - 128, maps to register values 0-127 */
> -	if (clk_div > 0)
> -		clk_div--;
> -
> -	return clk_div;
> -}

...

> +		clk_div = PWM_BASE_CLK_MHZ * state->period /
> +			  (256 * NSEC_PER_MHZ);
> +		/* clk_div 1 - 128, maps to register values 0-127 */
> +		if (clk_div > 0)
> +			clk_div--;

And again... :-(

-- 
With Best Regards,
Andy Shevchenko
