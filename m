From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v2] backlight: pwm: reject legacy pwm request for device defined in dt
Date: Tue, 13 Oct 2015 11:21:04 +0200
Message-ID: <878u775dkv.fsf@belgarion.home>
References: <1444652943-19712-1-git-send-email-vladimir_zapolskiy@mentor.com>
	<561BB2BC.9090907@atmel.com> <20151012153029.62f948d2@bbrezillon>
	<561BBB9F.6060808@mentor.com> <20151012160608.41f04553@bbrezillon>
	<561BC177.2050000@mentor.com> <20151012171931.3fb922d2@bbrezillon>
	<561BD282.70305@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:54385 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559AbbJMJ0g (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Oct 2015 05:26:36 -0400
In-Reply-To: <561BD282.70305@mentor.com> (Vladimir Zapolskiy's message of
	"Mon, 12 Oct 2015 18:32:18 +0300")
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Lee Jones <lee.jones@linaro.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jg1.han@samsung.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org

Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com> writes:

> Robert,
>
> because you found a regression in the related area of code on a
> platform, which uses legacy PWM API, could you please confirm that three
> patches applied in a row don't break anything for you, the changes are:
>
> * Nicolas' 68feaca0b1 ("backlight: pwm: Handle EPROBE_DEFER while
> requesting the PWM")
> * Thierry' https://lkml.org/lkml/2015/10/5/319
> * and this one is the last in the series:
> http://thread.gmane.org/gmane.linux.pwm/2813
I confirm, my backlight works again with it :
Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert
