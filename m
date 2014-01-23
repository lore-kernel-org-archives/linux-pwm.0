From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH Resend 1/2] pwm: atmel: Remove redundant of_match_ptr
 helper
Date: Thu, 23 Jan 2014 13:44:06 +0100
Message-ID: <20140123124405.GA28527@ulmo.nvidia.com>
References: <1390474715-6587-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:62714 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798AbaAWMoK (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 23 Jan 2014 07:44:10 -0500
Received: by mail-bk0-f43.google.com with SMTP id mx11so329788bkb.16
        for <linux-pwm@vger.kernel.org>; Thu, 23 Jan 2014 04:44:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1390474715-6587-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pwm@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2014 at 04:28:34PM +0530, Sachin Kamat wrote:
> 'atmel_pwm_dt_ids' is always compiled in. Hence the
> helper macro is not needed.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/pwm/pwm-atmel.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi Sachin,

Sorry for taking so long to look at this, things have been pretty
busy...

> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> index bf4144a14661..45f0fb793528 100644
> --- a/drivers/pwm/pwm-atmel.c
> +++ b/drivers/pwm/pwm-atmel.c
> @@ -381,7 +381,7 @@ static int atmel_pwm_remove(struct platform_device *p=
dev)
>  static struct platform_driver atmel_pwm_driver =3D {
>  	.driver =3D {
>  		.name =3D "atmel-pwm",
> -		.of_match_table =3D of_match_ptr(atmel_pwm_dt_ids),
> +		.of_match_table =3D atmel_pwm_dt_ids,
>  	},
>  	.id_table =3D atmel_pwm_devtypes,
>  	.probe =3D atmel_pwm_probe,

Given that the driver doesn't depend on OF, I think the right thing to
do here would be to #ifdef the atmel_pwm_dt_ids so it doesn't waste
needless memory.

See also my comment to patch 2/2 that I'm about to send out.

Thierry

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4Q6VAAoJEN0jrNd/PrOhFqoP/iU0Mk9WhOaN/mAPtWk6KgRd
jN94C2ph6s3raAawZLBQmAqGIiauNa01woxdlQU9qWW+YOAvcE+LBwI5htv8fsjb
oM6joSX4aaZ8hRYV34dQmzwl80kEdRtTWbjlRjad40IuAIN8872l8rXDsonjK042
ZVdeC9nwKsee8tmEmO4iQWHHvErVDGh2KUL9qgl3lUSdLu1hS41dqPmT67OWapnf
mFsDeP+bwu+W9G7v6YgVFukP25ikafHMaBrLx4Tri/rq3L1UmSM6+jPe9nnZCoHx
3a5V0QAzHwEBNlerRBsvTElDZ3gybq5TIaKw9oK5TnQAfGSeSq7Pn78KHRSZPHl0
aSHteM2gtrlO20SQg+e7zSpJLAi3qbOs9N3zU7ir+qAsbxfISNLNqKdh6cXxmMAS
fQhZtQ+iLDKX3g19CKNkIFx0aXqt8De9s4j1mNiKyhvZ6+vUuQpDsSfwxwVBtffd
+E5ElblnjftAhZ0eYp2eMKtTiFKncIg0RLjC4bB6b5A5wSY63EMvy7VfYCQzfTID
J3f6+1y3lBq1khr3Eu38cYEZAggjR5sstzN/SwpGnZG+3AYp63LDY/qiMXsQuk4d
kAt5tCHpK+ndcW6sX/y3e3uB7eioF8ha9HixrrQu6x1HDqG+17cU6pQE38XOZ4eT
4tnavLbfRXfA/872PUjC
=HMGL
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
