Return-Path: <andriy.shevchenko@linux.intel.com>
Message-ID: <1524675075.21176.611.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] ACPI / LPSS: Add missing prv_offset setting for
 byt/cht PWM devices
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Wed, 25 Apr 2018 19:51:15 +0300
In-Reply-To: <20180413125218.7131-3-hdegoede@redhat.com>
References: <20180413125218.7131-1-hdegoede@redhat.com>
	 <20180413125218.7131-3-hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
List-ID: <linux-pwm.vger.kernel.org>
To: Hans de Goede <hdegoede@redhat.com>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, 2018-04-13 at 14:52 +0200, Hans de Goede wrote:
> The LPSS PWM device on on Bay Trail and Cherry Trail devices has a set
> of private registers at offset 0x800, the current lpss_device_desc for
> them already sets the LPSS_SAVE_CTX flag to have these saved/restored
> over device-suspend, but the current lpss_device_desc was not setting
> the prv_offset field, leading to the regular device registers getting
> saved/restored instead.
> 
> This is causing the PWM controller to no longer work, resulting in a
> black
> screen,  after a suspend/resume on systems where the firmware clears
> the
> APB clock and reset bits at offset 0x804.
> 
> This commit fixes this by properly setting prv_offset to 0x800 for
> the PWM devices.
> 

Shouldn't be Fixes tag here?

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/acpi_lpss.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 2bcffec8dbf0..c4ba9164e582 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -229,11 +229,13 @@ static const struct lpss_device_desc
> lpt_sdio_dev_desc = {
>  
>  static const struct lpss_device_desc byt_pwm_dev_desc = {
>  	.flags = LPSS_SAVE_CTX,
> +	.prv_offset = 0x800,
>  	.setup = byt_pwm_setup,
>  };
>  
>  static const struct lpss_device_desc bsw_pwm_dev_desc = {
>  	.flags = LPSS_SAVE_CTX | LPSS_NO_D3_DELAY,
> +	.prv_offset = 0x800,
>  	.setup = bsw_pwm_setup,
>  };
>  

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
