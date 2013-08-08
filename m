Return-Path: <linux-pwm-owner@vger.kernel.org>
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:53298 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966335Ab3HHUib (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 8 Aug 2013 16:38:31 -0400
From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] ARM: pxa: make pwm driver module_platform_driver
References: <1375981237-7167-1-git-send-email-mikedunn@newsguy.com>
Date: Thu, 08 Aug 2013 22:38:17 +0200
In-Reply-To: <1375981237-7167-1-git-send-email-mikedunn@newsguy.com> (Mike
	Dunn's message of "Thu, 8 Aug 2013 10:00:37 -0700")
Message-ID: <87fvuj2a12.fsf@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
To: Mike Dunn <mikedunn@newsguy.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@avionic-design.de>, H Hartley Sweeten <hartleys@visionengravers.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <chao.xie@marvell.com>, Eric Miao <eric.y.miao@gmail.com>, Marek Vasut <marex@denx.de>

Mike Dunn <mikedunn@newsguy.com> writes:

> Commit 76abbdde2d95a3807d0dc6bf9f84d03d0dbd4f3d
>
>     pwm: Add sysfs interface
>
> causes a kernel oops due to a null pointer dereference on pxa platforms.  This
> happens because the class added by the patch is registered in a subsys_initcall
> (initcall4), but the pxa pwm driver is registered in arch_initcall (initcall3).
> If the class is not registered before the driver probe function runs, the oops
> occurs in device_add() when the uninitialized pointers in struct class are
> dereferenced.  I don't see a reason that the driver must be an arch_initcall, so
> this patch makes it a regular module_platform_driver (initcall6), preventing the
> oops.

That makes sense.
The only users I'm aware of for PWM on pxa is backlight, and that can certainly
wait for regular driver initcall level. I'm not aware of any usage in early boot
stages.

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

-- 
Robert
