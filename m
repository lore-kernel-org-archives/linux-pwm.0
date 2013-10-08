Return-Path: <thierry.reding@gmail.com>
Date: Tue, 8 Oct 2013 15:50:21 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/3] pwm: mxs: Remove redundant of_match_ptr
Message-ID: <20131008135020.GA16550@ulmo.nvidia.com>
References: <1380511601-20977-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <1380511601-20977-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-pwm.vger.kernel.org>
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pwm@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2013 at 08:56:39AM +0530, Sachin Kamat wrote:
> The data structure of_match_ptr() protects is always compiled in.
> Hence of_match_ptr() is not needed.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/pwm/pwm-mxs.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied (the series), thanks.

Thierry

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSVA2cAAoJEN0jrNd/PrOhEEQP/3oAUvy3bLUgrz3VQWddYhBQ
ralQhxLSvKTWGktWF1nHTrhJ5CxIxgoZn9mEx3ohVK2c/mFJUS593BhOa143kzeV
AtbSZWZqTZvRlw++bUEz+DCuYVe3GQS1DtA/SwWlXbhcQe8kU/nwLTVl8SHM+QfQ
brySe4xkaXzaLGBGHSYN7dgu8HBYXKJ0Xrd1FbV89cqEP7fKnL8FOBDSRjprNWT5
zTPX79g4U8UITiDGrqPeGhR7GLbwPtr0w/BXZODZpzI8laiG5M3DMyNS77kS/FG8
MkC5+S+IrK7JtJDT8fbzej5OaM6UJNq5FCq2+5U3bt8AFmQ2XOk35/GOtXim4I5a
dETSTTTG7HTN/7GZ+o+jtlWlko6DWtkCB9uCUOz0+B7VQFPtG8jm6r0KforrRAWe
4dlgobCc2xWBl7o+T7ww7KaMU/38LonuWBLNQkKRL5iu3LNs0nefKxojZybg/gOy
CCc/0Y7NwZ7QIk8WkfPIuEy+6F0jvSwjVdnrtSyiv77D6EslHW51QVUPu+hXKTiX
S8u1saX3qfgDsSEewXQ9XSIUvylVKU6fvByBvZow20LCuC8Jg5s1LLh8kN+g8fPE
j/IxcR6YPYxDlMhwDtRBSdJGyLrg4sBA9GPZDKQebAZltY1GLtqGFTTyvj1QgJxV
Xyc0HvG9lQef7C6VqM3U
=Y+3g
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
