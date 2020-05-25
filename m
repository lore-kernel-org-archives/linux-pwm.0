From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 2/4] pwm: jz4740: Enhance precision in calculation of
 duty cycle
Date: Mon, 25 May 2020 17:38:16 +0200
Message-ID: <20200525153815.fthxiuzhsgj24kyo@pengutronix.de>
References: <20200525125722.36447-1-paul@crapouillou.net>
 <20200525125722.36447-2-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404040AbgEYPiT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 May 2020 11:38:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7772DC061A0E
        for <linux-pwm@vger.kernel.org>; Mon, 25 May 2020 08:38:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200525125722.36447-2-paul@crapouillou.net>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 02:57:20PM +0200, Paul Cercueil wrote:
> Calculating the hardware value for the duty from the hardware value of
> the period resulted in a precision loss versus calculating it from the
> clock rate directly.
> 
> (Also remove a cast that doesn't really need to be here)
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v2: New patch. I don't consider this a fix but an enhancement, since the old
>     	behaviour was in place since the driver was born in ~2010, so no Fixes tag.

I would not hesitate and add:

	Fixes: f6b8a5700057 ("pwm: Add Ingenic JZ4740 support")

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks for picking this up,
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
