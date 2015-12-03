From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] pwm: lpss: select core part automatically
Date: Thu, 3 Dec 2015 11:28:04 +0200
Message-ID: <20151203092804.GV1593@lahna.fi.intel.com>
References: <1447845918-66691-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8200 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755676AbbLCJbB (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Thu, 3 Dec 2015 04:31:01 -0500
Content-Disposition: inline
In-Reply-To: <1447845918-66691-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Qipeng Zha <qipeng.zha@intel.com>, linux-pwm@vger.kernel.org

Ping?

On Wed, Nov 18, 2015 at 01:25:17PM +0200, Mika Westerberg wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> We have two users of core part right now. Let them to select core part
> automatically.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pwm/Kconfig | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 2f4641a0e88b..aef635b7e2d1 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -222,18 +222,12 @@ config PWM_LPC32XX
>  	  will be called pwm-lpc32xx.
>  
>  config PWM_LPSS
> -	tristate "Intel LPSS PWM support"
> -	depends on X86
> -	help
> -	  Generic PWM framework driver for Intel Low Power Subsystem PWM
> -	  controller.
> -
> -	  To compile this driver as a module, choose M here: the module
> -	  will be called pwm-lpss.
> +	tristate
>  
>  config PWM_LPSS_PCI
>  	tristate "Intel LPSS PWM PCI driver"
> -	depends on PWM_LPSS && PCI
> +	depends on X86 && PCI
> +	select PWM_LPSS
>  	help
>  	  The PCI driver for Intel Low Power Subsystem PWM controller.
>  
> @@ -242,7 +236,8 @@ config PWM_LPSS_PCI
>  
>  config PWM_LPSS_PLATFORM
>  	tristate "Intel LPSS PWM platform driver"
> -	depends on PWM_LPSS && ACPI
> +	depends on X86 && ACPI
> +	select PWM_LPSS
>  	help
>  	  The platform driver for Intel Low Power Subsystem PWM controller.
>  
> -- 
> 2.6.2
