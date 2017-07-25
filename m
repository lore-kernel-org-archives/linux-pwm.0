From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v1] pwm: pca9685: clarify pca9685_set_sleep_mode()
 interface.
Date: Tue, 25 Jul 2017 13:42:17 +0200
Message-ID: <20170725114217.GB22355@ulmo>
References: <1492780742-11251-1-git-send-email-thesven73@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1492780742-11251-1-git-send-email-thesven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sven Van Asbroeck <thesven73@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com
List-Id: linux-pwm@vger.kernel.org


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 21, 2017 at 09:19:02AM -0400, Sven Van Asbroeck wrote:
> The function
> static void pca9685_set_sleep_mode(struct pca9685 *pca, int sleep)
> takes the chip in and out of sleep mode, depending on the value of
> sleep, which is interpreted as a boolean.
>=20
> To clarify that 'int sleep' is a boolean and not a sleep delay,
> change the function interface to:
> static void pca9685_set_sleep_mode(struct pca9685 *pca, bool enable)
>=20
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Sven Van Asbroeck <thesven73@gmail.com>
> ---
>  drivers/pwm/pwm-pca9685.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Applied, thanks.

Thierry

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAll3LpkACgkQ3SOs138+
s6G6ag/+Nq26wrIKBxBIs+RQdlriSEytWjOpH/MEV3qj03RIouGN4QAR0bPNl3oV
Swx2rviFNN/U6+A0tqWuLPftEezNl0LzXgXJBMaP+py7TJfqvfFBIwjs/5CZyStS
WC1tWrHOm5wqlI1AE+HDwUW2IU9/AIvSDq01BXRXSI/Xah74CbBuE8qna81nfTbu
uhVp72PkPtp9kIVUF20N04ogYWVR0GDfM9MsDMz4FHf7DibrvCl5LFWe1Pv8kTXL
u51h5Wfhst+2upY2UrzJpWzo+T0aTH5ohHbjBfOSSsIQD7tbHDysEV0wOe9QoXKy
3EwRUXmdw2cfLhy6tJgiwzdh+mFGVW6mO4mdcF7M2OqWXFsE8X2RNVDHnnrCuspI
PMhalNBg8IIJLqrVMAs00foh0UFuVeRjlLQwSm7p7PQcGvOd8NFMJnFabB4r4hMn
Tf19J6p6OuRi7kHkfQV+OkYfUCHY0Jemaomw2TFOlOxpmDf17bZACLa0W2VJqh32
7847EiakVdBvzSHOAmCG33LsK1JqMwx3PbP2uOo5S1/Xc0BR3v2OhjvEPOMoPy+M
mQO/X3wJiTcmMi44EHQ/wZ8ilqo4qr/seHPvgbWooYxVkswiknb6kzJ6BNaKg29p
DHOeclc78NS9jmgkuG2dvOQPI+KESNesrX/rqksDpyloX8Zugfo=
=0nzv
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
