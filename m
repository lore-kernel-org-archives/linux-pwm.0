Return-Path: <rjw@rjwysocki.net>
Return-Path: <rjw@rjwysocki.net>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / LPSS: Only call pwm_add_table() for Bay Trail PWM if PMIC HRV is 2
Date: Sun, 13 May 2018 10:27:15 +0200
Message-ID: <2083673.KvHAAvM7W6@aspire.rjw.lan>
In-Reply-To: <1524231090.21176.475.camel@linux.intel.com>
References: <20180413125417.7263-1-hdegoede@redhat.com> <1524231090.21176.475.camel@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pwm.vger.kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org

On Friday, April 20, 2018 3:31:30 PM CEST Andy Shevchenko wrote:
> On Fri, 2018-04-13 at 14:54 +0200, Hans de Goede wrote:
> > The Point of View mobii wintab p800w Bay Trail tablet comes with a
> > Crystal
> > Cove PMIC, yet uses the LPSS PWM for backlight control, rather then
> > the
> > Crystal Cove's PWM, so we need to call pwm_add_table() to add a
> > pwm_backlight mapping for the LPSS pwm despite there being an INT33FD
> > ACPI device present.
> > 
> > On all Bay Trail devices the _HRV object of the INT33FD ACPI device
> > will normally return 2, to indicate the Bay Trail variant of the CRC
> > PMIC is present, except on this tablet where _HRV is 0xffff. I guess
> > this
> > is a hack to make the windows Crystal Cove PWM driver not bind.
> > 
> > Out of the 44 DSTDs with an INT33FD device in there which I have (from
> > different model devices) only the pov mobii wintab p800w uses 0xffff
> > for
> > the HRV.
> > 
> > The byt_pwm_setup code calls acpi_dev_present to check for the
> > presence
> > of a INT33FD ACPI device which indicates that a CRC PMIC is present
> > and
> > if the INT33FD ACPI device is present then byt_pwm_setup will not add
> > a pwm_backlight mapping for the LPSS pwm, so that the CRC PWM will get
> > used instead.
> > 
> > acpi_dev_present has a hrv parameter, this commit make us pass 2
> > instead
> > of -1, so that things still match on normal tablets, but on this
> > special
> > case with its _HRV of 0xffff, the check will now fail so that the
> > pwm_backlight mapping for the LPSS pwm gets added fixing backlight
> > brightness control on this device.
> > 
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied, thanks!
