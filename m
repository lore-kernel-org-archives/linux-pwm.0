Return-Path: <thierry.reding@gmail.com>
Date: Wed, 14 Aug 2013 11:46:22 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: tiecap: add CONFIG_PM_SLEEP to
 ecap_pwm_{save,restore}_context()
Message-ID: <20130814094621.GE2084@ulmo>
References: <000901ce8f47$1a3e17d0$4eba4770$@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ns7jmDPpOpCD+GE/"
Content-Disposition: inline
In-Reply-To: <000901ce8f47$1a3e17d0$4eba4770$@samsung.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Thierry Reding' <thierry.reding@avionic-design.de>, linux-pwm@vger.kernel.org, Philip Avinash <avinashphilip@ti.com>


--Ns7jmDPpOpCD+GE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 02, 2013 at 03:11:18PM +0900, Jingoo Han wrote:
> ecap_pwm_save_context() and ecap_pwm_restore_context() are only used
> when CONFIG_PM_SLEEP is selected.
>=20
> drivers/pwm/pwm-tiecap.c:293:13: warning: 'ecap_pwm_save_context' defined=
 but not used [-Wunused-function]
> drivers/pwm/pwm-tiecap.c:302:13: warning: 'ecap_pwm_restore_context' defi=
ned but not used [-Wunused-function]
>=20
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/pwm/pwm-tiecap.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--Ns7jmDPpOpCD+GE/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSC1HtAAoJEN0jrNd/PrOh4uAP/2GNt6fRL/ME/gToe4K33BF/
Kk3VxrdZBD8Fpf1qUsp8Q61bAGkAw7B+yfhpOZe52G0xXJALKVmrFTjyJoQAnWZW
oDOx0Ithr3rn8AMmY8jStpdVhy5KNGZLhGD+E6+Cb9fbdKi1LvEpVJ8y69TMoWfZ
yz2lYr53ovqx5H9eg/U/5VtJpF7Zfc5VoQb/q8/+JLCfu3ZUUsCBPcHF5ssVrMtD
du3BK+hYsnpn5RBS7zBSH5KhyyBVQHfQe0lMTTabt1AEd9YGJtn2nc6e/grzTQ9d
mCDt5TJbXWuNvLVaxbuyuCNZcrc9aNIT9INKHYxfsV5iUEwTEUZqiH/Hfy3YomGm
dSmRt4m3HW9iJc75XVh98ikK0wIpihZpu8in3UDUXttBfZVH3nLfCNgGK+onga5X
c5rF2u7NoGprZzYs5COHZVVh3PfjOXR7V+lstxMyxVwGccW4O4MCzlX4PAhFVZQZ
QMo6yEojByoriD01+YitR6KCf1peo5P4+jp2ZwCwJ6vGaUiUaX5aY+LIE7c6rBzs
7t783pZNki1DRhK46ZDPWj2AI2dR/+4miUo+U03S6eFA7xk1/n3pjAeTJ84wrVyM
QfQnmB8VcXwW46lCkxWe/ukRrgtR0y3pt9LekK68Td5TJIUm/deIgo6FzmzItMmL
tad6d8J4AETwAhLMBpiR
=ZXjA
-----END PGP SIGNATURE-----

--Ns7jmDPpOpCD+GE/--
