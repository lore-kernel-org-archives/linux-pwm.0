From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 13/17] pwm: sti: Add support for PWM Capture IRQs
Date: Mon, 5 Sep 2016 12:53:17 +0200
Message-ID: <20160905105317.GM31424@ulmo.ba.sec>
References: <20160816093508.28307-1-lee.jones@linaro.org>
 <20160816093508.28307-14-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XbHSybK3LHOYQtWI"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160816093508.28307-14-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--XbHSybK3LHOYQtWI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 16, 2016 at 10:35:04AM +0100, Lee Jones wrote:
> Here we're requesting the PWM Capture IRQ and supplying the
> handler which will be called in the event of an IRQ fire to
> handle it.
>=20
> Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/pwm/pwm-sti.c | 92 +++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 91 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry

--XbHSybK3LHOYQtWI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXzU6dAAoJEN0jrNd/PrOhGNsP/2Aee9ZvHM1ZTuFcVzZr9fPF
wvTGzx6Ip4wI8S5JRzpU7/WYlg8CnzFkUU3ETmIXAgiOxehrXbuzURK+KEwlENgc
p3CN7FL5gC4P2tHmNvdPWz50pF7cFj03lQaDeLt3mrpWnLkgC2JJSYwXcVdT2hur
Q5IYGiMjDgkxmrpx6t0pgPPMn2sifpXEByhf4yFbLU3v17XegsJcY21UFSfTyeVi
N82oYhHlLdS4/PxSd7HuJ+6apIHeXSwrWWUFq6bNhM2zG5LhEz1PcyUL+s3sQD7J
UXOzyrjFqlE9FZH3fuPm9mpZudp0uvOLGU+QvtxdbWaMOd1tKAASSu1rKKzivJpH
Nx14T7C6IJoDEcHsTye6F1pAv6OpWLFXbJpMACUr4wHwS59U8ZL7Si1hAvGRZPzG
I+BfflcJNoAFyXMWBr1rGUyvba9KUGhZM+snYITpEbrWFL5d+qAvL1ZlWK6hrzQ1
KjsZkes+OyMl9BRIKrv7m67xrixSv0zZO7mcH3LQtIXIxHHdm5R9ngIMYWPsZ4dc
5oIMB+dqEgF6315FFA0dtFglIeK7hoiEf8coyqELQ5pn5zelSVIi/IfdfhEAYk+Y
otCPY/Q697Lab8GxKv121YJn4trr3O3qL/7oM0VJnXf5Sm9capSVdRRcCUOwc59u
ip5eTXLxDOyW8phkrUhN
=AhFP
-----END PGP SIGNATURE-----

--XbHSybK3LHOYQtWI--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
