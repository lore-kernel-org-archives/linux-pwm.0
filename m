From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: atmel-hlcdc: Implement the suspend/resume hooks
Date: Thu, 6 Apr 2017 16:16:31 +0200
Message-ID: <20170406141631.GC8438@ulmo.ba.sec>
References: <1488379947-13123-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Md/poaVZ8hnGTzuv"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34806 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934375AbdDFOQe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Apr 2017 10:16:34 -0400
Received: by mail-wr0-f196.google.com with SMTP id u18so3800245wrc.1
        for <linux-pwm@vger.kernel.org>; Thu, 06 Apr 2017 07:16:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1488379947-13123-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 01, 2017 at 03:52:27PM +0100, Boris Brezillon wrote:
> Implement the suspend/resume hooks to make sure the PWM device is
> restored to a correct state after a suspend.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
> This patch depends on the atomic conversion patch [1].
>=20
> [1]https://patchwork.ozlabs.org/patch/734251/
>=20
>  drivers/pwm/pwm-atmel-hlcdc.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)

Applied, thanks.

Thierry

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljmTb8ACgkQ3SOs138+
s6Fmxw/5AdpjAqBJ6Cg1U/JibKuJ/vxJyVZweHqGV/VxbyJhHY5YKe6ouEwIvjhx
D2l/a4ZxeRoerag+QsQfTix0SwBHI5IxgGY987i/iowPcvb2y9wr3hiKLNzVggOX
ujp5kseRKdJz4I3YzWE/VT6gAZoKjJlhBFYciH9UqARqO8KPT/p9vzQHI0AkG0x6
KzV8WcRj7BVoAfmTc85DKSaDs5u3dpjZy1UKIoVlOBHTdG2fczQbG7+ed/8nJqyq
RMXtF+bsjCX7Mlz1rDw4ebO28goIpoWERRO89fzRNWgGuD0ukOsHyVyxXiqezsoU
unIrQiJOT+LwfidmA0SUnrQSRNC+wZwlPgGuUD6/ZtxEcGJ80UzeSSlRpT5A5x9V
6NSbk03Y+7pVhv/apOO9A45pjeug7+qCNdzCkeEnrSa3x1eUeM3+Mc1FW4SQuypn
NC06fuTwxBOdselxFZWstG7Z3uXC4Mi1f3XxPJOB2AwWcYGeDNhOblJ/uw61FePJ
zUThJWWUmUO71Ag5nrWun+ydNP7Aar2qj7ZiWgEgXeIfSj4clbFVfPi7Jx36U9WJ
D1obiam6yCDA1PKqH3llYqsBRnXJEeHWGC89+HDJYVWIPx5rf+JMDuw6JMLY6kty
oKel4czBujwlDlws0HKEelmCxt2QZ7GL+RygrVCXz8A6T9a4ZWc=
=k1Qq
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--
