From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4] pwm: add pwm driver for HiSilicon BVT SOCs
Date: Fri, 21 Oct 2016 09:22:36 +0200
Message-ID: <20161021072236.GD2670@ulmo.ba.sec>
References: <1476097516-164577-1-git-send-email-yuanjian12@hisilicon.com>
 <20161010215339.GA21660@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZJcv+A0YCCLh2VIg"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161010215339.GA21660@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Jian Yuan <yuanjian12-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xuejiancheng-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, kevin.lixu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, jalen.hsu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--ZJcv+A0YCCLh2VIg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 10, 2016 at 04:53:39PM -0500, Rob Herring wrote:
> On Mon, Oct 10, 2016 at 07:05:16PM +0800, Jian Yuan wrote:
> > From: yuanjian <yuanjian12-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
> >=20
> > Add PWM driver for the PWM controller found on HiSilicon BVT SOCs, like=
 Hi3519V100, Hi3516CV300, etc.
> > The PWM controller is primarily in charge of controlling P-Iris lens.
> >=20
> > Reviewed-by: Jiancheng Xue <xuejiancheng-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
> > Signed-off-by: Jian Yuan <yuanjian12-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
> > ---
> > Change Log:
> > v4:
> > Add #pwm-cells in the bindings document.
> > v3:
> > fixed issues pointed by thierry.
> > Add PWM compatible string for Hi3519V100.
> > Implement .apply() function which support atomic, instead of .enable()/=
=2Edisable()/.config().
> > v2:
> > The number of PWMs is change to be probeable based on the compatible st=
ring.
> >=20
> >  .../devicetree/bindings/pwm/pwm-hibvt.txt          |  23 ++
> >  drivers/pwm/Kconfig                                |   9 +
> >  drivers/pwm/Makefile                               |   1 +
> >  drivers/pwm/pwm-hibvt.c                            | 270 +++++++++++++=
++++++++
> >  4 files changed, 303 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
> >  create mode 100644 drivers/pwm/pwm-hibvt.c
> >=20
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt b/Docu=
mentation/devicetree/bindings/pwm/pwm-hibvt.txt
> > new file mode 100644
> > index 0000000..609284f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
> > @@ -0,0 +1,23 @@
> > +Hisilicon PWM controller
> > +
> > +Required properties:
> > +-compatible: should contain one SoC specific compatible string and one=
 generic compatible
> > +string "hisilicon, hibvt-pwm". The SoC specific strings supported incl=
uding:
>=20
> Extra space          ^
>=20
> With that, for the binding:
>=20
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

I'm wondering what the use is of the generic compatible string? Not only
is the driver not listing it, nor is it in any way useful since there is
nothing the driver could do based on the generic compatible string (each
version of the IP currently supported has a different number of PWM
channels).

Should I just remove that from the above text and the example?

Thierry

> > +	"hisilicon,hi3516cv300-pwm"
> > +	"hisilicon,hi3519v100-pwm"
> > +- reg: physical base address and length of the controller's registers.
> > +- clocks: phandle and clock specifier of the PWM reference clock.
> > +- resets: phandle and reset specifier for the PWM controller reset.
> > +- #pwm-cells: Should be 2. See pwm.txt in this directory for a descrip=
tion of
> > +  the cells format.
> > +
> > +Example:
> > +	pwm: pwm@12130000 {
> > +
> > +		compatible =3D "hisilicon,hi3516cv300-pwm", "hisilicon,hibvt-pwm";
> > +		compatible =3D "hisilicon,hi3519v100-pwm", "hisilicon,hibvt-pwm";
> > +		reg =3D <0x12130000 0x10000>;
> > +		clocks =3D <&crg_ctrl HI3516CV300_PWM_CLK>;
> > +		resets =3D <&crg_ctrl 0x38 0>;
> > +		#pwm-cells =3D <2>;
> > +	};

--ZJcv+A0YCCLh2VIg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYCcI7AAoJEN0jrNd/PrOhw60P/2OE0UjxIi6JObUxmOe8F5b+
JPKeu2G/L3byEp8Kz0bIcHNsEhX/Z2+Q895Zq9KiQFI7b6FhsX6ttx4eroMidqZG
hg9GHo4TCKENsk4TS314KroTIZAoQ1wpZ8VCu8bkguRZaHO/AqULNJdHt4CYanmi
w3VE3uMAAsuGTSL8+xg8HUdC/mbl6JTL9Lw0sCHO6XM3Rsm9lMUwVATNAdGEXqM+
epqIb6dtVhUSbOdvPXZKuum9EQK9UB65Xv7g4NC67lkxmf10LyHmLrmT1s9J9W8e
1mqjC1071boHrz+X/X+FIjST9TRiXHRmdr/KpxJ1ALluRUthhr046quID0Lido0V
CLBGeUayeaCfb6RN6661mqxIdkUaZGiQXwJ18/RVinknIl2p4qVfL3dmdZz3PCOL
hzxF59Zer82wjXDAzAmekOoC+uUdV7s3+f7FOjQ2v4kxBwGfdPsySDEf+A4ntYDn
/dkmYzcfSZlgnz0R2KvCip06RM+lnRw7j0tovD7R6Imrtd6WTeN23KikVDesdLml
KenQx1Tzh7u4AZLf9IMZxiG7o9H3aRXxevoadz5UHDoEVPVGBjWHou1++zkCXgXu
DhgFE3KqEDqeNe4jfC1SYw7Jh+Ue766+WB+I7eGwkXtKUeQVPSiugiiXCTUQ+CIC
/6+9awoX/Dp72qoQMoVI
=vQtk
-----END PGP SIGNATURE-----

--ZJcv+A0YCCLh2VIg--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
