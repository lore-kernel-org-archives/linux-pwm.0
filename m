From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: sprd: Add Spreadtrum PWM documentation
Date: Wed, 14 Aug 2019 09:51:34 +0800
Message-ID: <CAMz4kuJA+a=nzFRja4wRkfJu3Gzb0wnvaM8H4Ek9X5u8CNegPg@mail.gmail.com>
References: <f9d2c7cb01cbf31bf75c4160611fa1d37d99f355.1565703607.git.baolin.wang@linaro.org>
 <20190813141256.jnbrfld42rtigek3@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190813141256.jnbrfld42rtigek3@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>, linux-pwm@vger.kernel.org, DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

Hi Uwe,

On Tue, 13 Aug 2019 at 22:13, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Tue, Aug 13, 2019 at 09:46:40PM +0800, Baolin Wang wrote:
> > Add Spreadtrum PWM controller documentation.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> > Changes from v1:
> >  - Use assigned-clock-parents and assigned-clocks to set PWM clock pare=
nt.
> > ---
> >  Documentation/devicetree/bindings/pwm/pwm-sprd.txt |   38 ++++++++++++=
++++++++
> >  1 file changed, 38 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sprd.txt
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-sprd.txt b/Docum=
entation/devicetree/bindings/pwm/pwm-sprd.txt
> > new file mode 100644
> > index 0000000..e6cf312
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-sprd.txt
> > @@ -0,0 +1,38 @@
> > +Spreadtrum PWM controller
> > +
> > +Spreadtrum SoCs PWM controller provides 4 PWM channels.
> > +
> > +Required porperties:
>
> s/porperties/properties/

Sorry for typos, will fix in next version.

>
> > +- compatible : Should be "sprd,ums512-pwm".
> > +- reg: Physical base address and length of the controller's registers.
> > +- clocks: The phandle and specifier referencing the controller's clock=
s.
> > +- clock-names: Should contain following entries:
> > +  "pwmn": used to derive the functional clock for PWM channel n (n ran=
ge: 0 ~ 3).
> > +  "enablen": for PWM channel n enable clock (n range: 0 ~ 3).
> > +- assigned-clocks: Reference to the PWM clock entroes.
>
> s/entroes/entries/

Sure.

>
> > +- assigned-clock-parents: The phandle of the parent clock of PWM clock=
.
>
> I'm not sure you need to point out assigned-clocks and
> assigned-clock-parents as this is general clk stuff. Also I wonder if
> these should be "required properties".

I think I should describe any properties used by PWM node, like
'clocks' and 'clock-names' properties, though they are common clock
properties.
Yes, they are required. Thanks for your comments.

--=20
Baolin Wang
Best Regards
