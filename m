Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49419 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfHGGd7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Aug 2019 02:33:59 -0400
Date: Wed, 7 Aug 2019 08:33:48 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <20190807063348.vpjh2ptpg7sgy3gm@pengutronix.de>
References: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1562576868-8124-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1562576868-8124-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH RFC 5/7] pwm: rcar: remove a redundant condition in
 rcar_pwm_apply()
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linus.walleij@linaro.org, geert+renesas@glider.be, thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org

Hello,

On Mon, Jul 08, 2019 at 06:07:46PM +0900, Yoshihiro Shimoda wrote:
> Since the rcar_pwm_apply() has already check whehter state->enabled
> is not set or not, this patch removes a redundant condition.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

This patch (and also patch 6 of this series) doesn't seem to have made
it to the pwm list and pwm patchwork.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
