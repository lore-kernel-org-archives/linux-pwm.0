Return-Path: <rjwysocki@gmail.com>
MIME-Version: 1.0
References: <20181011161444.328-1-hdegoede@redhat.com> <20181011161444.328-2-hdegoede@redhat.com>
 <3023968.j6vFC9EAcd@aspire.rjw.lan> <908aec7b-030e-8cd0-14cf-59ec58bb5a64@redhat.com>
In-Reply-To: <908aec7b-030e-8cd0-14cf-59ec58bb5a64@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 12 Oct 2018 11:35:22 +0200
Message-ID: <CAJZ5v0ji2SOJgwOxTEyasuar1CkreKa9fmLtQTv6L4QsFsk3pg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] ACPI / PM: Export acpi_device_get_power() for use
 by modular build drivers
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pwm.vger.kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thierry Reding <thierry.reding@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Len Brown <lenb@kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Fri, Oct 12, 2018 at 11:29 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 11-10-18 22:37, Rafael J. Wysocki wrote:
> > On Thursday, October 11, 2018 6:14:42 PM CEST Hans de Goede wrote:
> >> Export acpi_device_get_power() for use by modular build drivers.
> >>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> ---
> >> Changes in v4:
> >> -New patch in v4 of this patch-set
> >> ---
> >>   drivers/acpi/device_pm.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> >> index a7c2673ffd36..824ae985ad93 100644
> >> --- a/drivers/acpi/device_pm.c
> >> +++ b/drivers/acpi/device_pm.c
> >> @@ -126,6 +126,7 @@ int acpi_device_get_power(struct acpi_device *device, int *state)
> >>
> >>      return 0;
> >>   }
> >> +EXPORT_SYMBOL(acpi_device_get_power);
> >>
> >>   static int acpi_dev_pm_explicit_set(struct acpi_device *adev, int state)
> >>   {
> >>
> >
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Does this mean that you are ok with taking this patch
> upstream through Thierry's PWM tree ?

Yes, it does.

Thanks,
Rafael
