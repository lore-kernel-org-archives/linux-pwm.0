From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 4/7] pwm: rockchip: Move the configuration of polarity
 from rockchip_pwm_set_enable() to rockchip_pwm_config()
Date: Fri, 18 Aug 2017 17:40:21 +0200
Message-ID: <20170818154021.GE18307@ulmo>
References: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com>
 <1502206715-24174-5-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wTWi5aaYRw9ix9vO"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1502206715-24174-5-git-send-email-david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--wTWi5aaYRw9ix9vO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2017 at 11:38:32PM +0800, David Wu wrote:
> It is usually possible to configure the polarity, cycle and duty all at o=
nce,
> so that the polarity and cycle and duty should be binding together. Move =
it
> into rockchip_pwm_config(), as well as prepared for the next atomic update
> commit.
>=20
> Signed-off-by: David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
>  drivers/pwm/pwm-rockchip.c | 48 +++++++++++++++++++++++-----------------=
------
>  1 file changed, 24 insertions(+), 24 deletions(-)

Applied, thanks.

Thierry

--wTWi5aaYRw9ix9vO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmXCmUACgkQ3SOs138+
s6HSdQ/+IpHwBgUuZgXmzgIfXxQJB6K6KG4ou0Ei145FMYluN0qDa+q7QNfPBVsp
Al7lgowe8EWkJgSbdZPAFvHb0H1pdBY5rf2ZSxNnlCMkLEOBLfTSCCoLR5+CvaJn
aLpCK26+U3qIzVGc7Oo5nprvO8LiS04KvWJvH5Wy87vMti8eCwfvLmeq60pkQwgI
f9ih6OEvuEjQAWoEiDWfTf1l/2H1wlx840sN4f/HTjE0m+f/IvKGV1QBojyiAqu/
TESvblXGY4mh8mbaFeFYWQoWy9R5X7lAlQERf49Xi38mpk1v2koSuh0dVM3d6hcs
car2MzE6DfqlTgemAT4iwOxHM/vfyKn1kWgNpKeC6xQeDbSUN4EVvHTbSC+pN83b
eclxIWZ8B9NKYPTXERKtJINakp/UsoEH6c00IiglBs5l2fYKM8BYjVg6vzQWFgnu
vwhW+rimKfnhiQCRGG4sjM2AIvV3Ct9Q5RR6FmbZL/NaB/iKibZDvrGl3VxyZNo3
TdxZ5PraQv7h+Lwyb6Ey8ZD2J29N/V0plufDVradu9x0Lx3CMsX7sZng91VdKWfb
f0emSmOTb2Sh7e9W7Gvq6beG6r+a8W2lkU2FN5oN5dUyeggS+AEtiAInJM01z6C1
JhtlNb71zQrV4ys2ges0Lbg/rbkV2/p6+86RClKreAHHAVSOkxY=
=WpYz
-----END PGP SIGNATURE-----

--wTWi5aaYRw9ix9vO--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
