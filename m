From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 3/3] pwm: mxs: Remove unused include of of_address.h
Date: Wed, 26 Feb 2020 17:14:21 +0100
Message-ID: <20200226161421.pbvv4yxjztfq7bxn@pengutronix.de>
References: <1582271129-13589-1-git-send-email-Anson.Huang@nxp.com>
 <1582271129-13589-3-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36219 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbgBZQOZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Feb 2020 11:14:25 -0500
Content-Disposition: inline
In-Reply-To: <1582271129-13589-3-git-send-email-Anson.Huang@nxp.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Anson Huang <Anson.Huang@nxp.com>
Cc: thierry.reding@gmail.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Linux-imx@nxp.com

Hello,

On Fri, Feb 21, 2020 at 03:45:29PM +0800, Anson Huang wrote:
> There is nothing in use from of_address.h, remove it.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/pwm/pwm-mxs.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
> index f2e57fc..7ce6169 100644
> --- a/drivers/pwm/pwm-mxs.c
> +++ b/drivers/pwm/pwm-mxs.c
> @@ -9,7 +9,6 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_address.h>
>  #include <linux/platform_device.h>
>  #include <linux/pwm.h>
>  #include <linux/slab.h>

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
