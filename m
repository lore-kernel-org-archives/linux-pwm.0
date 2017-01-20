From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] pwm: lpss: Add Intel Gemini Lake PCI ID
Date: Fri, 20 Jan 2017 12:25:33 +0200
Message-ID: <1484907933.2133.266.camel@linux.intel.com>
References: <20170104154334.29046-1-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:14472 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751581AbdATKZj (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 20 Jan 2017 05:25:39 -0500
In-Reply-To: <20170104154334.29046-1-mika.westerberg@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org

On Wed, 2017-01-04 at 18:43 +0300, Mika Westerberg wrote:
> Intel Gemini Lake PWM is pretty much same as used in Intel Broxton.
> Add
> this new PCI ID to the list of supported devices.
> 

Since we didn't yet settle the dependence series, I will incorporate
your patch in the next version of that series.

Change looks good to me!

> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> Hi, this is on top of Andy's series here:
> 
> https://patchwork.ozlabs.org/patch/710104/
> https://patchwork.ozlabs.org/patch/710107/
> https://patchwork.ozlabs.org/patch/710105/
> https://patchwork.ozlabs.org/patch/710106/
> 
>  drivers/pwm/pwm-lpss-pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
> index dfe0a2e8e4de..2c2ca370dc26 100644
> --- a/drivers/pwm/pwm-lpss-pci.c
> +++ b/drivers/pwm/pwm-lpss-pci.c
> @@ -78,6 +78,7 @@ static const struct pci_device_id pwm_lpss_pci_ids[]
> = {
>  	{ PCI_VDEVICE(INTEL, 0x1ac8), PWM_LPSS_BXT },
>  	{ PCI_VDEVICE(INTEL, 0x2288), PWM_LPSS_BSW },
>  	{ PCI_VDEVICE(INTEL, 0x2289), PWM_LPSS_BSW },
> +	{ PCI_VDEVICE(INTEL, 0x31c8), PWM_LPSS_BXT },
>  	{ PCI_VDEVICE(INTEL, 0x5ac8), PWM_LPSS_BXT },
>  	{ },
>  };

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
