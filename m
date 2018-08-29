Return-Path: <andriy.shevchenko@linux.intel.com>
Date: Wed, 29 Aug 2018 19:45:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] pwm: lpss: Add ACPI HID for second PWM controller on
 Cherry Trail devices
Message-ID: <20180829164550.GA11447@smile.fi.intel.com>
References: <20180827075233.6408-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827075233.6408-1-hdegoede@redhat.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org

On Mon, Aug 27, 2018 at 09:52:33AM +0200, Hans de Goede wrote:
> The second PWM controller on Cherry Trail devices uses a separate ACPI
> HID: "80862289", add this so that the driver will properly bind to the
> second PWM controller.
> 
> The second PWM controller is usually not used, the main thing gained by
> this is properly putting the PWM controller in D3 on suspend.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/pwm/pwm-lpss-platform.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
> index 5561b9e190f8..7304f36ee715 100644
> --- a/drivers/pwm/pwm-lpss-platform.c
> +++ b/drivers/pwm/pwm-lpss-platform.c
> @@ -81,6 +81,7 @@ static SIMPLE_DEV_PM_OPS(pwm_lpss_platform_pm_ops,
>  static const struct acpi_device_id pwm_lpss_acpi_match[] = {
>  	{ "80860F09", (unsigned long)&pwm_lpss_byt_info },
>  	{ "80862288", (unsigned long)&pwm_lpss_bsw_info },
> +	{ "80862289", (unsigned long)&pwm_lpss_bsw_info },
>  	{ "80865AC8", (unsigned long)&pwm_lpss_bxt_info },
>  	{ },
>  };
> -- 
> 2.18.0
> 

-- 
With Best Regards,
Andy Shevchenko
