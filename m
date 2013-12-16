From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH] pwm: ab8500: Fix wrong value shift for disable/enable pwm
Date: Mon, 16 Dec 2013 16:25:41 +0800
Message-ID: <CAFRkauBoq140S_Xpai0XSG-q3fwC6mw9O8=MzPm7mj4mawwKtw@mail.gmail.com>
References: <1387078339.22351.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:54694 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857Ab3LPIZm (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Dec 2013 03:25:42 -0500
Received: by mail-pd0-f174.google.com with SMTP id y13so4975066pdi.5
        for <linux-pwm@vger.kernel.org>; Mon, 16 Dec 2013 00:25:41 -0800 (PST)
In-Reply-To: <1387078339.22351.2.camel@phoenix>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org

2013/12/15 Axel Lin <axel.lin@ingics.com>:
> Current code only works when pdev->id is 1. Fix it by passing correct bitvalues
> argument to abx500_mask_and_set_register_interruptible.
>
> Having defines for DISABLE_PWM/ENABLE_PWM does not make the code better
> in readability because the bitvalues depends on pdev->id.
> Thus drop defines for DISABLE_PWM/ENABLE_PWM.
>
> This patch also removes a unnecessary return in ab8500_pwm_disable.

Hello Linus,
I don't have the hardware to test and Arun's email bounce back.
So I'd appreciate if you can review and test this patch.

Thanks,
Axel
