From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] backlight: pwm_bl: Fix broken PWM backlight for non-dt
 platforms
Date: Wed, 16 Dec 2015 16:56:14 +0100
Message-ID: <20151216155614.GI28947@ulmo>
References: <1449738546-10279-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="X+nYw8KZ/oNxZ8JS"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36909 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965780AbbLPP4R (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Dec 2015 10:56:17 -0500
Content-Disposition: inline
In-Reply-To: <1449738546-10279-1-git-send-email-p.zabel@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, kernel@pengutronix.de, linux-kernel@vger.kernel.org


--X+nYw8KZ/oNxZ8JS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 10, 2015 at 10:09:06AM +0100, Philipp Zabel wrote:
> Commit ee65ad0e2a9e ("backlight: pwm_bl: Avoid backlight flicker when
> probed from DT") tries to dereference the device of_node pointer
> unconditionally, causing a NULL pointer dereference on non-dt platforms.
> Fix it by replacing the phandle variable with a node variable and
> by checking that for NULL before dereferencing it.
>=20
> Reported-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/video/backlight/pwm_bl.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--X+nYw8KZ/oNxZ8JS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWcYmeAAoJEN0jrNd/PrOhEqkP/1OGtjtp0iScuqrCTKFZmUF0
NsBd+C3pNEdudODzO7hiTKN0zdtXGteZ3qFDJNjwXIGcVtD1yYV4+Q+tziSBEP5u
3tkTiwTn/f7I4ConM0rOb7uJDgi8R08PSyBzUQPAaQDjGnW+FtoJB0mRiErvR896
EYUAV7oNDP4iJeLRAtu6VsJ+Hb08cy95wwOK4avF3FqgLPOEaVl6FT0PgsGvS220
TsO6Mrs4cnhhSNlFsQ4CJ/jNRXdv4+jUDwnmLdTaf3hOmLClBMPFOacoxmT5SlBA
cAnu12JUaeJGAadN5wUcKXqZfVtn02ij8bU3FPTfKEIKjafLKwaMeyasVa3t4+nE
i7jX4hY8x7AcFNCN3A61ovFjkZP727mGKTRAYKmmGTDkPywctc891b5H9j4zlvRd
V4lWgNx8nvN00443WoBbNIWecXep5hWMUij5fQakrEbXfPIcwxekJaPAIype6s6m
5v7TOlpKjEptxRRU5SBClhADbs8j+if7r4z/lWHPV8tgpGmJdZjfqQ6JHQnJgHFK
E0KhCOijOwvVx6XiAT6/o5sUJ+22WFceaIdjm6i8HFzMKLSpGNP6kTJxq509NWOQ
CtFBuZ4eomoP1tyO4SBV8xW7vVVCZGmTefVUN5Df5LFY95bNPM7dEXFnddzo7RQ5
LJ90uljVyXoukJ1AJV/9
=YMWC
-----END PGP SIGNATURE-----

--X+nYw8KZ/oNxZ8JS--
