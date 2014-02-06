From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] backlight: add PWM dependencies
Date: Thu, 06 Feb 2014 17:35:46 +0100
Message-ID: <2319331.qA0baufx1C@wuerfel>
References: <1391518634-6472-1-git-send-email-linus.walleij@linaro.org> <000001cf230c$60ec1ca0$22c455e0$%han@samsung.com> <201402061708.05845.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:57328 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbaBFQf4 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Feb 2014 11:35:56 -0500
In-Reply-To: <201402061708.05845.arnd@arndb.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jingoo Han <jg1.han@samsung.com>, linux-pwm@vger.kernel.org, 'Eric Miao' <eric.y.miao@gmail.com>, 'Linus Walleij' <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, 'Thierry Reding' <thierry.reding@gmail.com>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>

On Thursday 06 February 2014 17:08:05 Arnd Bergmann wrote:
> 
> Finally, I have recently encountered a couple of drivers
> (BACKLIGHT_LM3630A, BACKLIGHT_LP855X, BACKLIGHT_LP8788) that use
> the PWM interfaces but are missing a 'depends on PWM'. This is
> strictly speaking a different problem, but we could try to solve
> it at the same time.
> 

D'oh. I just realized this is the bug that started the thread
with Linus' patch. Apparently I found one more instance that
he didn't find though.

	Arnd
