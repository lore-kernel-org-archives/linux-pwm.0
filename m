From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4] pwm: add pwm driver for HiSilicon BVT SOCs
Date: Fri, 21 Oct 2016 09:34:57 +0200
Message-ID: <20161021073457.GF2670@ulmo.ba.sec>
References: <1476097516-164577-1-git-send-email-yuanjian12@hisilicon.com>
 <20161010215339.GA21660@rob-hp-laptop>
 <20161021072236.GD2670@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ls2Gy6y7jbHLe9Od"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36540 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752634AbcJUHfC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 21 Oct 2016 03:35:02 -0400
Content-Disposition: inline
In-Reply-To: <20161021072236.GD2670@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Jian Yuan <yuanjian12@hisilicon.com>, mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, xuejiancheng@hisilicon.com, kevin.lixu@hisilicon.com, jalen.hsu@hisilicon.com


--Ls2Gy6y7jbHLe9Od
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 21, 2016 at 09:22:36AM +0200, Thierry Reding wrote:
> On Mon, Oct 10, 2016 at 04:53:39PM -0500, Rob Herring wrote:
> > On Mon, Oct 10, 2016 at 07:05:16PM +0800, Jian Yuan wrote:
> > > From: yuanjian <yuanjian12@hisilicon.com>
> > >=20
> > > Add PWM driver for the PWM controller found on HiSilicon BVT SOCs, li=
ke Hi3519V100, Hi3516CV300, etc.
> > > The PWM controller is primarily in charge of controlling P-Iris lens.
> > >=20
> > > Reviewed-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
> > > Signed-off-by: Jian Yuan <yuanjian12@hisilicon.com>
> > > ---
> > > Change Log:
> > > v4:
> > > Add #pwm-cells in the bindings document.
> > > v3:
> > > fixed issues pointed by thierry.
> > > Add PWM compatible string for Hi3519V100.
> > > Implement .apply() function which support atomic, instead of .enable(=
)/.disable()/.config().
> > > v2:
> > > The number of PWMs is change to be probeable based on the compatible =
string.
> > >=20
> > >  .../devicetree/bindings/pwm/pwm-hibvt.txt          |  23 ++
> > >  drivers/pwm/Kconfig                                |   9 +
> > >  drivers/pwm/Makefile                               |   1 +
> > >  drivers/pwm/pwm-hibvt.c                            | 270 +++++++++++=
++++++++++
> > >  4 files changed, 303 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-hibvt.t=
xt
> > >  create mode 100644 drivers/pwm/pwm-hibvt.c
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt b/Do=
cumentation/devicetree/bindings/pwm/pwm-hibvt.txt
> > > new file mode 100644
> > > index 0000000..609284f
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
> > > @@ -0,0 +1,23 @@
> > > +Hisilicon PWM controller
> > > +
> > > +Required properties:
> > > +-compatible: should contain one SoC specific compatible string and o=
ne generic compatible
> > > +string "hisilicon, hibvt-pwm". The SoC specific strings supported in=
cluding:
> >=20
> > Extra space          ^
> >=20
> > With that, for the binding:
> >=20
> > Acked-by: Rob Herring <robh@kernel.org>
>=20
> I'm wondering what the use is of the generic compatible string? Not only
> is the driver not listing it, nor is it in any way useful since there is
> nothing the driver could do based on the generic compatible string (each
> version of the IP currently supported has a different number of PWM
> channels).

Actually it's worse. The driver does have an entry for the generic
compatible string but it doesn't assign .data in that case (which is
really what I was saying above). Now according to the bindings it is
disallowed to have only the generic compatible string, which is good
because doing so would crash the driver on probe.

So, if it's not allowed to have only the generic compatible string,
why even have one at all? We always have an SoC-specific compatible
string as well, so the generic one is completely redundant.

Thierry

--Ls2Gy6y7jbHLe9Od
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYCcUhAAoJEN0jrNd/PrOhMzgP/3gryYcYX1siXC5za2+ABQBg
3poIWY1L/YvjcXHfQm6UNE97JKByKmewWfaTbxAAHqNyfx8drnRV9YLMp+nhuOaV
ornh52CRQI7cfkmxPJSMuUwYP6oHNKZZI1NtZGBd+vjumpjLGDDMx8m0/jmKOcGX
lR9yQ8CYTEoFjzxIKa7I4mjt5j3iymtSfTpnGIpttjHdf3PE4LdQ1N/3MIp0Hsd7
Cr04wZ8TrRmpinkABKhtwuCAZRL1QVFJbMIP2gl065iOAYlzN+kQbKTIQSCe5EPe
2Jji1J4QdEOetZ9R8a2xk6NQNjwNb7v6jHpgAlKFWbVHMUCThtbsAkIyKADlEPMz
y0wHz90PepeYI/ehaF0eByAbQH6dzRsb86ZhtDfNe0vLYYX3X7PhMV93csX6P3wm
OVMwzMXY9bKB1kTwOkbXXLSTgUIJQ0qbiO66RRRcK9MPreXW3rgNi7m3tk8c81oV
HOQtqIRKv/sLMyKTRiH2TBQyY4BiYtJEwoMC+5NWZC8IGT/Nc6QOxGrCqFkAxRUs
1aCCVDSkg6YC5HDKIUqEefM4yBvPcrh6Yzeir11+bWGmd0WfWd7isQh+xA/Y78jw
ugQ1R98+VnbbdIa5NOLvsy/6gUywl2GXMnacE8PJkMa2tqKKk7VU5IzS6cjM5zCo
ICh/p8EhXMoasaw7RBUw
=i8yz
-----END PGP SIGNATURE-----

--Ls2Gy6y7jbHLe9Od--
