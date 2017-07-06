From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] video: backlight: pwm_bl.c: make of_device_id structure
 to const
Date: Thu, 6 Jul 2017 11:33:40 +0200
Message-ID: <20170706093340.GA1229@ulmo.fritz.box>
References: <20170705155406.GA22144@lynnl.yet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35498 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbdGFJdt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Jul 2017 05:33:49 -0400
Content-Disposition: inline
In-Reply-To: <20170705155406.GA22144@lynnl.yet>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lynn Lei <lynnl.yet@gmail.com>
Cc: lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, b.zolnierkie@samsung.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2017 at 11:55:09PM +0800, Lynn Lei wrote:
> Fixed a of_device_id structure normally be const warning issue which
> checked by scripts/checkpatch.pl:
>   WARNING: struct of_device_id should normally be const
>=20
> Signed-off-by: Lynn Lei <lynnl.wit@gmail.com>
> ---
>  drivers/video/backlight/pwm_bl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlleA/QACgkQ3SOs138+
s6GcjA//cGVRYBi9YIq09Pmu7kgZ58hRnV+pPObaenm6m+yasbaNmytl8lJn9Nqi
HM9K8ANvAQFIZZ8dwxDEmynPkcBEzyDP/wSwldzLyHzfJhSZrj46pJZXmB6mMYf7
f0pmsxgYwtqHRBEduOSyt8E4UyTVS8raQyh3h5yDsUyNtX83P6wBGaFw2wj0xbTh
aeBQyyH+Yjk+/SNMs84hqvpV0LHYQpttUWSKs1VG1lIglw6Y2RmZhMlXCHLDxMPX
Q4P24TURLITMGxyq+DMJIGfk8dBbShkmsVFVmQh639Bomv6sTTqJ9SK8dL4Bs+lo
Cpa782m69MXxpNtK93YeI3VLt7CzS0XC5y7W6vegyMR9ivAiVQvERCzeADlpPT4Y
TfvUVJhej1YPEISe4u7xp5rFUQLxrnooJ1uNz2CL3rpqozaRuJGsaPDKE+8gnduw
vVTuxRXhfVGUSlvuUhdtUmKDx8ZXu1urlIZ028PUEtRuEHp6GTrbeZcltESUXSsr
Lz4LlAlpXjwJfoexcIZzH10jD4JQsMBt1HW9rIwgtQuMpG0erSxISXMjKWJbsKyJ
Erz/HdYiK9HrtNAyrsBH2jV8AEehweoczoabjXleXXbbJ0frHzhC/EDhAtigsVEm
+KkLc+xy6n3oUos4JzBmOW2Lid5wYR+Au7LROfa5zj4KMwNQTP4=
=Ho0a
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
