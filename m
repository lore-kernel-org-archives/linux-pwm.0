Return-Path: <linux-pwm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:62198 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161356Ab3FUOFO (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 21 Jun 2013 10:05:14 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 00/18] Final Samsung PWM support cleanup
Date: Fri, 21 Jun 2013 16:04:38 +0200
References: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com>
In-Reply-To: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201306211604.38443.arnd@arndb.de>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Heiko =?iso-8859-15?q?St=FCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>, Thierry Reding <thierry.reding@gmail.com>

On Friday 21 June 2013, Tomasz Figa wrote:
> Since we now have a proper Samsung PWM clocksource driver in place,
> we can proceed with further cleanup of PWM timers support on Samsung SoCs.
> 
> This series attempts to achieve this goal by:
>  1) moving remaining Samsung platforms to the new clocksource driver
>  2) removing old clocksource driver
>  3) adding new multiplatform- and DT-aware PWM driver
>  4) moving all Samsung platforms to use the new PWM driver
>  5) removing old PWM driver
>  6) removing all PWM-related code that is not used anymore
> 
> Cleaning up the PWM driver is a bit tricky, because the design of current
> driver makes it completely unsuitable for DT and multiplatform and would
> require a heavy rework to make it usable, breaking any existing Samsung PWM
> users by the way. To avoid any breakage I decided to keep the old driver,
> add new one, move all platforms to it and then remove the old one.
> 
> See particular patches for more detailed descriptions.
> 
> On S3C6410-based Tiny6410 (Mini6410-compatible), after enabling pwm-beeper
> and Exynos4210-based Origen board (with PWM0 attached to a scope):
> 
> Tested-by: Tomasz Figa <tomasz.figa@gmail.com>
> 

Looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>

Two small comments:

* always use 'git format-patch -M' to detect renames (patch 10)

* for new code, don't use __raw_readl and similar functions but
  use readl_relaxed or plain readl.

	Arnd
