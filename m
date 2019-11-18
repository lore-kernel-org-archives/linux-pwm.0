From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 1/8] dt-bindings: pwm: allwinner: Add H6
 PWM description
Date: Mon, 18 Nov 2019 14:23:05 +0100
Message-ID: <CAJiuCcfBurkmX-6j9T2JHsdUw+RGCnuBSYCpo5BG+V-H-mcLUw@mail.gmail.com>
References: <20191118110034.19444-1-peron.clem@gmail.com> <20191118110034.19444-2-peron.clem@gmail.com>
 <20191118110640.GE4345@gilmour.lan> <CAJiuCceVyjSTGymOiXTZvyQXyXScGZuGS6gW+2=0gdxDFzg3dA@mail.gmail.com>
 <20191118125702.GK4345@gilmour.lan>
Reply-To: peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCELXIX7UICBBRVWZLXAKGQE6U7NAZA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20191118125702.GK4345-2DbqMqoCcjvhXIiyNabO3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Philipp Zabel <pza-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hi,

On Mon, 18 Nov 2019 at 13:57, Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
> On Mon, Nov 18, 2019 at 01:42:48PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi Maxime
> >
> > On Mon, 18 Nov 2019 at 12:06, Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > >
> > > Hi,
> > >
> > > On Mon, Nov 18, 2019 at 12:00:27PM +0100, Cl=C3=A9ment P=C3=A9ron wro=
te:
> > > > From: Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
> > > >
> > > > H6 PWM block is basically the same as A20 PWM, except that it also =
has
> > > > bus clock and reset line which needs to be handled accordingly.
> > > >
> > > > Expand Allwinner PWM binding with H6 PWM specifics.
> > > >
> > > > Signed-off-by: Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
> > > > Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > > ---
> > > >  .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml | 48 +++++++++++++++=
++++
> > > >  1 file changed, 48 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-=
a10-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pw=
m.yaml
> > > > index 0ac52f83a58c..1bae446febbb 100644
> > > > --- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm=
.yaml
> > > > +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm=
.yaml
> > > > @@ -30,13 +30,51 @@ properties:
> > > >        - items:
> > > >            - const: allwinner,sun50i-h5-pwm
> > > >            - const: allwinner,sun5i-a13-pwm
> > > > +      - const: allwinner,sun50i-h6-pwm
> > > >
> > > >    reg:
> > > >      maxItems: 1
> > > >
> > > >    clocks:
> > > > +    minItems: 1
> > > > +    maxItems: 2
> > > > +    items:
> > > > +      - description: Module Clock
> > > > +      - description: Bus Clock
> > > > +
> > > > +  # Even though it only applies to subschemas under the conditiona=
ls,
> > > > +  # not listing them here will trigger a warning because of the
> > > > +  # additionalsProperties set to false.
> > > > +  clock-names: true
> > > > +
> > > > +  resets:
> > > >      maxItems: 1
> > > >
> > > > +  if:
> > > > +    properties:
> > > > +      compatible:
> > > > +        contains:
> > > > +          const: allwinner,sun50i-h6-pwm
> > > > +
> > > > +  then:
> > > > +    properties:
> > > > +      clocks:
> > > > +        maxItems: 2
> > > > +
> > > > +      clock-names:
> > > > +        items:
> > > > +          - const: mod
> > > > +          - const: bus
> > > > +
> > > > +    required:
> > > > +      - clock-names
> > > > +      - resets
> > > > +
> > > > +  else:
> > > > +    properties:
> > > > +      clocks:
> > > > +        maxItems: 1
> > > > +
> > >
> > > Sorry for not noticing this earlier, but this should be at the topmos=
t
> > > level
> >
> > No problem, but I don't get what you want, (yaml format is new for me).
> > Do you mean I should put the if condition before the "resets" ?
>
> No, here if we condense a bit the file, we have something like:
>
> title: PWM
>
> properties:
>   compatible:
>     ...
>
>   ...
>
>   resets:
>     ...
>
>   if:
>     properties:
>       ...
>
>   then:
>     properties:
>       ...
>
> which means that you expect that the node may contain a compatible
> property, a resets one, and then two properties "if" and "then", which
> in turn contain properties (ie, two nodes).
>
> This is obviously not what you want, what you want instead is:
>
> properties:
>   compatible:
>     ...
>
>   ...
>
>   resets:
>     ...
>
> if:
>   properties:
>     ...
>
> then:
>   properties:
>     ...
>
> Which then describes that there's two properties, compatible and
> resets, and if the schema under 'if' is valid against the node we try
> to validate, the schema under 'then' is used to validate the node as
> well.
>
> I hope it's clearer,

Yes it's totally clear didn't see this bad indentation,
Thanks for the catch and for the explanation.

Regards,
Cl=C3=A9ment

> Maxime

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To view this discussion on the web, visit https://groups.google.com/d/msgid=
/linux-sunxi/CAJiuCcfBurkmX-6j9T2JHsdUw%2BRGCnuBSYCpo5BG%2BV-H-mcLUw%40mail=
.gmail.com.
