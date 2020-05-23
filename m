From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 07/32] pwm: mediatek: convert to
 devm_platform_ioremap_resource
Date: Sat, 23 May 2020 19:23:42 +0200
Message-ID: <20200523172342.oiu4jegsh374ytza@pengutronix.de>
References: <20191229080610.7597-1-tiny.windzz@gmail.com>
 <20191229080610.7597-7-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387571AbgEWRYI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 23 May 2020 13:24:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01125C061A0E
        for <linux-pwm@vger.kernel.org>; Sat, 23 May 2020 10:24:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20191229080610.7597-7-tiny.windzz@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: claudiu.beznea@microchip.com, thierry.reding@gmail.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com, nsaenzjulienne@suse.de, shc_work@mail.ru, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, vz@mleia.com, slemieux.tyco@gmail.com, khilman@baylibre.com, matthias.bgg@gmail.com, heiko@sntech.de, palmer@dabbelt.com, paul.walmsley@sifive.com, mripard@kernel.org, wens@csie.org, jonathanh@nvidia.com, linux@prisktech.co.nz, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-amlogic@lists.infradead.

Hello,

On Sun, Dec 29, 2019 at 08:05:45AM +0000, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks,
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
