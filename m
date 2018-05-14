From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/2] pwm: lpss: platform: Save/restore the ctrl
 register over a suspend/resume
Date: Mon, 14 May 2018 14:10:26 +0300
Message-ID: <f7f33c55d61f19769cf055605e32ece76482f74b.camel@linux.intel.com>
References: <20180426121024.22023-1-hdegoede@redhat.com>
         <2943907.WSHDcS9sfS@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <2943907.WSHDcS9sfS@aspire.rjw.lan>
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hans de Goede <hdegoede@redhat.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Thu, 2018-05-10 at 17:25 +0200, Rafael J. Wysocki wrote:
> On Thursday, April 26, 2018 2:10:23 PM CEST Hans de Goede wrote:
> > On some devices the contents of the ctrl register get lost over a
> > suspend/resume and the PWM comes back up disabled after the resume.
> > 
> > This is seen on some Bay Trail devices with the PWM in ACPI
> > enumerated
> > mode, so it shows up as a platform device instead of a PCI device.
> > 
> > If we still think it is enabled and then try to change the duty-
> > cycle
> > after this, we end up with a "PWM_SW_UPDATE was not cleared" error
> > and
> > the PWM is stuck in that state from then on.
> > 
> > This commit adds suspend and resume pm callbacks to the pwm-lpss-
> > platform
> > code, which save/restore the ctrl register over a suspend/resume,
> > fixing
> > this.
> > 
> > Note that:
> > 
> > 1) There is no need to do this over a runtime suspend, since we
> > only runtime suspend when disabled and then we properly set the
> > enable
> > bit and reprogram the timings when we re-enable the PWM.
> > 
> > 2) This may be happening on more systems then we realize, but has
> > been
> > covered up sofar by a bug in the acpi-lpss.c code which was
> > save/restoring
> > the regular device registers instead of the lpss private registers
> > due to
> > lpss_device_desc.prv_offset not being set. This is fixed by a later
> > patch
> > in this series.
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Andy, Thierry, any comments or concerns regarding this series?

Fine by me:
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
