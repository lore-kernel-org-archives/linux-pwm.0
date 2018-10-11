Return-Path: <rjw@rjwysocki.net>
Return-Path: <rjw@rjwysocki.net>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 1/3] ACPI / PM: Export acpi_device_get_power() for use by modular build drivers
Date: Thu, 11 Oct 2018 22:37:28 +0200
Message-ID: <3023968.j6vFC9EAcd@aspire.rjw.lan>
In-Reply-To: <20181011161444.328-2-hdegoede@redhat.com>
References: <20181011161444.328-1-hdegoede@redhat.com> <20181011161444.328-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pwm.vger.kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org

On Thursday, October 11, 2018 6:14:42 PM CEST Hans de Goede wrote:
> Export acpi_device_get_power() for use by modular build drivers.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v4:
> -New patch in v4 of this patch-set
> ---
>  drivers/acpi/device_pm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index a7c2673ffd36..824ae985ad93 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -126,6 +126,7 @@ int acpi_device_get_power(struct acpi_device *device, int *state)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL(acpi_device_get_power);
>  
>  static int acpi_dev_pm_explicit_set(struct acpi_device *adev, int state)
>  {
> 

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
