From: Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v6 1/8] dt-bindings: pwm: allwinner: Add H6 PWM description
Date: Mon, 18 Nov 2019 13:57:02 +0100
Message-ID: <20191118125702.GK4345@gilmour.lan>
References: <20191118110034.19444-1-peron.clem@gmail.com>
 <20191118110034.19444-2-peron.clem@gmail.com>
 <20191118110640.GE4345@gilmour.lan>
 <CAJiuCceVyjSTGymOiXTZvyQXyXScGZuGS6gW+2=0gdxDFzg3dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6184067595748654436=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAJiuCceVyjSTGymOiXTZvyQXyXScGZuGS6gW+2=0gdxDFzg3dA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>, devicetree <devicetree@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>, linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Philipp Zabel <pza@pengutronix.de>, Rob Herring <robh@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org


--===============6184067595748654436==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="luUS5rQ1j20Qzq8E"
Content-Disposition: inline


--luUS5rQ1j20Qzq8E
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2019 at 01:42:48PM +0100, Cl=E9ment P=E9ron wrote:
> Hi Maxime
>
> On Mon, 18 Nov 2019 at 12:06, Maxime Ripard <mripard@kernel.org> wrote:
> >
> > Hi,
> >
> > On Mon, Nov 18, 2019 at 12:00:27PM +0100, Cl=E9ment P=E9ron wrote:
> > > From: Jernej Skrabec <jernej.skrabec@siol.net>
> > >
> > > H6 PWM block is basically the same as A20 PWM, except that it also has
> > > bus clock and reset line which needs to be handled accordingly.
> > >
> > > Expand Allwinner PWM binding with H6 PWM specifics.
> > >
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> > > ---
> > >  .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml | 48 +++++++++++++++++=
++
> > >  1 file changed, 48 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a1=
0-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.=
yaml
> > > index 0ac52f83a58c..1bae446febbb 100644
> > > --- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.y=
aml
> > > +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.y=
aml
> > > @@ -30,13 +30,51 @@ properties:
> > >        - items:
> > >            - const: allwinner,sun50i-h5-pwm
> > >            - const: allwinner,sun5i-a13-pwm
> > > +      - const: allwinner,sun50i-h6-pwm
> > >
> > >    reg:
> > >      maxItems: 1
> > >
> > >    clocks:
> > > +    minItems: 1
> > > +    maxItems: 2
> > > +    items:
> > > +      - description: Module Clock
> > > +      - description: Bus Clock
> > > +
> > > +  # Even though it only applies to subschemas under the conditionals,
> > > +  # not listing them here will trigger a warning because of the
> > > +  # additionalsProperties set to false.
> > > +  clock-names: true
> > > +
> > > +  resets:
> > >      maxItems: 1
> > >
> > > +  if:
> > > +    properties:
> > > +      compatible:
> > > +        contains:
> > > +          const: allwinner,sun50i-h6-pwm
> > > +
> > > +  then:
> > > +    properties:
> > > +      clocks:
> > > +        maxItems: 2
> > > +
> > > +      clock-names:
> > > +        items:
> > > +          - const: mod
> > > +          - const: bus
> > > +
> > > +    required:
> > > +      - clock-names
> > > +      - resets
> > > +
> > > +  else:
> > > +    properties:
> > > +      clocks:
> > > +        maxItems: 1
> > > +
> >
> > Sorry for not noticing this earlier, but this should be at the topmost
> > level
>
> No problem, but I don't get what you want, (yaml format is new for me).
> Do you mean I should put the if condition before the "resets" ?

No, here if we condense a bit the file, we have something like:

title: PWM

properties:
  compatible:
    ...

  ...

  resets:
    ...

  if:
    properties:
      ...

  then:
    properties:
      ...

which means that you expect that the node may contain a compatible
property, a resets one, and then two properties "if" and "then", which
in turn contain properties (ie, two nodes).

This is obviously not what you want, what you want instead is:

properties:
  compatible:
    ...

  ...

  resets:
    ...

if:
  properties:
    ...

then:
  properties:
    ...

Which then describes that there's two properties, compatible and
resets, and if the schema under 'if' is valid against the node we try
to validate, the schema under 'then' is used to validate the node as
well.

I hope it's clearer,
Maxime

--luUS5rQ1j20Qzq8E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXdKVHgAKCRDj7w1vZxhR
xRf+AQDIKDWmitZKrfNWWYoRdbyxBBWj5ixRoYR6aGpqSbCu9wEA5XGA6Ew4woTI
rOvVvGt0j8oafbBT1xQ/xkok13nHqAo=
=Y2SH
-----END PGP SIGNATURE-----

--luUS5rQ1j20Qzq8E--


--===============6184067595748654436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6184067595748654436==--
