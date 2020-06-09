From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 10/15] pwm: crc: Implement apply() method to support
 the new atomic PWM API
Date: Tue, 9 Jun 2020 16:50:20 +0300
Message-ID: <20200609135020.GP2428291@smile.fi.intel.com>
References: <20200607181840.13536-1-hdegoede@redhat.com>
 <20200607181840.13536-11-hdegoede@redhat.com>
 <20200609113220.GM2428291@smile.fi.intel.com>
 <93c7843d-1225-c8c6-9eb7-1f11b44bec34@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <93c7843d-1225-c8c6-9eb7-1f11b44bec34@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Jun 09, 2020 at 03:44:18PM +0200, Hans de Goede wrote:
> On 6/9/20 1:32 PM, Andy Shevchenko wrote:
> > On Sun, Jun 07, 2020 at 08:18:35PM +0200, Hans de Goede wrote:

...

> > And again... :-(
> 
> Well yes I cannot help it that the original code, as submitted by Intel,
> was of very questionable quality, so instead of just converting it to the
> atomic PWM API I had to do a ton of bugfixes first...   I tried to do
> this all in small bits rather then in a single big rewrite the buggy
> <beep> commit to make life easier for reviewers.

Yes, I know about that old code quality, sorry, we were not at Intel that time
(or were just right-less newbies).

> I can introduce the crc_pwm_calc_clk_div helper earlier as you suggested
> in an earlier mail. I guess I could also keep the helper here, and then
> fold it into the function in a later commit (*).
> 
> Would that work for you ?

Definitely.

> *) Because having a helper for 3 lines of code when it is used only
> once is not helpful IMHO, it only makes it harder to figure out what
> the code is exactly doing when readin the code.

At least it will reduce churn to just

1) introduce foo();
2) do many changes with foo() being used;
3) drop foo() *if* it's not needed / makes little sense.

-- 
With Best Regards,
Andy Shevchenko
