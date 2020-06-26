From: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Subject: Re: [RFC PATCH 07/10] dt-bindings: rtc: Add bindings for Netronix
 embedded controller RTC
Date: Fri, 26 Jun 2020 23:55:52 +0200
Message-ID: <20200626235552.7820a999@kemnade.info>
References: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
        <20200620224222.1312520-6-j.neuschaefer@gmx.net>
        <20200621000220.GB131826@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200621000220.GB131826-m++hUPXGwpdeoWH0uzbU5w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Cc: Jonathan =?ISO-8859-1?Q?Neusch=E4fer?= <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Pengutronix Kernel Team <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, NXP Linux Team <linux-imx-3arQi8VN3Tc@public.gmane.org>, Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko.stuebner-SN7IsUiht6C/RdPyistoZJqQE7yCjDx5@public.gmane.org>, Stephan Gerhold <stephan-3XONVrnlUWDR7s880joybQ@public.gmane.org>, Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, allen <allen.ch>
List-Id: linux-pwm@vger.kernel.org

On Sun, 21 Jun 2020 02:02:20 +0200
Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org> wrote:

> Hi,
>=20
> On 21/06/2020 00:42:18+0200, Jonathan Neusch=E4fer wrote:
> > The Netronix EC implements an RTC with the following functionality:
> >=20
> > - Calendar-based time keeping with single-second resolution
> > - Automatic power-on with single-minute resolution
> > - Alarm at single-second resolution
> >=20
> > This binding only supports timekeeping for now.
> >=20
> > Signed-off-by: Jonathan Neusch=E4fer <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>
> > ---
> >  .../bindings/mfd/netronix,ntxec.yaml          |  7 +++++
> >  .../bindings/rtc/netronix,ntxec-rtc.yaml      | 27 +++++++++++++++++++
> >  2 files changed, 34 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/rtc/netronix,ntxe=
c-rtc.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml =
b/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> > index 6562c41c5a9a9..f6a32f46f47bb 100644
> > --- a/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> > @@ -34,6 +34,9 @@ properties:
> >    pwm:
> >      $ref: ../pwm/netronix,ntxec-pwm.yaml
> >=20
> > +  rtc:
> > +    $ref: ../rtc/netronix,ntxec-rtc.yaml
> > + =20
>=20
> Shouldn't the node simply be documented here?
>=20
> Also, do you really need a compatible string to be able to proe the
> driver? What are the chances that you'll get a similar EC without an
> RTC?
>=20
Tolino Shine 2 HD has the mentioned EC but the vendor kernel does not use
its RTC (not checked whether it is present or functional).
As a key for grepping in the vendor sources:=20
gptNtxHwCfg->m_val.bPCB =3D 0x50

Tolino Shine 3  and Kobo Clara HD do not have that EC.

Regrads,
Andreas
