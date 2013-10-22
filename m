Return-Path: <thierry.reding@gmail.com>
Date: Tue, 22 Oct 2013 09:39:21 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm_backlight: avoid short blank screen while doing
 hibernation
Message-ID: <20131022073916.GC8681@ulmo.nvidia.com>
References: <1381285982-18670-1-git-send-email-Baohua.Song@csr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
Content-Disposition: inline
In-Reply-To: <1381285982-18670-1-git-send-email-Baohua.Song@csr.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Barry Song <21cnbao@gmail.com>
Cc: linux-pwm@vger.kernel.org, workgroup.linux@csr.com, Huayi Li <huayi.li@csr.com>, Barry Song <Baohua.Song@csr.com>


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2013 at 10:33:02AM +0800, Barry Song wrote:
> From: Huayi Li <huayi.li@csr.com>
>=20
> Use SIMPLE_DEV_PM_OPS macro will initialize the member "freeze"
> and "thaw" of pwm_backlight_pm_ops as below,
> 	.freeze =3D suspend_fn,
> 	.thaw =3D resume_fn,
> then during the process of making hibernation snapshot, screen
> will be blank at the moment of freezing, and then light at the
> moment of thawing.
> this is not the right user experience for suspending to disk.
>=20
> so this patch drops freeze and thaw callback, make the LCD is
> always lighting before the final shutdown.
>=20
> Signed-off-by: Huayi Li <huayi.li@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  -v2: move the #ifdef inside of the pwm_backlight_pwm_ops so that we
>  don't have to clutter the platform_driver here
>=20
>  drivers/video/backlight/pwm_bl.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSZiukAAoJEN0jrNd/PrOhzQAP/iLUEn/uKNAz+jO/yLcMWSL8
PRy5JZblYrKimp8uQkWOgB0IOR7Cy8LgJ5keDhpZqwZbylWseCBeHarN1VZY5gDS
cvS3dVTh0L/G+bZmTC5Ohfsn/heuGOE5lNVvXHCYytDqLJroF/B1i/C4EZa+Ajrp
fjpSjet7y7uWP68yRNKNO6Xw2vkItQdG7vab4xfc5VLg7WwDzQIyOwtwbpR8Wz1M
dafwEdzqGiLFQprXcRp0fEybA4TGIBdIeQQ6nfiBDnxhSLu1RFUCra7QaIngeT/t
fLsZGs+jU5ssliwmpexd0ooldhIeRU/eN2x2BFpnTjn9QZ6JMNatxoxBH9HGEVjm
GhCg7ZE7kslwcEtGwKj8BvSU5vnXpyn8yfFTT/ONQ84KVZs3GB/rTv6M0MZTuRnO
s8aYTEwavIdidd82m3iQuEw/37RupbEEp+bLAE/hEyVjzdmwDx/BrbDCttKsMFZY
gnPYG6y5VPV6A/zvd2wuwZJtaW0+/i3OqBNryYh3JJxtoPNSqr1c9r4y53757h0q
A04IJ4XFfUsxUQ6tDFQ8EwUfZ4xdHlI+BC9KOHdUXsV1v1J5hwUszUrX5LoipcaZ
TdLPXP/LY8X6lmXJ8+EFW0wPjIa86RzDBpjKnaS0ogqxhhNwbnJqhNL2jhR2ka0X
r/eoedZNF69XTLupBpMC
=CLTF
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--
