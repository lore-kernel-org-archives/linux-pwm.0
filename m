From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 1/3] pwm: lpc32xx: Set PWM_PIN_LEVEL bit to default
 value
Date: Mon, 11 Jul 2016 10:55:23 +0200
Message-ID: <20160711085523.GC5823@ulmo.ba.sec>
References: <1467032997-5340-1-git-send-email-slemieux.tyco@gmail.com>
 <1467032997-5340-2-git-send-email-slemieux.tyco@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37302 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757827AbcGKIz1 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Jul 2016 04:55:27 -0400
Received: by mail-wm0-f43.google.com with SMTP id i5so6812880wmg.0
        for <linux-pwm@vger.kernel.org>; Mon, 11 Jul 2016 01:55:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1467032997-5340-2-git-send-email-slemieux.tyco@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sylvain Lemieux <slemieux.tyco@gmail.com>
Cc: vz@mleia.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 27, 2016 at 09:09:55AM -0400, Sylvain Lemieux wrote:
> From: Sylvain Lemieux <slemieux@tycoint.com>
>=20
> The PWM_PIN_LEVEL bit is leave unset by the kernel PWM driver.
>=20
> Prior to commit 08ee77b5a5de27ad63c92262ebcb4efe0da93b58,
> the PWM_PIN_LEVEL bit was always clear when the PWM was disable
> and a 0 logic level was apply to the output.
>=20
> According to the LPC32x0 User Manual [1],
> the default value for bit 30 (PWM_PIN_LEVEL) is 0.
>=20
> This change initialize the pin level to 0 (default value) and
> update the register value accordingly.
>=20
> [1] http://www.nxp.com/documents/user_manual/UM10326.pdf
>=20
> Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
> ---
> Changes from v1 to v2:
> * Only setup the "PWMx_PIN_LEVEL" once on probe.
>=20
>  drivers/pwm/pwm-lpc32xx.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Applied, thanks.

Thierry

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXg175AAoJEN0jrNd/PrOhkMgP/j5FICIdBwVK8xAVW6YC1qgg
oFXJB5RWbcyu43bQBnCAN67FjPVlDYdRh21mGgxO6KqfOUGuGJUYvJlOYtyCI+ie
Gz3+YL0Zwx3DpzArldKFAjzUyO8VfsCISwmr6UqpWc0wQqdXcHoyHeEz5pUqpH5x
d9iXnxKF4XCB4Cuf6dD01a+vcuYEc+RINJ0VxFICpvaHmJwefAev5kT0CyIxuIMw
6YS+ZKr/M6agYUGVPqfLXmVRT//P5WQs1qn0wKF9uweMmRJlWi8HtmDKIu6QILaR
5m45OePuaQJal7VjPVbzguXyaWizq++fbuB8IK3axEs+4qfLn2OQZwykxXDB069y
dCs2qWbD61QVxEQJcb0LmiX0pxbD+7DrO7CL/3DxvQWCPSTCvsWIYp1A61cjfdRR
rNHPu8EABkX7cCD+coznA2C28XBIrTn0OlICa6Xq0sZC0T/rNH5fVimNXjIoMRtz
wjVq/A70jLpkL1I/OMwvGGJEqHsZwN74r0kPRwMy7n+MTyeEZcsbV7bYHvfZbEY4
vGGPwchFLA5WGgOJQ59ZoKTvCantlYhHAn5TCSDrDjUHgxton1tQTpY2Oa+qdhIs
9ca2mJ8DOqM6nfrjZQDHezQ9LMxXcQhQF2gIEnDFxgg6blI0lw42NoEywN6ndLQG
Ul4/ALN0aKNcufcDC2RD
=Vz2i
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--
