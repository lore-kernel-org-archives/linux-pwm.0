From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 5/6] pwm: mediatek: add PWM_CLK_DIV_MAX
Date: Mon, 21 Aug 2017 09:58:01 +0200
Message-ID: <20170821075801.GO18996@ulmo>
References: <1498802721-32455-1-git-send-email-zhi.mao@mediatek.com>
 <1498802721-32455-6-git-send-email-zhi.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9DptZICXTlJ7FQ09"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38715 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbdHUH6F (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Aug 2017 03:58:05 -0400
Content-Disposition: inline
In-Reply-To: <1498802721-32455-6-git-send-email-zhi.mao@mediatek.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Zhi Mao <zhi.mao@mediatek.com>
Cc: john@phrozen.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, yingjoe.chen@mediatek.com, yt.shen@mediatek.com, sean.wang@mediatek.com, zhenbao.liu@mediatek.com


--9DptZICXTlJ7FQ09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2017 at 02:05:20PM +0800, Zhi Mao wrote:
> 1. Replace "7" with "PWM_CLK_DIV_MAX" in function:mtk_pwm_config()
> to improve the code readablity.
> 2. add pwm clk disable in function:mtk_pwm_config()
> for error parameter checking case.
>=20
> Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
> ---
>  drivers/pwm/pwm-mediatek.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Same comment as before. You've got two logical, unrelated changes in
this one commit. In this case you're mixing a cosmetic change with an
actual bug fix. And to make things worse, the commit subject mentions
only the cosmetic change, while the more important changes is only
described in a drive-by fashion.

You get another free pass this time, but please be more conscious about
these things in the future.

I've applied this to for-4.14/drivers with the following commit message:

--- >8 ---
pwm: mediatek: Disable clock on PWM configuration failure

Make sure to disable the PWM clock if the PWM cannot be configured due
to the clock divider exceeding the maximum value.

While at it, replace the hardcoded maximum clock divider with a defined
constant to improve code readability.

Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
Acked-by: John Crispin <john@phrozen.org>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
--- 8< ---

Thierry

--9DptZICXTlJ7FQ09
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmakokACgkQ3SOs138+
s6FQcRAAkwp+Z6V4L6X9sJ1v/GWyX8gQEiKU1H+5PPJCPvZN+IDyyajGWD8SWFBW
p2oxy+IhQzH7FEOGP/1PV1RZ4I5UNWIrJRi4UqqdiBXJajHoy4d9onLuFsQdcMAX
Q8whQjQTSiIAvULedzd3b17P4xrixjuQp2jiLQTJvVxbJTPc1FH9AXhGVmyQxlYz
MJAvp5NSAf5rRrgNKPFbjI6NJ7sW1nOFp6Bil4yErBl0ZG28eui+AQOIEOhcReoO
PNpISVI6MeszcwZxwnlnNxGFciwleL/+b7428ErbNb4uFiW72M7K1CkSl8a7m2Bv
W52PIvTP4ZEXowlC+NRUjxdJMW+sjvQSz5pXwVR73OOxPj7pkAqN5xvOsovam63S
ZHxgvz4os9681ehZf2ADMhSsXinQGIHtGqvjXTxNIBpVw5FTWiwJZw09393SPtYr
zmpZ0WZRnO5aPAdxpkELozbmZD9QBnDrvlzEdD5Zs3p2KJz8S5tCcP+7W7f053o+
qnjQKw4F9zSBDb5aAiPliwBqNjTls3gcsj272KRpLVuq+4RxGdHoGGnOGavofw92
6m3xNy8AixTNq7FKSvsuhkygI0A0XBFyr4kBTFF1CuofMr/GvTF9IS30Hx2vEisx
JTFGMFBhkxmrmcE3x5NnR942gKHgIY7YiBHJfQqScSZygGZlCDo=
=m7CN
-----END PGP SIGNATURE-----

--9DptZICXTlJ7FQ09--
