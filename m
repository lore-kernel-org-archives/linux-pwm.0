From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 0/2] pwm-tiecap: Add support for AM654 SoCs
Date: Thu, 1 Nov 2018 10:56:40 +0100
Message-ID: <20181101095640.GA23707@ulmo>
References: <20181016060402.18756-1-vigneshr@ti.com>
 <20181016111541.GE8852@ulmo>
 <e3d4afac-edc3-3b2a-3c75-8eb307705dd4@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e3d4afac-edc3-3b2a-3c75-8eb307705dd4@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Andrew Davis <afd@ti.com>
List-Id: linux-pwm@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 31, 2018 at 07:02:23PM +0530, Vignesh R wrote:
> Hi Thierry,
>=20
> On 16/10/18 4:45 PM, Thierry Reding wrote:
> > On Tue, Oct 16, 2018 at 11:34:00AM +0530, Vignesh R wrote:
> >> Couple of patches to enable pwm-tiecap driver to be used with TI's new
> >> AM654 platforms.
> >>
> >> Vignesh R (2):
> >>   dt-bindings: pwm: tiecap: Add TI AM654 SoC specific compatible
> >>   pwm: Kconfig: Enable TI ECAP driver for ARCH_K3
> >>
> >>  Documentation/devicetree/bindings/pwm/pwm-tiecap.txt | 1 +
> >>  drivers/pwm/Kconfig                                  | 5 ++---
> >>  2 files changed, 3 insertions(+), 3 deletions(-)
> >=20
> > Applied, thanks.
> >=20
>=20
> I could not see this patch series in pwm tree here:
> https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.=
git
> Is this queued for v4.20?

I forgot to push out those patches to for-next. Done that now. It's
quite late for those to go in, but since these don't touch any code
it looks okay.

Thierry

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvazdUACgkQ3SOs138+
s6FFaA/8DhaXRA4Rhay0Y/7xnxiNrhzZwNegQ75Pi73yJHimZbJbYQ//a53aiB7J
/yaTC7Gvqd/QiVZ0CuzOBXVx1Lzo06mVDghQ/sscrG2KnrnozyNDbEFhAaZ6Y3yt
J8hLcwQ2oyBdQT9LBbAIljQsnhM1kQ9iieDDVHCfNzEvCjCw+Xplv4Nkn+aNw87f
Y9pxiqf5NWtxp0bRF2Awb/gBVhqSLGZ7fm3VrxOV9qm3cG/b04G7ZtA8NkXcihnh
Fp+pEqukEU2wE2X1i/Y2RjWr1xdHnx309YEvEqNF6xDVQ1LWpIBFIweDuKgkdd6L
D5z+u5WfxU2SgbLy+ukHGvrWPt7pwbLIUHfNu0nfGZxFGej8w6gZTp9F9FyiDVbv
fdusFth/BFW5BkpUGgCkJA052LD2bvrHNcR7xERTsfBybrt1AqRf+MnvoMnYwsUj
C5yduQ04he1w5yTHcrcfIBE6YdkL6Zrezb5zrF5x+06SvdBVvUa+WRprhWZAD24j
Q3tCSn02aRmYf9cF3WvYXMPBOKmvIuJ8EuYKMev3Y9zIuxuh9N3JbMHAJvLvOCF1
BdL/13CUonx/qQ6BamLRp0uOVOsQ9XPkf9lzUQa52dvIHLdqO9U/FXy+FuOAq6kA
60eepjPS93XO1J1z5345NnrmhwfMKOYH/V5Qii6zA5dDc8y2QzQ=
=PO6m
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
