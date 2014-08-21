From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] ARM: at91/tclib: mask interruptions at shutdown and probe
Date: Thu, 21 Aug 2014 05:32:59 +0200
Message-ID: <201408210533.00196.arnd@arndb.de>
References: <1408486072-19268-1-git-send-email-gael.portay@gmail.com> <1408486072-19268-4-git-send-email-gael.portay@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:56205 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbaHUDdp (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 20 Aug 2014 23:33:45 -0400
In-Reply-To: <1408486072-19268-4-git-send-email-gael.portay@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?utf-8?q?Ga=C3=ABl_PORTAY?= <gael.portay@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Boris Brezillon <boris.brezillon@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

On Wednesday 20 August 2014, Ga=C3=ABl PORTAY wrote:
> +static void tc_shutdown (struct platform_device *pdev)
> +{
> +       int i;
> +       struct atmel_tc *tc =3D platform_get_drvdata(pdev);
> +
> +       for (i =3D 0; i < 3; i++)
> +               __raw_writel(0xff, tc->regs + ATMEL_TC_REG(i, IDR));
> +}

In general, __raw_readl/__raw_writel are not meant to be called by devi=
ce drivers.

Just use readl/writel by default, or readl_relaxed/writel_relaxed if th=
e code is
performance critical and you are sure it is safe to use them.

	Arnd
