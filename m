From: =?UTF-8?B?UGhpbGlwcGUgUsOpdG9ybmF6?= <philippe.retornaz@gmail.com>
Subject: Re: [PATCH 1/3] pwm: Add mc13xxx pwm driver.
Date: Wed, 27 Nov 2013 16:58:33 +0100
Message-ID: <529616A9.2090909@gmail.com>
References: <1385566771-366-1-git-send-email-denis@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:42963 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246Ab3K0P6g (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 27 Nov 2013 10:58:36 -0500
In-Reply-To: <1385566771-366-1-git-send-email-denis@eukrea.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Denis Carikli <denis@eukrea.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, devicetree@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org

Hi

> +struct mc13xxx *get_mc13xxx(void)
> +{
> +	return mc13xxx_data;
> +}
> +EXPORT_SYMBOL_GPL(get_mc13xxx);
> +
>   int mc13xxx_common_init(struct mc13xxx *mc13xxx,
>   		struct mc13xxx_platform_data *pdata, int irq)
>   {
> @@ -706,6 +714,9 @@ err_revision:
>   		mc13xxx_add_subdevice(mc13xxx, "%s-pwrbutton");
>   	}
>
> +	/* Linux will not have to handle more than one mc13xxx pmic. */
> +	mc13xxx_data = mc13xxx;
> +

Why using a such hack instead of an MFD subdevice ?

Regards,

Philippe



