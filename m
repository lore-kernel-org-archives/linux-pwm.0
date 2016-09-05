From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 08/17] pwm: sti: Reorganise register names in
 preparation for new functionality
Date: Mon, 5 Sep 2016 12:35:54 +0200
Message-ID: <20160905103554.GH31424@ulmo.ba.sec>
References: <20160816093508.28307-1-lee.jones@linaro.org>
 <20160816093508.28307-9-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Hlh2aiwFLCZwGcpw"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160816093508.28307-9-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--Hlh2aiwFLCZwGcpw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 16, 2016 at 10:34:59AM +0100, Lee Jones wrote:
> Exciting functionality is on the way to this device.  But
> before we can add it, we need to do some basic housekeeping
> so the additions can be added cleanly.
>=20
> Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/pwm/pwm-sti.c | 76 +++++++++++++++++++++++++++------------------=
------
>  1 file changed, 41 insertions(+), 35 deletions(-)

Applied, thanks.

Thierry

--Hlh2aiwFLCZwGcpw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXzUqKAAoJEN0jrNd/PrOhdOgQALl/toKGiBLHeBR67Spszu76
giN7ff49vqlJku1s2MFDt1acTQ4nwM5lKBMX/7MDqs+68LV29osskCcnPTB429sv
nZL52UEmehbaQpQUmUsllP42/KiwYQBDvCyybUY9VKjyLgph5Z6pdyR/TqsmzKgp
MQ8yDO34g36xc0QOuyFzx0n4abaoy6QV5VXxOcoWH73ETbaOwjx5p+xKqLuLWERb
nZwIEvKQiIFYkGDp4+G7RNHxhfS0m0SA/8xCW5HFqACdaXLDOCYW7MeoyAJT5JZu
oM49/4fnDFcQjb/oJET2ZrozlOUMapshqIljYppPN/jMnPj6ei+zhm3jfxFTIa9u
yas6gJdqCyxPBm4yaHK426CEXmKQbps0YF9WJ1hZRRgo0ms+xPjmdKKONXKdbVha
uJAcEoMLmPZHg+USNw7sWu0opkSaNx8uc3f2N+74QoL/fovYcDmv2j5SfbVcHQcg
PjiJiXxrgobED0eu2uRR2EX+ytUYkL+vGWa/9iyqAurX7CnhcIWYPSDa1VUZGNzT
uZads1BlnnsGIiIqoiN40b6VmJP5lhOTeZ91tWGW3zugFsvgICDIBJZ12/4Z0sbD
y5qR19paAc6g23Y2QVvfNBjOMniljOSoKwH0CV3KnwPWZCJH7V4sXIA0JzygHKJy
bhVXT2k4qNTt/6MQUfQF
=i7RG
-----END PGP SIGNATURE-----

--Hlh2aiwFLCZwGcpw--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
