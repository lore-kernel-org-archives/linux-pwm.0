Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37855 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfAHHtn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Jan 2019 02:49:43 -0500
Date: Tue, 8 Jan 2019 08:49:40 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <20190108074940.c24bwov6uzotlmxg@pengutronix.de>
References: <1546918094-13960-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1546918094-13960-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1546918094-13960-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH v2 4/4] pwm: rcar: improve calculation of divider
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org

On Tue, Jan 08, 2019 at 12:28:14PM +0900, Yoshihiro Shimoda wrote:
> The rcar_pwm_get_clock_division() has a loop to calculate the divider,
> but the value of div should be calculatable without a loop. So,
> this patch improves it.
>=20
> This algorithm is suggested by Uwe Kleine-K=F6nig and Laurent Pinchart.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
