From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 1/4] pwm: jz4740: Drop dependency on MACH_INGENIC
Date: Mon, 25 May 2020 17:33:33 +0200
Message-ID: <20200525153333.4wsm3dhkdzjjq6pc@pengutronix.de>
References: <20200525125722.36447-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404201AbgEYPdh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 May 2020 11:33:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E57C061A0E
        for <linux-pwm@vger.kernel.org>; Mon, 25 May 2020 08:33:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200525125722.36447-1-paul@crapouillou.net>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

On Mon, May 25, 2020 at 02:57:19PM +0200, Paul Cercueil wrote:
> Depending on MACH_INGENIC prevent us from creating a generic kernel that
> works on more than one MIPS board. Instead, we just depend on MIPS being
> set.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Nitpick: Your S-o-B should come last. So if you added my Ack the
resulting commit then has (after being picked up by a maintainer):

 .	Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
 .	Signed-off-by: Paul Cercueil <paul@crapouillou.net>
 .	Signed-off-by: Peter Maintainer <...>

(quoted to not let patchwork pick up tags) while when the Ack is added
by the maintainer the result is

 .	Signed-off-by: Paul Cercueil <paul@crapouillou.net>
 .	Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
 .	Signed-off-by: Peter Maintainer <...>

. So the order tells the reader who added a tag.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
