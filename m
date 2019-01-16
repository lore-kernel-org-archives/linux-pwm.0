From: Yash Shah <yash.shah@sifive.com>
Subject: Re: [PATCH 1/2] pwm: sifive: Add DT documentation for SiFive PWM Controller
Date: Wed, 16 Jan 2019 14:51:31 +0530
Message-ID: <CAJ2_jOGPpwsn=+OU3QcHtGYJ3MFYh9azdALSeWz3-WPXL9vHnw@mail.gmail.com>
References: <1547194964-16718-1-git-send-email-yash.shah@sifive.com>
 <1547194964-16718-2-git-send-email-yash.shah@sifive.com> <20190115201149.ghddnf27s5kqephc@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190115201149.ghddnf27s5kqephc@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>
List-Id: linux-pwm@vger.kernel.org

On Wed, Jan 16, 2019 at 1:41 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> this is v3, right? It is helpful to point this out to ease reviewing.

Yes, it is v3. Will take care of this in v4.

>
> On Fri, Jan 11, 2019 at 01:52:43PM +0530, Yash Shah wrote:
> > DT documentation for PWM controller added with updated compatible
> > string.
>
> Not sure what was updated here. But assuming this is compared to v2 this
> is not a helpful info in the commit log.

Ok, will remove the 'updated compatible string' part.

>
> > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> > [Atish: Compatible string update]
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > ---
> >  .../devicetree/bindings/pwm/pwm-sifive.txt         | 37 ++++++++++++++=
++++++++
> >  1 file changed, 37 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.tx=
t
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Doc=
umentation/devicetree/bindings/pwm/pwm-sifive.txt
> > new file mode 100644
> > index 0000000..e0fc22a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > @@ -0,0 +1,37 @@
> > +SiFive PWM controller
> > +
> > +Unlike most other PWM controllers, the SiFive PWM controller currently=
 only
> > +supports one period for all channels in the PWM. This is set globally =
in DTS.
> > +The period also has significant restrictions on the values it can achi=
eve,
> > +which the driver rounds to the nearest achievable frequency.
> > +
> > +Required properties:
> > +- compatible: Please refer to sifive-blocks-ip-versioning.txt
>
> While the description was too verbose in v2, this is too short. You
> should at least mention something like "sifive,pwmX" and
> "sifive,$cpuname-pwm" (or how ever that scheme works).

Will mention the above.

>
> > +- reg: physical base address and length of the controller's registers
> > +- clocks: Should contain a clock identifier for the PWM's parent clock=
.
> > +- #pwm-cells: Should be 2.
> > +  The first cell is the PWM channel number
> > +  The second cell is the PWM polarity
>
> I'd drop these two lines and refer to bindings/pwm/pwm.txt instead.

Will be done.

>
> > +- sifive,approx-period-ns: the driver will get as close to this period=
 as it can
>
> As already said for v2: I'd drop "approx-".

Sure, will be done.

>
> > +- interrupts: one interrupt per PWM channel
> > +
> > +PWM RTL that corresponds to the IP block version numbers can be found
> > +here:
> > +
> > +https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/dev=
ices/pwm
> > +
> > +Further information on the format of the IP
> > +block-specific version numbers can be found in
> > +Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.t=
xt
> > +
> > +Examples:
> > +
> > +pwm:  pwm@10020000 {
> > +     compatible =3D "sifive,fu540-c000-pwm","sifive,pwm0";
> > +     reg =3D <0x0 0x10020000 0x0 0x1000>;
> > +     clocks =3D <&tlclk>;
> > +     interrupt-parent =3D <&plic>;
> > +     interrupts =3D <42 43 44 45>;
> > +     #pwm-cells =3D <2>;
> > +     sifive,approx-period-ns =3D <1000000>;
> > +};
> > --
> > 1.9.1
> >
> >
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|

Thanks for the comments.
