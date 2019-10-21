Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60701 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbfJULSt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Oct 2019 07:18:49 -0400
Date: Mon, 21 Oct 2019 13:18:47 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <20191021111847.c5j4qycyqy5wmynh@pengutronix.de>
References: <20191021105830.1357795-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191021105830.1357795-1-thierry.reding@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH] Revert "pwm: Let pwm_get_state() return the last
 implemented state"
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pwm@vger.kernel.org

On Mon, Oct 21, 2019 at 12:58:30PM +0200, Thierry Reding wrote:
> It turns out that commit 01ccf903edd6 ("pwm: Let pwm_get_state() return
> the last implemented state") causes backlight failures on a number of
> boards. The reason is that some of the drivers do not write the full
> state through to the hardware registers, which means that ->get_state()
> subsequently does not return the correct state. Consumers which rely on
> pwm_get_state() returning the current state will therefore get confused
> and subsequently try to program a bad state.
>=20
> Before this change can be made, existing drivers need to be more
> carefully audited and fixed to behave as the framework expects. Until
> then, keep the original behaviour of returning the software state that
> was applied rather than reading the state back from hardware.

I would really prefer to fix that in the framework instead. This is
something that affects several drivers (cros-ec, imx27, atmel, imx-tpm,
lpss, meson, sifive, sprd and stm32-lp). This is im my eyes really
sufficient to justify a framework wide solution instead of adapting
several drivers in a way that doesn't affect the values programmed to
hardware.

> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
