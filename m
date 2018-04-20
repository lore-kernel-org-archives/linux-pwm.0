Return-Path: <andriy.shevchenko@linux.intel.com>
Message-ID: <1524231090.21176.475.camel@linux.intel.com>
Subject: Re: [PATCH] ACPI / LPSS: Only call pwm_add_table() for Bay Trail
 PWM if PMIC HRV is 2
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 20 Apr 2018 16:31:30 +0300
In-Reply-To: <20180413125417.7263-1-hdegoede@redhat.com>
References: <20180413125417.7263-1-hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
List-ID: <linux-pwm.vger.kernel.org>
To: Hans de Goede <hdegoede@redhat.com>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, 2018-04-13 at 14:54 +0200, Hans de Goede wrote:
> The Point of View mobii wintab p800w Bay Trail tablet comes with a
> Crystal
> Cove PMIC, yet uses the LPSS PWM for backlight control, rather then
> the
> Crystal Cove's PWM, so we need to call pwm_add_table() to add a
> pwm_backlight mapping for the LPSS pwm despite there being an INT33FD
> ACPI device present.
> 
> On all Bay Trail devices the _HRV object of the INT33FD ACPI device
> will normally return 2, to indicate the Bay Trail variant of the CRC
> PMIC is present, except on this tablet where _HRV is 0xffff. I guess
> this
> is a hack to make the windows Crystal Cove PWM driver not bind.
> 
> Out of the 44 DSTDs with an INT33FD device in there which I have (from
> different model devices) only the pov mobii wintab p800w uses 0xffff
> for
> the HRV.
> 
> The byt_pwm_setup code calls acpi_dev_present to check for the
> presence
> of a INT33FD ACPI device which indicates that a CRC PMIC is present
> and
> if the INT33FD ACPI device is present then byt_pwm_setup will not add
> a pwm_backlight mapping for the LPSS pwm, so that the CRC PWM will get
> used instead.
> 
> acpi_dev_present has a hrv parameter, this commit make us pass 2
> instead
> of -1, so that things still match on normal tablets, but on this
> special
> case with its _HRV of 0xffff, the check will now fail so that the
> pwm_backlight mapping for the LPSS pwm gets added fixing backlight
> brightness control on this device.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/acpi_lpss.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index c4ba9164e582..38a286975c31 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -69,6 +69,10 @@ ACPI_MODULE_NAME("acpi_lpss");
>  #define LPSS_SAVE_CTX			BIT(4)
>  #define LPSS_NO_D3_DELAY		BIT(5)
>  
> +/* Crystal Cove PMIC shares same ACPI ID between different platforms
> */
> +#define BYT_CRC_HRV			2
> +#define CHT_CRC_HRV			3
> +
>  struct lpss_private_data;
>  
>  struct lpss_device_desc {
> @@ -162,7 +166,7 @@ static void byt_pwm_setup(struct lpss_private_data
> *pdata)
>  	if (!adev->pnp.unique_id || strcmp(adev->pnp.unique_id, "1"))
>  		return;
>  
> -	if (!acpi_dev_present("INT33FD", NULL, -1))
> +	if (!acpi_dev_present("INT33FD", NULL, BYT_CRC_HRV))
>  		pwm_add_table(byt_pwm_lookup,
> ARRAY_SIZE(byt_pwm_lookup));
>  }
>  

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
