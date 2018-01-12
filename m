From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] pwm: lpss-platform: Cleanly exit probe on boards
 without resources
Date: Fri, 12 Jan 2018 15:04:51 +0200
Message-ID: <1515762291.7000.947.camel@linux.intel.com>
References: <20180112113802.3888-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:14801 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753875AbeALNNJ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 12 Jan 2018 08:13:09 -0500
In-Reply-To: <20180112113802.3888-1-hdegoede@redhat.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

+Cc: Mika

On Fri, 2018-01-12 at 12:38 +0100, Hans de Goede wrote:
> Some boards which do not use the pwm-controller have an empty or
> invalid
> resource-table in ACPI the for pwm-controller. Currently this causes
> these
> error messages to get logged:
> [    3.281966] pwm-lpss 80862288:00: invalid resource
> [    3.287098] pwm-lpss: probe of 80862288:00 failed with error -22
> 
> This commit silences these error messages on these boards by cleanly
> exiting pwm_lpss_probe_platform() if there is no memory resource.
> 

I don't see anything wrong with message per se.

> +
> +	/*
> +	 * Some boards which don't use the pwm controller have an
> empty
> +	 * resources table, so if we cannot get the resource, return
> -ENODEV.
> +	 */
>  	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!r)
> +		return -ENODEV;

But this one looks like a quirk for some platforms when other can
survive without.

Can we actually check this in acpi_lpss.c and prevent platform device
registration at all?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
