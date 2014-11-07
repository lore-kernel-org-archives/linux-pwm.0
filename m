From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/2] backlight: pwm: don't call legacy pwm request for
 device defined in dt
Date: Fri, 7 Nov 2014 14:48:50 +0100
Message-ID: <20141107134848.GB31950@ulmo>
References: <1413035186-11771-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1413035186-11771-2-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:35363 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbaKGNsx (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Nov 2014 08:48:53 -0500
Content-Disposition: inline
In-Reply-To: <1413035186-11771-2-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 11, 2014 at 04:46:25PM +0300, Vladimir Zapolskiy wrote:
> Platform PWM backlight data provided by board's device tree should be
> complete enough to successfully request a pwm device using pwm_get() API.
>=20
> Based on initial implementation done by Dmitry Eremin-Solenikov.
>=20
> Reported-by: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Bryan Wu <cooloney@gmail.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/video/backlight/pwm_bl.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

I don't really understand what this is supposed to do. The commit
message doesn't make a very good job of explaining it either.

Can you describe in more detail what problem this fixes and why it
should be merged?

Thierry

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUXM3AAAoJEN0jrNd/PrOh8EYP/2RnbtrzM98io/9GXedialfO
jQr4Odz44hCEK6RyBOa3tFRjLB+ou9SWg+LZeiIuPJ0eycIMzym/AL4ywelK6n3/
QiHV/dO+wLE6QEfu99R3OAp8sCur3u99U/jzHt146jnBamePsgEdjqLOglDs9Xrk
lb8uhU7yn3fj+ue+e4FuVNqzCeVzcOuVZgtHS82sG87MK21ZkxC8zdSYzA/K5O+V
Kde3vozsc1HooCmiXGs8qd4ttT5+ZN8CByz6W6KSyxbQlde8gVONFiT4Oghfv2f5
Nf2Nu/pC3CI06NOZRXxpBX1Pt4tCBS2vzlFhwmmiXG9mn63Us0hzhhusjuFEnZju
X7pE5jLSaALYgLySicwPRFfMvKF23aSYEJHgiPqOXNilYE2ZMnGemovHpzVV+6iu
joYXQYl+xLj2GOvExVgyF/QlPLeIGijTJrANlmttDwZwvDrRmwgZzJGvANOkUw9s
4E1bhYoEx4Kezlcu7C5iN8j/wPQMHFPZKon3bHOxLX7u86aEJX+WFYKcwuxnlNHU
DxkyE7oq8XXy7R4RuZpl719HHR2jkdqoP+jb1sxrYMDpAMShAwHmXYekri72Yg9t
PeMrPKGUnW9ap5FFufA6DQV2rDEVabgyM8djmt5qJXJObt7+D8ZAkNtBD4Wq+MNV
sv7EIqQi/SvIruFH/rqk
=dWdb
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--
