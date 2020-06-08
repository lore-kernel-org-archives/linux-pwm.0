From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 04/15] pwm: lpss: Fix off by one error in base_unit
 math in pwm_lpss_prepare()
Date: Mon, 8 Jun 2020 06:55:12 +0300
Message-ID: <20200608035512.GA2428291@smile.fi.intel.com>
References: <20200607181840.13536-1-hdegoede@redhat.com>
 <20200607181840.13536-5-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:54054 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728763AbgFHDzN (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 7 Jun 2020 23:55:13 -0400
Content-Disposition: inline
In-Reply-To: <20200607181840.13536-5-hdegoede@redhat.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org

On Sun, Jun 07, 2020 at 08:18:29PM +0200, Hans de Goede wrote:
> According to the data-sheet the way the PWM controller works is that
> each input clock-cycle the base_unit gets added to a N bit counter and
> that counter overflowing determines the PWM output frequency.
> 
> So assuming e.g. a 16 bit counter this means that if base_unit is set to 1,
> after 65535 input clock-cycles the counter has been increased from 0 to
> 65535 and it will overflow on the next cycle, so it will overflow after
> every 65536 clock cycles and thus the calculations done in
> pwm_lpss_prepare() should use 65536 and not 65535.
> 
> This commit fixes this. Note this also aligns the calculations in
> pwm_lpss_prepare() with those in pwm_lpss_get_state().

This one sounds like a bug which I have noticed on Broxton (but thought as a
hardware issue). In any case it has to be tested on various platforms to see
how it affects on them.

-- 
With Best Regards,
Andy Shevchenko
