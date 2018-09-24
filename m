Return-Path: <andriy.shevchenko@linux.intel.com>
Date: Mon, 24 Sep 2018 12:18:41 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] pwm: lpss: Check PWM powerstate after resume on
 Cherry Trail devices
Message-ID: <20180924091841.GG15943@smile.fi.intel.com>
References: <20180911173050.2374-1-hdegoede@redhat.com>
 <20180911173050.2374-2-hdegoede@redhat.com>
 <20180924090258.GE15943@smile.fi.intel.com>
 <c5eb93ac-c072-2343-5dd6-8642f45db8fb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5eb93ac-c072-2343-5dd6-8642f45db8fb@redhat.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Mon, Sep 24, 2018 at 11:10:28AM +0200, Hans de Goede wrote:

> > > +	/* The PWM may be turned on by AML code, update our state to match */
> > > +	if (pm_runtime_suspended(dev) && lpwm->info->check_power_on_resume) {
> > 
> > > +		status = acpi_evaluate_integer(ACPI_HANDLE(dev), "_PSC",
> > > +					       NULL, &psc);
> > 
> > AFAIU this is a standard power source method for ACPI, shouldn't ACPI core take
> > care of being in sync?
> 
> This is not about ACPI power-resources, this is about the power state (D0 or D3)
> of the device itself. The ACPI core does not expect the state of devices to
> magically change underneath it when using s2idle, since then everything is
> under the kernel's control. But the _PS0 method of the GPU messing with the PWM
> controller (hurray for firmware) messes things up.

What I mean is shouldn't we care about this on a ACPI core level to be sure
that states are kept in sync on OS level?

-- 
With Best Regards,
Andy Shevchenko
