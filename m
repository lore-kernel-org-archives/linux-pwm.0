From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] backlight: add PWM dependencies
Date: Fri, 7 Feb 2014 10:40:57 +0100
Message-ID: <201402071040.58087.arnd@arndb.de>
References: <1391518634-6472-1-git-send-email-linus.walleij@linaro.org> <201402061708.05845.arnd@arndb.de> <000d01cf23b1$7c1f8de0$745ea9a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:59768 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbaBGJla (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Feb 2014 04:41:30 -0500
In-Reply-To: <000d01cf23b1$7c1f8de0$745ea9a0$%han@samsung.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Thierry Reding' <thierry.reding@gmail.com>, 'Linus Walleij' <linus.walleij@linaro.org>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'Eric Miao' <eric.y.miao@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org

On Friday 07 February 2014, Jingoo Han wrote:
> How about the following?
> 
>   [PATCH 1/7] ARM: pxa: don't select HAVE_PWM
>   [PATCH 2/7] ARM: lpc32xx: don't select HAVE_PWM
>   [PATCH 3/7] ARM: remove HAVE_PWM config option
>   [PATCH 4/7] MIPS: jz4740: don't select HAVE_PWM
>   [PATCH 5/7] Input: max8997_haptic: remove HAVE_PWM dependencies
>   [PATCH 6/7] Input: pwm-beepe: remove HAVE_PWM dependencies
>   [PATCH 7/7] pwm: don't use IS_ENABLED(CONFIG_HAVE_PWM)
> 
> I would like to merge it through PWM tree.
> After merging these patches, all HAVE_PWM will be removed from
> the mainline kernel. Thank you. :-)

Sounds godo to me, thanks a lot for taking care of this!
I don't see any inter-dependencies between the various patches,
so we could also take the first three through the arm-soc tree
to avoid conflicts with other changes (or possibly the third
one through rmk's ARM tree, if he prefers).

	Arnd
