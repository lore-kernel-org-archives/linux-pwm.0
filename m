From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: Kconfig: Enable pwm-tiecap to be built for Keystone
Date: Mon, 21 Aug 2017 08:05:54 +0200
Message-ID: <20170821060554.GD18996@ulmo>
References: <20170802061344.1713-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4zI0WCX1RcnW9Hbu"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35529 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbdHUGF5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Aug 2017 02:05:57 -0400
Content-Disposition: inline
In-Reply-To: <20170802061344.1713-1-vigneshr@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2017 at 11:43:44AM +0530, Vignesh R wrote:
> 66AK2G SoC has ECAP subsystem that is used as pwm-backlight provider for
> display. Hence, enable pwm-tiecap driver to be built for Keystone
> architecture.
>=20
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/pwm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-4.14/drivers, thanks.

Thierry

--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmaeEIACgkQ3SOs138+
s6HA5g/9G5jhtrMK/5elTPbk6snW8iHWP6X+CvOPKp0pWMQvR4P7alBaEvvkY8lq
Fre2M/n6KdXP4MmxAdC3+Pg64N/TuzYW2CN/khJR4mL1v7l28mUEe/8y5/djfHXT
93wNRYupsde8y+lefIRVU7lUR50jptBtl+bs7+NUUBiwpG8Eh6doJP72VSejkcHX
3u9KWTlqu+57rlJx4zUgKIpel6JGhFE46Srmz/7ci7Wfr82iDCCI8vnPvAkyi/fy
gqgb/i6nrLZ7o3Ndm1a3EiONem1Xai/miuknvRO+hZxq5E4mTZl3k9RKGCcXbg0l
7cY5x/cGl5npSXm7eAbKAVNXUiF1TJ1IgyAfyCG8oh3zNIREmPJxpgTCYNtlQtK4
nHudgCJ4l74NCVNHE37zyvGslcNFon3wjTvST6NzzhOAsMuyWO7Eu5twLfayMHHX
eN0IFU8u6WsSMswqzHbSCumfkIZsxrXQv10lGwQKVnS0nXEnG377xYO7imt4nCnr
y90Oemn/k1TeUN1j5xnuY2BVC9/WP/FzbVq8+5l84TB8BDWms8iwVw/IWjs13ciw
eBrpyGwz8BKdupjgKwMYlNq05w30ETQV5VDsBvVH3zkDBrkxVMqNEkDCBDCRQAEe
4kj1ZVVPan5bIKY/jGiwnhSYImV2t33KTMNug3U4Nj37DvXkC8w=
=bJHh
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--
