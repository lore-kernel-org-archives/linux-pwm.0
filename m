Return-Path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:55909 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030439Ab3HIHW3 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Aug 2013 03:22:29 -0400
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] ARM: pxa: make pwm driver module_platform_driver
Date: Fri, 9 Aug 2013 09:22:25 +0200
References: <1375981237-7167-1-git-send-email-mikedunn@newsguy.com>
In-Reply-To: <1375981237-7167-1-git-send-email-mikedunn@newsguy.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201308090922.26194.marex@denx.de>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
To: Mike Dunn <mikedunn@newsguy.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@avionic-design.de>, H Hartley Sweeten <hartleys@visionengravers.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <chao.xie@marvell.com>, Eric Miao <eric.y.miao@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>

Dear Mike Dunn,

> Commit 76abbdde2d95a3807d0dc6bf9f84d03d0dbd4f3d
> 
>     pwm: Add sysfs interface
> 
> causes a kernel oops due to a null pointer dereference on pxa platforms. 
> This happens because the class added by the patch is registered in a
> subsys_initcall (initcall4), but the pxa pwm driver is registered in
> arch_initcall (initcall3). If the class is not registered before the
> driver probe function runs, the oops occurs in device_add() when the
> uninitialized pointers in struct class are dereferenced.  I don't see a
> reason that the driver must be an arch_initcall, so this patch makes it a
> regular module_platform_driver (initcall6), preventing the oops.
> 
> Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
> ---
>  drivers/pwm/pwm-pxa.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
> index dc97175..a4d2164 100644
> --- a/drivers/pwm/pwm-pxa.c
> +++ b/drivers/pwm/pwm-pxa.c
> @@ -182,16 +182,6 @@ static struct platform_driver pwm_driver = {
>  	.id_table	= pwm_id_table,
>  };
> 
> -static int __init pwm_init(void)
> -{
> -	return platform_driver_register(&pwm_driver);
> -}
> -arch_initcall(pwm_init);
> -
> -static void __exit pwm_exit(void)
> -{
> -	platform_driver_unregister(&pwm_driver);
> -}
> -module_exit(pwm_exit);
> +module_platform_driver(pwm_driver);
> 
>  MODULE_LICENSE("GPL v2");

Acked-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
