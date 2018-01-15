From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] ACPI / LPSS: Do not instiate a platform_dev for devs
 without a mmio resource
Date: Mon, 15 Jan 2018 13:33:45 +0200
Message-ID: <1516016025.7000.992.camel@linux.intel.com>
References: <20180114200148.11771-1-hdegoede@redhat.com>
         <20180115093615.GA27654@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20180115093615.GA27654@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Chen-Yu Tsai <wens@csie.org>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Mon, 2018-01-15 at 11:36 +0200, Mika Westerberg wrote:
> On Sun, Jan 14, 2018 at 09:01:48PM +0100, Hans de Goede wrote:
> > acpi_lpss_create_device() skips handling LPSS devices which do not
> > have
> > a mmio resources in their resource list (typically these devices are
> > disabled by the firmware). But since the LPSS code does not bind to
> > the
> > device, acpi_bus_attach() ends up still creating a platform device
> > for
> > it and the regular platform_driver for the ACPI HID still tries to
> > bind
> > to it.
> > 
> > This happens e.g. on some boards which do not use the pwm-controller
> > and have an empty or invalid resource-table for it. Currently this
> > causes
> > these error messages to get logged:
> > [    3.281966] pwm-lpss 80862288:00: invalid resource
> > [    3.287098] pwm-lpss: probe of 80862288:00 failed with error -22
> > 
> > This commit stops the undesirable creation of a platform_device for
> > disabled LPSS devices by setting pnp.type.platform_id to 0. Note
> > that
> > acpi_scan_attach_handler() also sets pnp.type.platform_id to 0 when
> > there
> > is a matching handler for the device and that handler has no attach
> > callback, so we simply behave as a handler without an attach
> > function
> > in this case.
> > 
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Seems like a good way to fix it IMHO,

Yeah, looks much better for my opinion than previous hack to PWM
platform driver.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
